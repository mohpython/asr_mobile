import 'package:asr_app/login.dart';
import 'package:flutter/material.dart';

class Inscription extends StatelessWidget {
  const Inscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 200, 194, 203), Color.fromARGB(255, 149, 147, 149)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50,),
            Text("Inscription",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              
            ),
            ),
            SizedBox(height: 50,),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.deepPurple,),
                hintText: "Firstname",
                hintStyle: TextStyle(color:Colors.black),
                filled: true,
                  fillColor: Colors.transparent,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
              ),
            ),
            SizedBox(height: 40,),
           TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.deepPurple,),
                hintText: "Surname",
                hintStyle: TextStyle(color:Colors.black),
                filled: true,
                  fillColor: Colors.transparent,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
              ),
            ),
            SizedBox(height: 40,),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail, color: Colors.deepPurple,),
                hintText: "Username",
                hintStyle: TextStyle(color:Colors.black),
                filled: true,
                  fillColor: Colors.transparent,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
              ),
            ),
            SizedBox(height: 40,),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.deepPurple,),
                hintText: "Password",
                hintStyle: TextStyle(color:Colors.black),
                filled: true,
                  fillColor: Colors.transparent,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
              ),
            ),
            
             SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                 },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(color: Colors.white, width: 2),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'S\'inscrire',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              
              SizedBox(height: 20,)
          
          ],),
        ),
      ),
    );
  }
}