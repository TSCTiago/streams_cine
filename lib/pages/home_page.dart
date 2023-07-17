import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streams_cine/const/app_consts.dart';

import '../app/rotes_app.dart';
import '../providers/titles_provider.dart';
import '../widgets/carrousel_card.dart';
import '../widgets/list_title_card.dart';
import '../widgets/title_type.dart';
import '../widgets/skeleton_progress.dart';

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
        centerTitle: true,
        title: const Text('Streams Cine'),
        actions: [
          IconButton(
              onPressed: () async {
                provider.clearList(provider.movies);
                provider.clearList(provider.series);
                await provider.fetchMovies();
                await provider.fetchSeries();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TitleType(type: 'Destaques'),
            provider.nowPlaying.isNotEmpty
                ? CarouselSlider.builder(
                    itemCount: provider.nowPlaying.length,
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 8),
                    ),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        CarouselCard(
                      title: provider.nowPlaying[itemIndex].title,
                      imageUrl: provider.nowPlaying[itemIndex].imageUrl,
                    ),
                  )
                : const Text(''),
            const SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(RoutesApp.titlesPages, arguments: {
                'titlesList': provider.movies,
                'genres': kMoviesGenres
              }),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleType(type: 'Filmes'),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.navigate_next),
                  )
                ],
              ),
            ),
            provider.movies.isEmpty
                ? const SkeletonProgress()
                : ListTitleCard(list: provider.movies),
            InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(RoutesApp.titlesPages, arguments: {
                'titlesList': provider.series,
                'genres': kSeriesGenres
              }),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleType(type: 'Séries'),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.navigate_next),
                  )
                ],
              ),
            ),
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
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                size: 30.0,
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
