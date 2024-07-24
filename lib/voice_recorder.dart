import 'package:flutter/material.dart';

class VoiceRecorder extends StatefulWidget {
  @override
  _VoiceRecorderState createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> {
  bool isRecording = false;
  bool hasRecording = false;

  void startRecording() {
    setState(() {
      isRecording = true;
      hasRecording = false;
    });
  }

  void stopRecording() {
    setState(() {
      isRecording = false;
      hasRecording = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Story Title',
          
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (isRecording)
                  IconButton(
                    icon: Icon(Icons.stop),
                    iconSize: 100,
                    color: Colors.purple,
                    onPressed: stopRecording,
                  )
                else if (hasRecording)
                  Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: IconButton(
                          icon: Icon(Icons.mic),
                          iconSize: 100,
                          color: Colors.purple,
                          onPressed: startRecording,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow, color: Colors.purple),
                            SizedBox(width: 10),
                            Text(
                              "0:03",
                              style: TextStyle(color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: IconButton(
                      icon: Icon(Icons.mic),
                      iconSize: 100,
                      color: Colors.purple,
                      onPressed: startRecording,
                    ),
                  ),
                SizedBox(height: 20),
                Text('Sentence to read'),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
               
              },
              child: Icon(Icons.send),
              backgroundColor: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
