import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/titles_model.dart';
import '../const/app_consts.dart';

class API {
  Future<void> requestTitle(List<TitlesModel> list, String endPoint) async {
    final Uri url = Uri.parse(endPoint);

    final response = await http.get(
      url,
      headers: kHeaders,
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<Map<String, dynamic>> titlesList =
          List<Map<String, dynamic>>.from(body['results']);

      for (Map<String, dynamic> title in titlesList) {
        final isSeries = title['name'] != null;
        final titlesModel = TitlesModel.fromJson(title, isSeries);
        list.add(titlesModel);
      }
    }
  }

  Future<void> getSeasons(
      int id, String endPoint, Map<String, dynamic> map) async {
    final Uri url = Uri.parse(endPoint);

    final response = await http.get(
      url,
      headers: kHeaders,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      map['id'] = id;
      map['seasons_number'] = body['number_of_seasons'];
      map['season_details'] = body['seasons'];
    }
  }
}
