class BusStop {
  const BusStop({required this.busStopId, required this.name});

  final String busStopId;
  final String name;

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      busStopId: json['busStopId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}
