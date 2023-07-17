import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/titles_model.dart';
import '../pages/favorites_page.dart';
import '../pages/home_page.dart';
import '../pages/title_detail_page.dart';
import '../pages/titles_page.dart';
import '../providers/titles_provider.dart';
import 'rotes_app.dart';

class StreamsCine extends StatelessWidget {
  const StreamsCine({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TitleProvider(),
      child: MaterialApp(
        title: "Streams Cine",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.orange.shade900,
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        initialRoute: RoutesApp.home,
        // home: const HomePage(),
        routes: {
          RoutesApp.home: (context) => const HomePage(),
          RoutesApp.titlesPages: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>;
            final titles = arguments['titlesList'] as List<TitlesModel>;
            final genres = arguments['genres'] as List<Map<String, dynamic>>;

            return TitlesPage(
              list: titles,
              genres: genres,
            );
          },
          RoutesApp.details: (context) {
            final title =
                ModalRoute.of(context)?.settings.arguments as TitlesModel;
            return TitleDetailsPage(
              titleInfos: title,
            );
          },
          RoutesApp.favorites: (context) => const FavoritesPage(),
        },
      ),
    );
  }
}
