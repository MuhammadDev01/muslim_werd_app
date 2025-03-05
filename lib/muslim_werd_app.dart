import 'package:flutter/material.dart';

class MuslimWerdApp extends StatelessWidget {
  const MuslimWerdApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muslim Werd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
   //   home: ,
    );
  }
}
