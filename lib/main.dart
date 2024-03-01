// import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_chat/firebase_options.dart';
import 'package:video_chat/src/features/home/views/home.dart';
import 'package:video_chat/src/features/onboarding/views/onboarding.dart';
import 'package:video_chat/src/features/video_meet/views/video_call.dart';

bool? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getBool("initScreen");
  await prefs.setBool("initScreen", false);
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
          ), 
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
          )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            )
          )
        ),
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white
      ),
      initialRoute: initScreen == true || initScreen == null ? '/' : '/dashboard',
      routes: {
        '/': (context) => const Onboarding(),
        '/dashboard': (context) => const HomeScreen(),
        // '/meet': (context) => const VideoMeet()
        // '/meet': (context) => const VideoCall()
      },
    );
  }
}