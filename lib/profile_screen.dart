import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //User Details in Profile Page
  // String Address;
  // String Pin;
  // String Phone;
  //......................
  final _firestore = FirebaseFirestore.instance;
  late String age;
  late String gender;
  late String messageText;

  void getMessages() async {
    final cont = await _firestore.collection('messages').get();
    for (var contnt in cont.docs) {
      print(contnt.data);
    }
  }

  late String imageUrl;
  final storage = FirebaseStorage.instance;
  bool showSpinner = false;

  //......................
  @override
  void initState() {
    setState(() {
      showSpinner = true;
    });
    super.initState();
    imageUrl = '';
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final ref = storage.ref().child('jaga.jpg');
    final url = await ref.getDownloadURL();

    setState(() {
      imageUrl = url;
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Profile Screen'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        opacity: 10,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 200,
                child: Image(
                  
                  image: NetworkImage(imageUrl),
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  age = value;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  gender = value;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  messageText = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    //......................
                    _firestore.collection('messages').add({
                      'AGE': age,
                      'Gender': gender,
                    });
                    //......................
                    getMessages();
                    //......................

                    print(gender);
                    print(age);
                    print(messageText);
                  },
                  child: const Text('Update')),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  },
                  child: const Text('Go Back')),
            ],
          ),
        ),
      ),
    );
  }
}
