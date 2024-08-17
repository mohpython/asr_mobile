import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:asr_app/book.dart' show getBook;
import 'package:asr_app/bako_api/asr_model.dart' show inferenceASRModel;
import 'package:asr_app/bako_api/lesson.dart';
import 'package:time/time.dart';

class LessonScreen extends StatefulWidget {
  Map<String, dynamic> userdata;
  String bookTitle;

  LessonScreen({super.key, required this.userdata, required this.bookTitle});

  @override
  LessonScreenState createState() => LessonScreenState();
}

class LessonScreenState extends State<LessonScreen> {
  final Record _audioRecorder = Record();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // State changing variables
  bool isRecording = false;
  bool hasRecording = false;
  bool isInProgress = false;
  bool hasTranscription = false;
  bool lastPage = false;
  bool _sending = false;
  // lessonScreen components variables
  String? _filePath;
  Map<String, dynamic>? bookData;
  List<String> currentSentences = [];
  int currentPage = 0;
  int currentSentenceIndex = 0;
  String currentSentence = '';
  List<TextSpan> currentTextSpans = []; // State variable for TextSpans
  // Duration measurement variables
  int readingTime = 0; // Time passed on this book
  DateTime? startTime;


  @override
  void initState() {
    super.initState();
    setupLesson();
  }

  Future<void> setupLesson() async {
    Map<String, dynamic>? response = await getBook(widget.bookTitle);
    if (response != null) {
      setState(() {
        bookData = response;
        setupInitialPageAndSentence();
      });
    } else {
      // Handle error if book data cannot be retrieved
    }
  }

  void setupInitialPageAndSentence() {
    isInProgress = widget.userdata['in_progress_books']
        .any((book) => book.keys.first == widget.bookTitle);

    if (isInProgress) {
      Map<String, dynamic> bookProgress = widget.userdata['in_progress_books']
          .firstWhere((book) => book.keys.first == widget.bookTitle);

      String bookMarkAt = bookProgress[widget.bookTitle] ?? 'Page 1';
      currentPage = int.parse(bookMarkAt.split(' ')[1]);
      if (currentPage == bookData!['content'].keys.length){
        lastPage = true;
      }
      // Set reading time
      readingTime = bookProgress["reading_time"] ?? 0;
    } else {
      currentPage = 1;
    }

    currentSentences = List<String>.from(
        bookData!['content']['Page $currentPage'] ?? []);
    currentSentence = currentSentences.isNotEmpty
        ? currentSentences[currentSentenceIndex]
        : '';

    // Initialize currentTextSpans with the current sentence
    currentTextSpans = [TextSpan(text: currentSentence)];
    startTime = DateTime.now();
  }

  Future<void> startRecording() async {
    if (await _audioRecorder.hasPermission()) {
      await _audioRecorder.start(
        encoder: AudioEncoder.wav, // or AudioEncoder.flac
        bitRate: 128000, // Optional: set bitrate (default value)
        samplingRate: 44100, // Optional: set sample rate (default value)
          );
      setState(() {
        isRecording = true;
        hasRecording = false;
        if (hasTranscription){
          hasTranscription = false;
        }
      });
    }
  }

  Future<void> stopRecording() async {
    _filePath = await _audioRecorder.stop();
    setState(() {
      isRecording = false;
      hasRecording = _filePath != null;
    });
  }

  Future<void> playRecording() async {
    if (hasRecording) {
      await _audioPlayer.play(DeviceFileSource(_filePath!));
    }
  }

  void sendAudioToASR() async {
    // Set loading status to show progress Indicator
    setState(() {
      _sending = true;
    });

    String? transcription = await inferenceASRModel(_filePath!);
    if (transcription != null) {
      List<TextSpan> highlightedSpans = getHighlightedTextSpans(transcription);

      setState(() {
        hasTranscription = true; // Set to true once transcription is processed
        currentTextSpans = highlightedSpans; // Update state variable
        _sending = false;
      });
    }
  }

  List<TextSpan> getHighlightedTextSpans(String transcription) {
    List<String> originalWords = currentSentence.split(' ');
    List<String> transcribedWords = transcription.split(' ');

    // Highlighting logic
    List<TextSpan> highlightedSpans = [];
    for (var word in originalWords) {
      bool isCorrect = transcribedWords.contains(word);
      highlightedSpans.add(TextSpan(
        text: '$word ',
        style: TextStyle(
          color: isCorrect ? Colors.green : Colors.red,
        ),
      ));
    }

    return highlightedSpans;
  }

  void moveToNextSentence() {
    setState(() {
      currentSentenceIndex += 1;
      if (currentSentenceIndex < currentSentences.length) {
        currentSentence = currentSentences[currentSentenceIndex];
      } else {
        currentSentenceIndex = 0;
        currentPage += 1;
        currentSentences = List<String>.from(bookData!['content']['Page $currentPage']);
        currentSentence = currentSentences[currentSentenceIndex];
        if (currentPage == bookData!['content'].keys.length){
          lastPage = true;
        }
      }
      hasTranscription = false;
      hasRecording = false;
      currentTextSpans = [TextSpan(text: currentSentence)]; // Reset to default sentence
    });
  }

  Future<void> bookmarkCurrentPageAndExit(BuildContext context) async {
    // Avoid unnecessary call for bookmarking
    if (isInProgress){
      Map<String, dynamic> bookProgress = widget.userdata['in_progress_books']
          .firstWhere((book) => book.keys.first == widget.bookTitle);
      String currentBookmark = bookProgress[widget.bookTitle];
      if (currentBookmark == 'Page $currentPage'){
        Navigator.pop(context);
        return;
      }
    }
    // Calculate duration
    Duration duration = DateTime.now().difference(startTime!);
    readingTime = readingTime + duration.inSeconds;

    // Set loading status to show progress Indicator
    setState(() {
      _sending = true;
    });
    Map<String, dynamic>? response = await bookmark(widget.userdata['username'],
        widget.bookTitle, 'Page $currentPage', readingTime);
    if (response != null && response["status"]) {
      setState(() {
        _sending = false;
      });

      Map<String, dynamic>? updatedUserData = response["data"];
      Navigator.pop(context, updatedUserData);
    } else {
      // Handle error if book data cannot be retrieved
    }
  }

  Future<void> endLesson(BuildContext context) async {
    // Calculate duration
    Duration duration = DateTime.now().difference(startTime!);
    readingTime = readingTime + duration.inSeconds;
    int readingTimeInMinutes = readingTime.seconds.inMinutes;

    // Set loading status to show progress Indicator
    setState(() {
      _sending = true;
    });

    Map<String, dynamic>? response = await markBookAsCompleted(widget.userdata["username"], widget.bookTitle, readingTimeInMinutes);
    if (response != null && response["status"]){
      setState(() {
        _sending = false;
      });

      Map<String, dynamic>? updatedUserData = response["data"];
      int xpGained = updatedUserData!["reader_xp"] - widget.userdata["reader_xp"];
      int totalBookWordCount = bookData!["content"].values
          .expand((pageContent) => pageContent as Iterable<dynamic>) // Flatten the lists of sentences into a single Iterable<String>
          .map((sentence) => sentence.split(' ').length) // Get word count for each sentence
          .reduce((sum, count) => sum + count); // Sum up the word counts
      double wordPerMin = totalBookWordCount / readingTimeInMinutes;

      // Show a dialog to congratulate the user
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Congratulations!'),
            content: Text('You gained $xpGained XP from this lesson. The book was completed in $readingTimeInMinutes minutes, with an average reading speed of $wordPerMin words per minute.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Close the dialog and return to HomeScreen
                  Navigator.pop(context); // This closes the dialog
                  Navigator.pop(context, updatedUserData); // This pops the screen
                },
                child: const Icon(
                    Icons.home,
                  color: Colors.purple,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () => bookmarkCurrentPageAndExit(context),
            icon: const Icon(Icons.bookmark),
          )
        ],
        title: Text(widget.bookTitle, style: const TextStyle(fontSize: 20)),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (isRecording)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                      child: IconButton(
                        icon: const Icon(Icons.stop),
                        iconSize: 60,
                        color: Colors.grey,
                        onPressed: stopRecording,
                      )
                  )
                else if (hasRecording)
                  Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        child: IconButton(
                          icon: const Icon(Icons.mic),
                          iconSize: 60,
                          color: Colors.grey,
                          onPressed: startRecording,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: playRecording,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.play_arrow, color: Colors.purple),
                              SizedBox(width: 10),
                              Text(
                                "Play Recording",
                                style: TextStyle(color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: IconButton(
                      icon: const Icon(Icons.mic),
                      iconSize: 60,
                      color: Colors.grey,
                      onPressed: startRecording,
                    ),
                  ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    children: currentTextSpans, // Use state-dependent variable
                  ),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    // Add functionality for volume up button
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
              value: currentPage / (bookData!['content'].keys.length), // Calculate progress
            ),
          ),
          if (hasRecording)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: hasTranscription ? moveToNextSentence : sendAudioToASR,
                backgroundColor: Colors.white,
                child: Icon(
                    hasTranscription ? Icons.next_plan : Icons.send,
                    color: Colors.purple,
                  ),
              ),
            ),
          if (lastPage && hasTranscription && currentSentenceIndex == currentSentences.length - 1)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () => endLesson(context),
                backgroundColor: Colors.white,
                child: const Icon(
                    Icons.last_page,
                  color: Colors.purple,
                )
              ),
            ),
          if (_sending)
            const Center(child: CircularProgressIndicator(),),
        ],
      ),
    );
  }
}
