import 'package:asr_app/voice_recorder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  VoiceRecorder(),
    );
  }
}
class Myscreen extends StatefulWidget {
  const Myscreen({super.key});

  @override
  State<Myscreen> createState() => _MyscreenState();
}

class _MyscreenState extends State<Myscreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("BambaraASR"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Username"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){},
             child: Text("se connecter")),
             SizedBox(height: 20,),
             ElevatedButton(onPressed: (){}, child: Text("")),
            
            Text("data")
          ],
        ),
      ),

    );
  }
}

