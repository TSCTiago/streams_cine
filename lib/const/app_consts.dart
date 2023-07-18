import 'dart:math';

Map<String, String>? kHeaders = {
  'accept': 'application/json',
  'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDhmMDc1ZDI1ZmVlYWZjNTFlMzI1MDMwYzA3ODZmYiIsInN1YiI6IjY0YTllMjBlYjY4NmI5MDEyZjg2OGNjZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gOaNgQCygqzKsbJEwqoo2HcYUM3nkYGyAiKW6qiUaRw',
};

List<Map<String, dynamic>> kMoviesGenres = [
  {"id": 0, "name": "Todos"},
  {"id": 28, "name": "Ação"},
  {"id": 12, "name": "Aventura"},
  {"id": 16, "name": "Animação"},
  {"id": 35, "name": "Comédia"},
  {"id": 80, "name": "Crime"},
  {"id": 99, "name": "Documentário"},
  {"id": 18, "name": "Drama"},
  {"id": 10751, "name": "Família"},
  {"id": 14, "name": "Fantasia"},
  {"id": 36, "name": "História"},
  {"id": 27, "name": "Terror"},
  {"id": 10402, "name": "Música"},
  {"id": 9648, "name": "Mistério"},
  {"id": 10749, "name": "Romance"},
  {"id": 878, "name": "Ficção científica"},
  {"id": 10770, "name": "Cinema TV"},
  {"id": 53, "name": "Thriller"},
  {"id": 10752, "name": "Guerra"},
  {"id": 37, "name": "Faroeste"}
];

List<Map<String, dynamic>> kSeriesGenres = [
  {"id": 0, "name": "Todos"},
  {"id": 10759, "name": "Acão & Aventura"},
  {"id": 16, "name": "Animação"},
  {"id": 35, "name": "Comédia"},
  {"id": 80, "name": "Crime"},
  {"id": 99, "name": "Documentário"},
  {"id": 18, "name": "Drama"},
  {"id": 10751, "name": "Família"},
  {"id": 10762, "name": "Kids"},
  {"id": 9648, "name": "Mistério"},
  {"id": 10763, "name": "News"},
  {"id": 10764, "name": "Reality"},
  {"id": 10765, "name": "Sci-Fi & Fantasia"},
  {"id": 10766, "name": "Soap"},
  {"id": 10767, "name": "Talk"},
  {"id": 10768, "name": "Guerra & Política"},
  {"id": 37, "name": "Faroeste"}
];

const kdefaultImage =
    'https://cloud.filmfed.com/defaults/movie-poster/s_movie_poster_default.png';

final kFetchMovies =
    'https://api.themoviedb.org/3/discover/movie?language=pt-BR&page=${Random().nextInt(500) + 1}';

final kFetchNowPlaying =
    'https://api.themoviedb.org/3/movie/now_playing?language=pt-BR&page=${Random().nextInt(5) + 1}';

final kFetchSeries =
    'https://api.themoviedb.org/3/discover/tv?language=pt-BR&page=${Random().nextInt(10) + 1}';
