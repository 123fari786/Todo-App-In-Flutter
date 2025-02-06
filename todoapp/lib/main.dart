import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Account.dart';
import 'package:todoapp/Dashborad.dart';
import 'package:todoapp/Loginscreen.dart';
import 'package:todoapp/Splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCzig5eHCwJpphiHOHkXT4Zs3xwpkZcHFs',
      appId: 'id',
      messagingSenderId: 'sendid',
      projectId: 'myapp',
      storageBucket: 'myapp-b9yt18.appspot.com',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Splashscreen(),
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/login': (context) => const Loginscreen(),
        '/register': (context) => const Account(),
      },
    );
  }
}
