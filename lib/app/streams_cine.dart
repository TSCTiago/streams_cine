import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/titles_model.dart';
import '../pages/favorites_page.dart';
import '../pages/home_page.dart';
import '../pages/search_page.dart';
import '../pages/title_detail_page.dart';
import '../pages/titles_page.dart';
import '../providers/config_app_provider.dart';
import '../providers/titles_provider.dart';
import 'rotes_app.dart';

class StreamsCine extends StatelessWidget {
  const StreamsCine({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TitleProvider>(
          create: (_) => TitleProvider(),
        ),
        ChangeNotifierProvider<ConfigAppProvider>(
          create: (_) => ConfigAppProvider(),
        )
      ],
      child: Consumer<ConfigAppProvider>(
        builder: (context, ConfigAppProvider configAppProvider, child) {
          return MaterialApp(
            title: "Streams Cine",
            debugShowCheckedModeBanner: false,
            theme: configAppProvider.isDark
                ? ThemeData(
                    primaryColor: configAppProvider.primaryColor,
                    useMaterial3: true,
                    brightness: Brightness.dark,
                    progressIndicatorTheme: ProgressIndicatorThemeData(
                        color: configAppProvider.primaryColor))
                : ThemeData(
                    colorSchemeSeed: configAppProvider.primaryColor,
                    useMaterial3: true,
                    hintColor: Colors.black,
                    brightness: Brightness.light,
                    progressIndicatorTheme: ProgressIndicatorThemeData(
                        color: configAppProvider.primaryColor)),
            initialRoute: RoutesApp.home,
            // home: const HomePage(),
            routes: {
              RoutesApp.home: (context) => const HomePage(),
              RoutesApp.titlesPages: (context) {
                final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>;
                final titles = arguments['titlesList'] as List<TitlesModel>;
                final genres =
                    arguments['genres'] as List<Map<String, dynamic>>;

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
              RoutesApp.search: (context) {
                final text =
                    ModalRoute.of(context)?.settings.arguments as String;
                return SearchPage(
                  initialValueText: text,
                );
              },
            },
          );
        },
      ),
    );
  }
}
