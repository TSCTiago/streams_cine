import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../const/app_consts.dart';
import '../models/titles_model.dart';

class TitleProvider with ChangeNotifier {
  final List<TitlesModel> _movies = [];
  final List<TitlesModel> _nowPlaying = [];
  final List<TitlesModel> _series = [];
  final List<TitlesModel> _favorites = [];

  Map<String, dynamic> seasons = {};
  String genreSelected = 'Todos';
  // List<Map<String, dynamic>> episodesList = [];

  List<TitlesModel> get movies => _movies;
  List<TitlesModel> get nowPlaying => _nowPlaying;
  List<TitlesModel> get series => _series;
  List<TitlesModel> get favorites => _favorites;

  Future<void> fetchMovies() async {
    debugPrint('Chamou >>>>>>>>>>>>>');
    final url =
        'https://api.themoviedb.org/3/discover/movie?language=pt-BR&page=${Random().nextInt(500) + 1}';
    await API().request(_movies, url);

    notifyListeners();
  }

  Future<void> fetchNowPlaying() async {
    final url =
        'https://api.themoviedb.org/3/movie/now_playing?language=pt-BR&page=${Random().nextInt(5) + 1}';
    await API().request(_nowPlaying, url);
    notifyListeners();
  }

  Future<void> fetchSeries() async {
    final url =
        'https://api.themoviedb.org/3/discover/tv?language=pt-BR&page=${Random().nextInt(10) + 1}';
    await API().request(_series, url);

    notifyListeners();
  }

  Future<void> fetchSeasons(int id) async {
    debugPrint(id.toString());
    seasons.clear();
    // episodesList.clear();

    debugPrint('season>>>>>>>>>>> chamou');
    final Uri url = Uri.parse(
        'https://api.themoviedb.org/3/tv/$id?append_to_response=images&language=pt-BR');

    final response = await http.get(
      url,
      headers: kHeaders,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      seasons['id'] = id;
      seasons['seasons_number'] = body['number_of_seasons'];
      seasons['season_details'] = body['seasons'];
      // debugPrint(seasons.toString());

      notifyListeners();
    } else {
      debugPrint('deu erro');
    }
  }

  void clearList(List<TitlesModel> list) {
    list.clear();
    notifyListeners();
  }

  void addFavorites(TitlesModel title) {
    _favorites.add(title);
    notifyListeners();
  }

  void removeFavorite(int index) {
    _favorites.removeAt(index);
    notifyListeners();
  }

  void changeGenreFilter(String genre) {
    genreSelected = genre;
    notifyListeners();
  }
}
