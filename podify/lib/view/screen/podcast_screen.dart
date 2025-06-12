import 'package:flutter/material.dart';
import 'package:podify/view/widget/podcast_item.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
  centerTitle: true,
  elevation: 2,
  backgroundColor: Colors.deepPurple,
  foregroundColor: Colors.white,
  title: RichText(
    text: const TextSpan(
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
      children: [
        TextSpan(
          text: 'Pod',
          style: TextStyle(color: Colors.white),
        ),
        TextSpan(
          text: 'ify',
          style: TextStyle(color: Color.fromARGB(255, 171, 255, 191)),
        ),
      ],
    ),
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: 1,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) => const PodcastItem(),
        ),
      ),
    );
  }
}
