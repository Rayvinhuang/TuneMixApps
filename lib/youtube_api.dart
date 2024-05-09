 import 'dart:convert';

import 'package:http/http.dart' as http;

 class YouTubeAPI {

 final String apiKey;
 YouTubeAPI({required this.apiKey});

 Future<List<Map<String, dynamic>>> searchVideos(String
 query) async {

 final url =
 'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&key=AIzaSyCfKYPykxwaHq05BWyYcL6P2wvVwIPyfGI';
 final response = await http.get(Uri.parse(url));
if (response.statusCode == 200) {
 final data = jsonDecode(response.body);
 final items = data['items'] as List<dynamic>;
 return items.map((item) {
 final snippet = item['snippet'];
 final videoId = snippet['videoId'];
 final title = snippet['title'];
 final thumbnail =
 snippet['thumbnails']['default']['url'];
 return {
 'videoId': videoId,
 'title': title,
 'thumbnail': thumbnail,
 };
 }).toList();
 } else {
 throw Exception('Failed to fetch videos:${response.statusCode}');
 }
 }
 }