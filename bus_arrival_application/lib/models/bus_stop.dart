/// Model for a single bus stop entry.
class BusStop {
  const BusStop({required this.busStopId, required this.name});

  final String busStopId;
  final String name;

  // Defensive parsing to avoid nulls and unexpected types.
  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      busStopId: json['busStopId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}
