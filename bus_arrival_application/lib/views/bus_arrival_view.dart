import 'package:flutter/material.dart';
import '../constants/bus_stops.dart';
import 'package:bus_arrival_application/widgets/bus_stop_component.dart';

class BusArrivalView extends StatelessWidget {
  const BusArrivalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: busStopTimings.length,
            itemBuilder: (context, index) {
              final busStop = busStopTimings[index];
              return BusStopComponent(busStop: busStop);
            },
          ),
        ),
      ],
    );
  }
}
