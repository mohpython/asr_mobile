import 'package:flutter/material.dart';

class EndLessonScreen extends StatelessWidget {
  Map<String, dynamic> userdata;
  String bookTitle;

  EndLessonScreen({super.key, required this.userdata, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Story Title",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, color: Colors.black),
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.purple.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: IconButton(
                  icon: const Icon(Icons.mic),
                  iconSize: 60,
                  color: Colors.purple,
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Sentence to read Sentence to read with correct pronounced words highlighted",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(Icons.volume_up, color: Colors.purple, size: 40),
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
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
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text(
                      "An ka taa",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
