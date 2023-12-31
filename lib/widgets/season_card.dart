import 'package:flutter/material.dart';
import 'package:streams_cine/const/app_consts.dart';
import 'package:streams_cine/widgets/rating_stars.dart';

import '../utils/utils.dart';

class SeasonCard extends StatelessWidget {
  final List<dynamic> season;
  final int index;
  const SeasonCard({
    super.key,
    required this.season,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(clipBehavior: Clip.antiAlias, child: _buildCard(season, index));
  }

  Widget _buildCard(List<dynamic> seasonDetails, int index) {
    late String url;

    final currentSeason = seasonDetails
        .indexWhere((element) => element['season_number'] == index + 1);

    if (currentSeason > -1) {
      url = Utils.imageTitle(seasonDetails[currentSeason]['poster_path']);
    } else {
      url = kdefaultImage;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          url,
          height: 200.0,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 25.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            Text(
              '${index + 1}ª TEMPORADA',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0),
            ),
            const Divider(
                // color: Colors.amber,
                ),
            Row(
              children: [
                const Icon(Icons.date_range),
                const SizedBox(width: 10.0),
                Text(
                  seasonDetails[currentSeason]['air_date'] != null
                      ? Utils.formatDate(
                          seasonDetails[currentSeason]['air_date'])
                      : "Não Informado",
                  style: const TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            Text(
              'Episódios: ${seasonDetails[currentSeason]['episode_count']}',
              style: const TextStyle(fontSize: 17.0),
            ),
            Text(
              'Avaliação: ${seasonDetails[currentSeason]['vote_average']}',
              style: const TextStyle(fontSize: 17.0),
            ),
            RatingStars(
              rating: seasonDetails[currentSeason]['vote_average'].toString(),
            ),
          ],
        ),
      ],
    );
  }
}
