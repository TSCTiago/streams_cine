import 'dart:math';

import 'package:flutter/material.dart';
import 'package:streams_cine/const/app_consts.dart';

import '../api/api.dart';
import '../models/titles_model.dart';

class TitleProvider with ChangeNotifier {
  final List<TitlesModel> _movies = [];
  final List<TitlesModel> _nowPlaying = [];
  final List<TitlesModel> _series = [];
  final List<TitlesModel> _favorites = [];
  final List<TitlesModel> _searchedTitles = [];

  Map<String, dynamic> seasons = {};
  String genreSelected = 'Todos';
  bool isSearching = true;
  List<TitlesModel> get movies => _movies;
  List<TitlesModel> get nowPlaying => _nowPlaying;
  List<TitlesModel> get series => _series;
  List<TitlesModel> get favorites => _favorites;
  List<TitlesModel> get searchedTitles => _searchedTitles;

  Future<void> fetchMovies() async {
    await API()
        .requestTitle(_movies, '$kFetchMovies${Random().nextInt(500) + 1}');
    notifyListeners();
  }

  Future<void> fetchNowPlaying() async {
    await API().requestTitle(_nowPlaying, kFetchNowPlaying);
    notifyListeners();
  }

  Future<void> fetchSeries() async {
    await API()
        .requestTitle(_series, '$kFetchSeries${Random().nextInt(10) + 1}');
    notifyListeners();
  }

  Future<void> fetchSeasons(int id) async {
    seasons.clear();
    final url =
        'https://api.themoviedb.org/3/tv/$id?append_to_response=images&language=pt-BR';
    await API().getSeasons(id, url, seasons);
    notifyListeners();
  }

  Future<void> searchTitle(String query) async {
    final url =
        'https://api.themoviedb.org/3/search/multi?query=$query&language=pt-BR';
    await API()
        .requestTitle(_searchedTitles, url)
        .then((value) => isSearching = false);
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
