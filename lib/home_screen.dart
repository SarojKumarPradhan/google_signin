// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/controllers/user_controller.dart';
import 'package:google_signin/login_screen.dart';
import 'package:google_signin/profile_screen.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //=============================
  // bool showSpinner = false;
  late String imageUrl;
  // final storage = FirebaseStorage.instance;

  // Future<void> getImageUrl() async {
  //   final ref = storage.ref().child('jaga.jpg');
  //   final url = await ref.getDownloadURL();

  //   setState(() {
  //     imageUrl = url;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // imageUrl = '';
    getName();
  }

  Future<void> getName() async {
    final url = UserController().user!.displayName.toString();

    setState(() {
      imageUrl = url;
    });
  }

  //=============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundImage:
                  NetworkImage(UserController().user?.photoURL ?? ''),
            ),
            Text(UserController().user?.displayName ?? ''),
            Text(UserController().user!.displayName.toString()),
            Text(imageUrl),
            ElevatedButton(
                child: const Text('LogOut'),
                onPressed: () async {
                  await UserController().signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LogInScreen()));
                }),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
                },
                child: const Text('Profile')),
          ],
        ),
      ),
    );
  }
}


