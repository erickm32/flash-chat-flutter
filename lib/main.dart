import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Algo de errado não está certo');
          print(snapshot.error);
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            initialRoute: '/welcome',
            routes: {
              WelcomeScreen.routeName: (context) => WelcomeScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              ChatScreen.routeName: (context) => ChatScreen(),
              RegistrationScreen.routeName: (context) => RegistrationScreen()
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
            child: Text(
          'Loading',
          textDirection: TextDirection.ltr,
        ));
      },
    );
  }
}
