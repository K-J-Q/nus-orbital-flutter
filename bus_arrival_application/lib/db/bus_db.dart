import 'package:shared_preferences/shared_preferences.dart';

class BusDb {
  static Future<void> saveFavourite(String busStopId) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favourites') ?? [];
    if (!favs.contains(busStopId)) {
      favs.add(busStopId);
      await prefs.setStringList('favourites', favs);
    } else {
      favs.remove(busStopId);
      await prefs.setStringList('favourites', favs);
    }
  }

  static Future<List<String>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favourites') ?? [];
  }
}
