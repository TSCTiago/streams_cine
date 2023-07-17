import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/titles_model.dart';
import '../providers/titles_provider.dart';
import '../utils/custom_shape.dart';
import '../widgets/rating_stars.dart';
import '../widgets/season_card.dart';
import '../widgets/title_info_card.dart';

class TitleDetailsPage extends StatefulWidget {
  final TitlesModel titleInfos;

  const TitleDetailsPage({
    Key? key,
    required this.titleInfos,
  }) : super(key: key);

  @override
  State<TitleDetailsPage> createState() => _TitleDetailsPageState();
}

class _TitleDetailsPageState extends State<TitleDetailsPage> {
  late bool isFavorite;
  @override
  void initState() {
    final provider = Provider.of<TitleProvider>(context, listen: false);
    if (widget.titleInfos.isSerie) {
      provider.fetchSeasons(widget.titleInfos.id);
    }
    isFavorite = false;
    _isFavorite(provider);
    super.initState();
  }

  void _isFavorite(TitleProvider provider) {
    setState(() {
      final index = provider.favorites
          .indexWhere((element) => widget.titleInfos.id == element.id);
      index == -1 ? isFavorite = false : isFavorite = true;
    });
  }

  void toggleFavorite(TitleProvider provider) {
    setState(() {
      final index = provider.favorites
          .indexWhere((element) => widget.titleInfos.id == element.id);
      if (index == -1) {
        provider.addFavorites(widget.titleInfos);
        isFavorite = true;
      } else {
        provider.removeFavorite(index);
        isFavorite = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerTitle = Provider.of<TitleProvider>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              // alignment: Alignment.topLeft,
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${widget.titleInfos.imageUrl}',
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: 20.0,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      size: 35.0,
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  right: 20.0,
                  child: GestureDetector(
                    onTap: () => toggleFavorite(providerTitle),
                    child: isFavorite
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 35.0,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 35.0,
                          ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.translate(
                  offset: const Offset(10, -70),
                  child: Card(
                    elevation: 10.0,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${widget.titleInfos.posterUrl}',
                      height: 200.0,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        widget.titleInfos.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        widget.titleInfos.genre.join(', '),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Center(
                        child: RatingStars(rating: widget.titleInfos.rating),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TitleInfoCard(
                    title: 'Lançamento', info: widget.titleInfos.date),
                TitleInfoCard(
                    title: 'Tipo',
                    info: !widget.titleInfos.isSerie ? 'Filme' : 'Série'),
                TitleInfoCard(
                    title: 'Avaliação', info: widget.titleInfos.rating),
                //
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                widget.titleInfos.sinopse,
                textAlign: TextAlign.justify,
              ),
            ),
            if (widget.titleInfos.isSerie)
              SizedBox(
                height: 400.0,
                child: ListView.builder(
                  itemCount: providerTitle.seasons['seasons_number'] ?? 0,
                  itemBuilder: (context, index) => SeasonCard(
                    index: index,
                    season: providerTitle.seasons['season_details'],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
