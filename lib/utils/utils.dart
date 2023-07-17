class Utils {
  static String formatDate(String data) {
    String isoDate = data;
    DateTime parsedDate = DateTime.parse(isoDate);

    int year = parsedDate.year;
    int month = parsedDate.month;
    int day = parsedDate.day;

    String formattedDate =
        "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
    return formattedDate;
  }

  static List<String> genres(
      List<dynamic> genresId, List<Map<String, dynamic>> genresTitle) {
    List<String> genres = [];
    for (var genre in genresTitle) {
      if (genresId.contains(genre['id'])) {
        genres.add(genre['name']);
      }
    }
    return genres;
  }
}
