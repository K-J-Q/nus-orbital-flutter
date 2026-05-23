import 'package:bus_arrival_application/db/bus_db.dart';
import 'package:flutter/material.dart';
import '../constants/bus_stops.dart';
import 'package:bus_arrival_application/widgets/bus_stop_component.dart';

/// View showing bus arrival times, with favourites pinned to the top.
class BusArrivalView extends StatefulWidget {
  const BusArrivalView({super.key});

  @override
  State<BusArrivalView> createState() => _BusArrivalViewState();
}

class _BusArrivalViewState extends State<BusArrivalView> {
  List<String> _favourites = [];

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  // Load favourites from local storage on startup.
  Future<void> _loadFavourites() async {
    final favs = await BusDb.getFavourites();
    if (mounted) {
      setState(() {
        _favourites = favs;
      });
    }
  }

  void _favButtonPressed(String id) {
    setState(() {
      if (_favourites.contains(id)) {
        _favourites.remove(id);
      } else {
        _favourites.add(id);
      }
    });
    BusDb.saveFavourite(id);
  }

  @override
  Widget build(BuildContext context) {
    // Sort by favourite, then by name for a stable list.
    final sortedStops = List<Map<String, dynamic>>.from(busStopTimings);
    sortedStops.sort((a, b) {
      final aFav = _favourites.contains(a['id'].toString());
      final bFav = _favourites.contains(b['id'].toString());
      if (aFav && !bFav) return -1;
      if (!aFav && bFav) return 1;
      return (a['name'] as String).compareTo(b['name'] as String);
    });

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: sortedStops.length,
            itemBuilder: (context, index) {
              final busStop = sortedStops[index];
              return BusStopComponent(
                busStop: busStop,
                isFav: _favourites.contains(busStop['id'].toString()),
                favButtonPressed: () =>
                    _favButtonPressed(busStop['id'].toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
