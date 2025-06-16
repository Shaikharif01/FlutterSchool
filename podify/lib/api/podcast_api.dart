import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:podify/model/podcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodcastApi {
  final dio = Dio();

  Future<List<Podcast>> fetchPodcasts() async {
    const url = 'https://listen-api.listennotes.com/api/v2/search?q=star';
    const apiKey = 'c572c8b7393c401da3e16c3e2184d3bc';

    final headers = {
      'X-ListenAPI-Key': apiKey,
      'Accept': 'application/json',
    };

    final sharedPreferences = await SharedPreferences.getInstance();


    if (await InternetConnectionChecker.instance.hasConnection) {
      
        final response = await dio.get(
          url,
          options: Options(headers: headers),
        );

        final results = response.data['results'] as List;
        final podcasts = results.map((json) => Podcast.fromJson(json)).toList();
        await sharedPreferences.setString('podcast', json.encode(podcasts));
        return podcasts;
      }else{
       final podcasts = sharedPreferences.getString('podcasts');
       if (podcasts == null){
           return [];
       }else{
        return jsonDecode(podcasts)
        .map<Podcast>((json)=> Podcast.fromJson(json))
        .toList();
       }

    }
  }

  Future<void> downloadAudio(
    String url,
    String fileName,{
      ProgressCallback? onReceiveProgress,
    }
  )async{
    final appStorage = await getApplicationDocumentsDirectory();
    final sharedPreferences = await SharedPreferences.getInstance();  
    final path = '${appStorage.path}/$fileName';

    if (await InternetConnectionChecker.instance.hasConnection){
      await dio.download(url, path,
      onReceiveProgress: onReceiveProgress,);
      await sharedPreferences.setString('path', path);
      await OpenFile.open(path, type: 'audio/x-mpeg');
    }else{
      final savedPath = sharedPreferences.getString('path');
      if(savedPath == path){
        await OpenFile.open(savedPath, type: 'audio/x-mpeg');
      }
    }
  }
}
