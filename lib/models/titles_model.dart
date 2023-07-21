import '../const/app_consts.dart';
import '../utils/utils.dart';

class TitlesModel {
  int id;
  String title;
  String posterUrl;
  String imageUrl;
  String rating;
  String date;
  // String? mediaType;
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
    // required this.mediaType,
    required this.sinopse,
    required this.genre,
    required this.isSerie,
  });

  factory TitlesModel.fromJson(Map<String, dynamic> json, bool isSeries) {
    return TitlesModel(
      id: json['id'],
      title: json[isSeries ? 'name' : 'title'] ?? 'Não Fornecido',
      posterUrl: Utils.imageTitle(json['poster_path']),
      imageUrl: Utils.imageTitle(json['backdrop_path']),
      rating: json['vote_average'] != null
          ? json['vote_average'].toString()
          : 0.0.toString(),
      // mediaType: json['media_type'],
      date: json[isSeries ? 'first_air_date' : 'release_date'] != null
          ? Utils.formatDate(json[isSeries ? 'first_air_date' : 'release_date'])
          : 'Não Fornecido',
      sinopse: json['overview'] ?? 'Não Fornecido',
      genre: json['genre_ids'] != null
          ? Utils.genres(
              json['genre_ids'], isSeries ? kSeriesGenres : kMoviesGenres)
          : ['Não Informado'],
      isSerie: isSeries,
    );
  }
}
