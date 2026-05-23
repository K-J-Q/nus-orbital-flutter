import 'package:shared_preferences/shared_preferences.dart';

/// Simple local storage wrapper (using shared_preferences) for favourite bus stops.
/// This is also a good example of seperation of concerns - the UI doesn't need to know how favourites are stored, just that they can be saved and retrieved.
class BusDb {
  // Toggles a bus stop id in the favourites list.
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

  // Returns all saved favourite bus stop ids.
  static Future<List<String>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favourites') ?? [];
  }
}
