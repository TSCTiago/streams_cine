import 'package:flutter/material.dart';
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
    return Card(child: _buildCard(season, index));
  }

  Widget _buildCard(List<dynamic> seasonDetails, int index) {
    // debugPrint(seasonDetails.toString());
    late String url;

    final currentSeason = seasonDetails
        .indexWhere((element) => element['season_number'] == index + 1);

    if (currentSeason > -1) {
      url = seasonDetails[currentSeason]['poster_path'] ??
          '/wwemzKWzjKYJFfCeiB57q3r4Bcm.png';
    } else {
      url = '/wwemzKWzjKYJFfCeiB57q3r4Bcm.png';
    }
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500$url',
            height: 200.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 50.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30.0),
              Text(
                '${index + 1}ª Temporada',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22.0),
              ),
              Row(
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(width: 10.0),
                  Text(
                    Utils.formatDate(seasonDetails[currentSeason]['air_date']),
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
      ),
    );
  }
}
