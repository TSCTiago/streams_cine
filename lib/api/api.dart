import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:streams_cine/const/app_consts.dart';

import '../models/titles_model.dart';
import '../utils/utils.dart';

class API {
  Future<void> request(List<TitlesModel> list, String endPoint) async {
    final Uri url = Uri.parse(endPoint);

    final response = await http.get(
      url,
      headers: kHeaders,
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<Map<String, dynamic>> moviesNowList =
          List.castFrom(body['results']);

      for (Map<String, dynamic> movie in moviesNowList) {
        // debugPrint(_movies[0].date.toString());
        if (movie['title'] != null) {
          _populateMovies(list, movie);
        } else {
          _populateSeries(list, movie);
        }
      }
    }
  }

  void _populateMovies(List<TitlesModel> list, Map<String, dynamic> movie) {
    list.add(TitlesModel(
      id: movie['id'],
      title: movie['title'] ?? 'Not found',
      posterUrl: movie['poster_path'] ??
          'https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png',
      imageUrl: movie['backdrop_path'] ??
          'https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png',
      rating: movie['vote_average'].toString() ?? 'Not',
      date: movie['release_date'] != null
          ? Utils.formatDate(movie['release_date'])
          : 'Not found',
      sinopse: movie['overview'] ?? 'Not found',
      genre: Utils.genres(movie['genre_ids'], kMoviesGenres) ?? [],
      isSerie: false,
    ));
  }

  void _populateSeries(List<TitlesModel> list, Map<String, dynamic> serie) {
    list.add(TitlesModel(
      id: serie['id'],
      title: serie['name'] ?? 'Not found',
      posterUrl: serie['poster_path'] ??
          'https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png',
      imageUrl: serie['backdrop_path'] ??
          'https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png',
      rating: serie['vote_average'].toString() ?? 'Not',
      date: serie['first_air_date'] != null
          ? Utils.formatDate(serie['first_air_date'])
          : 'Not found',
      sinopse: serie['overview'] ?? 'Not found',
      genre: Utils.genres(serie['genre_ids'], kSeriesGenres) ?? [],
      isSerie: true,
      // seasons:
    ));
  }
}
