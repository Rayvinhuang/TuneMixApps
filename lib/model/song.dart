class Song {
  final String id;
  final String title;
  final String artist;
  final String youtubeLink;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.youtubeLink,
  });

  factory Song.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Song(
      id: documentId,
      title: data['title'] ?? '',
      artist: data['artist'] ?? '',
      youtubeLink: data['youtube_link'] ?? '',
    );
  }
}