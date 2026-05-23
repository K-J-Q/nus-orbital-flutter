import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bus_stop.dart';

/// Fetches bus stop metadata grouped by bus route.
class BusStopServices {
  // Backend endpoint returning grouped bus stop details.
  static const String _busStopDetailsUrl =
      'https://n784k2f6s0.execute-api.ap-southeast-1.amazonaws.com/prod/bus-stop-details';

  /// `Future<T>` represents a value of type T that will be available at some point in the future.
  /// `async` keyword enables the use of `await` inside this function and automatically wraps
  /// the return value in a Future. The function returns immediately, not blocking the UI.
  Future<Map<String, List<BusStop>>> fetchBusStops() async {
    /// `await` pauses execution here until the HTTP request completes and a response is received.
    /// During this wait, other code (like UI rendering) can continue running on the main thread (since this is an async function).
    /// The result is unwrapped from the Future automatically upon completion.
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
