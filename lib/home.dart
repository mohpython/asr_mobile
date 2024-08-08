import 'package:asr_app/constant.dart' show books;
import 'package:asr_app/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:asr_app/session.dart';
import 'package:asr_app/login.dart';
import 'package:asr_app/profile_page.dart';
import 'package:collection/collection.dart' show ListEquality;

class HomePage extends StatefulWidget {
  Map<String, dynamic> userdata;

  HomePage({super.key, required this.userdata});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<dynamic> inProgressBooks = [];
  List<dynamic> completedBooks = [];

  @override
  void initState() {
    super.initState();
    inProgressBooks = List<dynamic>.from(widget.userdata['in_progress_books'] ?? []);
    completedBooks = List<String>.from(widget.userdata['completed_books'] ?? []);
  }

  void _logout(BuildContext context) async {
    await SessionManager.logout().then(
          (none) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false, // Remove all routes
          ) // Navigate to LoginPage and clear the stack
    );
  }

  Future<void> openLesson(BuildContext context, String bookTitle) async {
    // Navigate to LessonScreen and await the result
    final updatedUserData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(
          userdata: widget.userdata,
          bookTitle: bookTitle,
        ),
      ),
    );

    // Update userdata if a result is returned
    if (updatedUserData != null) {
      widget.userdata = updatedUserData;
      const listEquality = ListEquality<dynamic>();

      setState(() {
        if (!listEquality.equals(inProgressBooks, updatedUserData['in_progress_books'])) {
          inProgressBooks = updatedUserData['in_progress_books']; // Update local state
        }
        if (!listEquality.equals(completedBooks, updatedUserData['completed_books'])) {
          completedBooks = updatedUserData['completed_books']; // Update local state
        }
      });
    }
  }

  Future<void> openProfilePage(BuildContext context) async {
    // Navigate to LessonScreen and await the result
    final updatedUsername = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProfilePage(userData: widget.userdata)
      ),
    );

    // Update userdata if a result is returned
    if (updatedUsername != widget.userdata["username"]) {
      widget.userdata["username"] = updatedUsername;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bako Reading App',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () => openProfilePage(context),
          ),
        ],
      ),
      endDrawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          children: books.map((book) {
            return _buildBookButton(context, book['title']!, book['image']!);
          }).toList(),
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton(BuildContext context, String title, String image) {
    Color bookColor = Colors.white;

    if (inProgressBooks.any((book) => book.keys.first == title)) {
      bookColor = Colors.grey.withOpacity(0.5); // Slightly darker for in-progress books
    } else if (completedBooks.contains(title)) {
      bookColor = Colors.black.withOpacity(0.5); // Darker for completed books
    }

    return GestureDetector(
      onTap: () => openLesson(context, title),
      child: Container(
        decoration: BoxDecoration(
          color: bookColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
