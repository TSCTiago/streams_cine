import 'package:flutter/material.dart';
import 'package:streams_cine/const/app_consts.dart';

import '../api/api.dart';
import '../models/titles_model.dart';

class TitleProvider with ChangeNotifier {
  final List<TitlesModel> _movies = [];
  final List<TitlesModel> _nowPlaying = [];
  final List<TitlesModel> _series = [];
  final List<TitlesModel> _favorites = [];

  Map<String, dynamic> seasons = {};
  String genreSelected = 'Todos';

  List<TitlesModel> get movies => _movies;
  List<TitlesModel> get nowPlaying => _nowPlaying;
  List<TitlesModel> get series => _series;
  List<TitlesModel> get favorites => _favorites;

  Future<void> fetchMovies() async {
    final url = kFetchMovies;
    await API().requestTitle(_movies, url);
    notifyListeners();
  }

  Future<void> fetchNowPlaying() async {
    final url = kFetchNowPlaying;
    await API().requestTitle(_nowPlaying, url);
    notifyListeners();
  }

  Future<void> fetchSeries() async {
    final url = kFetchSeries;
    await API().requestTitle(_series, url);
    notifyListeners();
  }

  Future<void> fetchSeasons(int id) async {
    seasons.clear();
    final url =
        'https://api.themoviedb.org/3/tv/$id?append_to_response=images&language=pt-BR';
    await API().getSeasons(id, url, seasons);
    notifyListeners();
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
