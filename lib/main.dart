
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phoenixschool/authentication/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Test());
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}
class _TestState extends State<Test> {
  
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
     home: LoginPage(),
    );
  }
}