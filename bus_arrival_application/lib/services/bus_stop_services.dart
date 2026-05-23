import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bus_stop.dart';

/// Fetches bus stop metadata grouped by bus route.
class BusStopServices {
  // Backend endpoint returning grouped bus stop details.
  static const String _busStopDetailsUrl =
      'https://n784k2f6s0.execute-api.ap-southeast-1.amazonaws.com/prod/bus-stop-details';

  Future<Map<String, List<BusStop>>> fetchBusStops() async {
    final response = await http.get(Uri.parse(_busStopDetailsUrl));

    // Basic error handling for non-200 (error) responses.
    if (response.statusCode != 200) {
      throw Exception('Failed to load bus stops');
    }

    final decoded = jsonDecode(response.body);
    // Expected shape: { busStopDetails: { routeName: [ { busStopId, name } ] } }
    final busStopData = decoded['busStopDetails'];

    if (busStopData is! Map) {
      throw Exception('Unexpected bus stop response format');
    }

    final result = <String, List<BusStop>>{};

    // Parsing each route's bus stops into BusStop models, with defensive checks.
    for (final busRoute in busStopData.keys) {
      final stops = busStopData[busRoute] as List<dynamic>;
      result[busRoute] = stops
          .map((item) => BusStop.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return result;
  }
}
