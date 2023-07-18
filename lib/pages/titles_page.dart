import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/titles_model.dart';
import '../providers/titles_provider.dart';
import '../widgets/genres_options.dart';
import '../widgets/title_card.dart';

class TitlesPage extends StatefulWidget {
  final List<TitlesModel> list;
  final List<Map<String, dynamic>> genres;
  const TitlesPage({super.key, required this.list, required this.genres});

  @override
  State<TitlesPage> createState() => _TitlesPageState();
}

class _TitlesPageState extends State<TitlesPage> {
  // initS
  late List<TitlesModel> filteredlist = widget.list;

  @override
  void initState() {
    super.initState();
    Provider.of<TitleProvider>(context, listen: false).genreSelected = 'Todos';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TitleProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60.0,
              // width: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.genres.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                        onTap: () {
                          provider
                              .changeGenreFilter(widget.genres[index]['name']);
                          widget.genres[index]['name'] == 'Todos'
                              ? filteredlist = widget.list
                              : filteredlist = widget.list
                                  .where((element) => element.genre
                                      .contains(widget.genres[index]['name']))
                                  .toList();
                        },
                        child:
                            GenresOption(text: widget.genres[index]['name'])),
              ),
            ),
            filteredlist.isEmpty
                ? Center(
                    // heightFactor: 600.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Icon(
                        Icons.image_search_rounded,
                        size: 300.0,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 900.0,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: filteredlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TitleCard(title: filteredlist[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
