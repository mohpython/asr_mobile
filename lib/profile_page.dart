import 'package:flutter/material.dart';
import 'package:asr_app/bako_api/user.dart' show editPassword, editUsername, deleteAccount;
import 'package:asr_app/login.dart';

class ProfilePage extends StatefulWidget {
  Map<String, dynamic> userData;

  ProfilePage({super.key, required this.userData});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool _sending = false;

  Future<void> _changeUsername(BuildContext context) async {
    TextEditingController newUsernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Username'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newUsernameController,
                decoration: const InputDecoration(labelText: 'New Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if ( newUsernameController.text.isEmpty || passwordController.text.isEmpty) {
                  // Show a SnackBar informing the user to provide both username and password
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("New Username and password are required."),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ),
                  );
                  return; // Exit the function early
                }
                Navigator.of(context).pop();

                // Set loading status to show progress Indicator
                setState(() {
                  _sending = true;
                });
                 await editUsername(widget.userData['username'], newUsernameController.text, passwordController.text,
                 ).then((Map<String, dynamic>? response) {
                   setState(() {
                     _sending = false;
                   });
                  if (response == null) {
                    print("Unsuccessful request");
                  }
                  else if (response["status"]){
                    setState(() {
                      widget.userData['username'] = response["data"]['username'];
                    });
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(content: Text('Username changed successfully!')),
                    );
                  } else if (!response["status"]){
                    print("Unable to change username ${response["msg"]}");
                    // Show a SnackBar with the message from the server
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text("Unable to change username: ${response["msg"]}"),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                 });
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
              ),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (currentPasswordController.text.isEmpty || newPasswordController.text.isEmpty) {
                  // Show a SnackBar if current or new password is not provided
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Current and new passwords are required."),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ),
                  );
                  return;
                }
                Navigator.of(context).pop();
                // Set loading status to show progress Indicator
                setState(() {
                  _sending = true;
                });
                await editPassword(widget.userData['username'], currentPasswordController.text, newPasswordController.text,
                ).then((Map<String, dynamic>? response) {
                  setState(() {
                    _sending = false;
                  });
                  if (response == null) {
                    print("Unsuccessful request");
                  } else if (response["status"]) {
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(content: Text('Password changed successfully!')),
                    );
                  } else if (!response["status"]) {
                    print("Unable to change password ${response["msg"]}");
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text("Unable to change password: ${response["msg"]}"),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                });
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    TextEditingController passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (passwordController.text.isEmpty) {
                  // Show a SnackBar if password is not provided
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password is required."),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ),
                  );
                  return;
                }
                Navigator.of(context).pop();
                // Set loading status to show progress Indicator
                setState(() {
                  _sending = true;
                });
                await deleteAccount(widget.userData['username'], passwordController.text,
                ).then((Map<String, dynamic>? response) {
                  setState(() {
                    _sending = false;
                  });
                  if (response == null) {
                    print("Unsuccessful request");
                  } else if (response["status"]) {
                    // Navigate to LoginPage and clear the stack
                    Navigator.pushAndRemoveUntil(
                      this.context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                          (Route<dynamic> route) => false, // Remove all routes
                    );
                  } else if (!response["status"]) {
                    print("Unable to delete account ${response["msg"]}");
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text("Unable to delete account: ${response["msg"]}"),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                });
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.userData['username'];
    int level = widget.userData['reader_xp'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bako Reading App'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, widget.userData["username"]);
          },
        ),
        backgroundColor: Colors.purple.shade50,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.purple.shade100,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$level XP',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              if (_sending)
                const Center(child: CircularProgressIndicator(),),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _changeUsername(context);
                },
                icon: const Icon(Icons.edit),
                label: const Text('Change Username'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade100,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _changePassword(context);
                },
                icon: const Icon(Icons.edit),
                label: const Text('Change Password'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade100,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _deleteAccount(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}