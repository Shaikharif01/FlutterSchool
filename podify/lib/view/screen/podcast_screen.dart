import 'package:flutter/material.dart';
import 'package:podify/api/podcast_api.dart';
import 'package:podify/model/podcast.dart';
import 'package:podify/view/widget/podcast_item.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  List<Podcast>? podcasts;
  final podcastApi = PodcastApi();

  @override
  void initState(){
    super.initState();
    fetchPodcasts();
  }

  Future<void> fetchPodcasts() async{
    podcasts = await podcastApi.fetchPodcasts();
    setState(() {    });
  }

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

      body: podcasts == null
    ? const Center(child: CircularProgressIndicator())
    : ListView.separated(
        itemCount: podcasts!.length,
        itemBuilder: (context, index) {
          final podcast = podcasts![index];
          return PodcastItem(podcast: podcast);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),

    );
  }
}
