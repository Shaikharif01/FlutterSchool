import 'package:flutter/material.dart';
import 'view/screen/podcast_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Podify',
      home: PodcastScreen(),
  );
}
