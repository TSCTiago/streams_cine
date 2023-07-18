import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streams_cine/const/app_consts.dart';

import '../app/rotes_app.dart';
import '../providers/titles_provider.dart';
import '../widgets/carousel.dart';
import '../widgets/list_title_card.dart';
import '../widgets/title_type.dart';
import '../widgets/skeleton_progress.dart';
import '../widgets/titles_page_link.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<TitleProvider>(context, listen: false);
    provider.fetchMovies();
    provider.fetchNowPlaying();
    provider.fetchSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TitleProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Streams Cine'),
        // actions: const [TextField()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField(
            //     onSubmitted: (value) {
            //       debugPrint('Submeteu');
            //     },
            //     // controller: _searchController,
            //     style: const TextStyle(color: Colors.white),
            //     cursorColor: Colors.white,
            //     decoration: const InputDecoration(
            //       hintText: 'Search...',
            //       hintStyle: TextStyle(color: Colors.white54),
            //       border: InputBorder.none,
            //     )),
            const TitleType(type: 'Destaques'),
            provider.nowPlaying.isNotEmpty
                ? Carousel(provider: provider)
                : const Text(''),
            const SizedBox(
              height: 10.0,
            ),
            TitlesPageLink(
                titleText: 'Filmes',
                genres: kMoviesGenres,
                titlesList: provider.movies),
            provider.movies.isEmpty
                ? const SkeletonProgress()
                : ListTitleCard(list: provider.movies),
            TitlesPageLink(
                titleText: 'Séries',
                genres: kSeriesGenres,
                titlesList: provider.series),
            provider.series.isEmpty
                ? const SkeletonProgress()
                : ListTitleCard(list: provider.series),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // color: Colors.pink.shade900,
        padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RoutesApp.favorites),
              icon: const Icon(
                Icons.favorite,
                size: 30.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                size: 30.0,
              ),
            ),
            IconButton(
              onPressed: () async {
                provider.clearList(provider.movies);
                provider.clearList(provider.series);
                await provider.fetchMovies();
                await provider.fetchSeries();
              },
              icon: const Icon(
                Icons.refresh,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
