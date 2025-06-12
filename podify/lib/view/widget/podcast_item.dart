import 'package:flutter/material.dart';

class PodcastItem extends StatefulWidget{
  const PodcastItem({super.key});
  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem>{
  @override
  Widget build(BuildContext context) => ListTile(
    title: const Text('Podcast Title'),
    trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
  );
  }
