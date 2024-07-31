import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/controllers/user_controller.dart';
import 'package:google_signin/home_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  //================================
  bool showSpinner = false;
  //================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('LogIn Screen'),
      ),
      //================================
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        //================================
        child: Center(
          child: ElevatedButton(
            child: const Text('Login With Google'),
            onPressed: () async {
              //================================
              setState(() {
                showSpinner = true;
              });
              //================================
              try {
                final user = await UserController().loginWithGoogle();
                if (user != null && mounted) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                }
                //================================
                setState(() {
                  showSpinner = false;
                });
                //================================
              } on FirebaseAuthException catch (error) {
                print(error.message);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  error.message ?? "something went wrong",
                )));
              } catch (error) {
                print(error);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  error.toString(),
                )));
              }
            },
          ),
        ),
      ),
    );
  }
}
