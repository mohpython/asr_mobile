import 'package:asr_app/login.dart';
import 'package:flutter/material.dart';
import 'package:asr_app/bako_api/user.dart' show createReaderAccount;

class Inscription extends StatelessWidget {
  const Inscription({super.key});

  void _signup(BuildContext context, String username, String password, {String? firstname, String? surname}) async {
    // Check if username or password is empty
    if (username.isEmpty || password.isEmpty) {
      // Show a SnackBar informing the user to provide both username and password
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both username and password."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return; // Exit the function early
    }
    // Account creation
    await createReaderAccount(username, password,
        firstname: firstname, surname: surname).then((Map<String, dynamic>? response) {
              if (response == null) {
                print("Unsuccessful server resquest");
              }
              else if (response["status"]) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()),);
              }
              else if (!response["status"]){
                print("Login was not successful due to user error ${response["msg"]}");
                // Show a SnackBar with the message from the server
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Login failed: ${response["msg"]}"),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 5),
                  ),
                );
              }
            }
            ); // End then()
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController surnameController = TextEditingController();

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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50,),
            const Text("Sign up",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              
            ),
            ),
            const SizedBox(height: 50,),
            TextField(
              controller: firstnameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.deepPurple,),
                hintText: "Firstname (Optional)",
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
            const SizedBox(height: 40,),
           TextField(
             controller: surnameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.deepPurple,),
                hintText: "Surname (Optinal)",
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
            const SizedBox(height: 40,),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail, color: Colors.deepPurple,),
                hintText: "Username*",
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
            const SizedBox(height: 40,),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black),
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
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
             const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => _signup(context, usernameController.text, passwordController.text,
                    firstname: firstnameController.text, surname: surnameController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.white, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              
              const SizedBox(height: 20,)
          
          ],),
        ),
      ),
    );
  }
}