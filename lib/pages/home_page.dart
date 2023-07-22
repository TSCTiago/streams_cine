import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streams_cine/const/app_consts.dart';

import '../app/rotes_app.dart';
import '../providers/titles_provider.dart';
import '../widgets/carousel/carousel.dart';
import '../widgets/config_modal.dart';
import '../widgets/list_title_card.dart';
import '../widgets/text_field.dart';
import '../widgets/title_type.dart';
import '../widgets/skeleton/skeleton_progress_list_view.dart';
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

  void refreshTitle(TitleProvider provider) async {
    provider.clearList(provider.movies);
    provider.clearList(provider.series);
    await provider.fetchMovies();
    await provider.fetchSeries();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TitleProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Streams Cine'),
      ),
      body: GestureDetector(
        onTap: () {
          // call this method here to hide soft keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async => refreshTitle(provider),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TextFieldTitle(),
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
                    ? const SkeletonProgressListView()
                    : ListTitleCard(list: provider.movies),
                TitlesPageLink(
                    titleText: 'Séries',
                    genres: kSeriesGenres,
                    titlesList: provider.series),
                provider.series.isEmpty
                    ? const SkeletonProgressListView()
                    : ListTitleCard(list: provider.series),
              ],
            ),
          ),
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
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return const ConfigurationModal();
                },
              ),
              icon: const Icon(
                Icons.settings,
                size: 30.0,
              ),
            ),
            IconButton(
              onPressed: () => refreshTitle(provider),
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
