import 'package:flutter/material.dart';
import 'package:bus_arrival_application/widgets/bus_stop_component.dart';

class BusArrivalView extends StatelessWidget {
  const BusArrivalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [BusStopComponent()]);
  }
}
