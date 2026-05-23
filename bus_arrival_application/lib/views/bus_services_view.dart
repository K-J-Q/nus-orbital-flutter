import '../widgets/bus_stop_field.dart';
import 'package:flutter/material.dart';
import '../models/bus_stop.dart';
import '../services/bus_stop_services.dart';

class BusServicesView extends StatefulWidget {
  const BusServicesView({super.key});

  @override
  State<BusServicesView> createState() => _BusRoutesViewState();
}

class _BusRoutesViewState extends State<BusServicesView> {
  final BusStopServices _busStopServices = BusStopServices();
  Map<String, List<BusStop>> _busStopDetails = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await _busStopServices.fetchBusStops();
      setState(() {
        _busStopDetails = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_ListOfBusToBusStops(busStopDetails: _busStopDetails)],
      ),
    );
  }
}

class _ListOfBusToBusStops extends StatelessWidget {
  const _ListOfBusToBusStops({required this.busStopDetails});

  final Map<String, List<BusStop>> busStopDetails;

  String _getProperName(String rawName) {
    switch (rawName) {
      case 'blueBus':
        return 'Blue Bus';
      case 'redBus':
        return 'Red Bus';
      case 'yellowBus':
        return 'Yellow Bus';
      case 'greenBus':
        return 'Green Bus';
      case 'brownBus':
        return 'Brown Bus';
      default:
        return 'Unknown Bus';
    }
  }

  Color _getBusColor(String rawName) {
    switch (rawName) {
      case 'blueBus':
        return Colors.blue;
      case 'redBus':
        return Colors.red;
      case 'yellowBus':
        return Colors.amber;
      case 'greenBus':
        return Colors.green;
      case 'brownBus':
        return Colors.brown;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: busStopDetails.entries.map((entry) {
          return BusStopField(
            busName: _getProperName(entry.key),
            busStopNames: entry.value.map((stop) => stop.name).toList(),
            busColor: _getBusColor(entry.key),
          );
        }).toList(),
      ),
    );
  }
}
