import 'package:flutter/material.dart';
import 'package:podify/api/podcast_api.dart';
import 'package:podify/model/podcast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodcastItem extends StatefulWidget {
  final Podcast podcast;
  const PodcastItem({super.key, required this.podcast});

  @override
  State<PodcastItem> createState() => _PodcastItemState();
}

class _PodcastItemState extends State<PodcastItem> {
  double progress = 0.0;
  String? savedPath;
  final podcastApi = PodcastApi();

  Future<String?> getSavedPath() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
    return savedPath = sharedPreferences.getString('path');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: widget.podcast.image,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        title: Text(
          widget.podcast.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: const Text(
          'New episode available',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            if (progress > 0 && progress < 1)
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator.adaptive(
                  value: progress,
                  strokeWidth: 2,
                ),
              ),
            IconButton(
              onPressed: () async {
                final path =
                    '${widget.podcast.title}/${widget.podcast.title}.mp3';
                await podcastApi.downloadAudio(
                  widget.podcast.audio,
                  path,
                  onReceiveProgress: (count, total) {
                    setState(() {
                      progress = count / total;
                    });
                    if (progress >= 1) {
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          progress = 0;
                        });
                      });
                    }
                  },
                );
                await getSavedPath();
                setState(() => progress = 0.0);
              },
              icon: savedPath == null
                  ? const Icon(Icons.download)
                  : const Icon(Icons.play_arrow),
              tooltip: 'Download',
            ),
          ],
        ),
      ),
    );
  }
}
