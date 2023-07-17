class TitlesModel {
  int id;
  String title;
  String posterUrl;
  String imageUrl;
  String rating;
  String date;
  String sinopse;
  List<String> genre;
  bool isSerie;

  TitlesModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.imageUrl,
    required this.rating,
    required this.date,
    required this.sinopse,
    required this.genre,
    required this.isSerie,
  });
}
