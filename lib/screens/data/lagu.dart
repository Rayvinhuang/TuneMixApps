 class Lagu {
    final String videoId;
    final String title;
    final String thumbnail;
    final String genre; // Tambahkan field lain sesuaikebutuhan
    final String artist; // Tambahkan field lain sesuaikebutuhan

    Lagu({
    required this.videoId,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.artist,
    });
    Map<String, dynamic> toJson() => {
    'videoId': videoId,
    'title': title,
    'thumbnail': thumbnail,
    'genre': genre,
    'artist': artist,
    };
 }