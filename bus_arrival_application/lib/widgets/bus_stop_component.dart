import 'package:flutter/material.dart';

/// Expandable card showing a stop and its next arrivals.
class BusStopComponent extends StatefulWidget {
  const BusStopComponent({
    super.key,
    required this.busStop,
    required this.isFav,
    required this.favButtonPressed,
  });

  final Map<String, dynamic> busStop;
  final bool isFav;
  final VoidCallback favButtonPressed;

  @override
  State<BusStopComponent> createState() => _BusStopComponentState();
}

class _BusStopComponentState extends State<BusStopComponent> {
  bool _isExpanded = false;
  // Toggle the arrival list for this stop.
  void _expandButtonPressed() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final busStopName = widget.busStop['name'] as String;
    final busses = widget.busStop['busses'] as List;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                widget.isFav ? Icons.star : Icons.star_outline,
                size: 36,
                color: Colors.blueAccent,
              ),
              onPressed: widget.favButtonPressed,
            ),
            Text(busStopName),
            IconButton(
              icon: Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 36,
              ),
              onPressed: _expandButtonPressed,
            ),
          ],
        ),
        if (_isExpanded)
          ...busses.map((bus) {
            return BusArrivalDetails(bus: bus);
          }),
      ],
    );
  }
}

class BusArrivalDetails extends StatelessWidget {
  const BusArrivalDetails({super.key, required this.bus});

  final Map<String, dynamic> bus;

  @override
  Widget build(BuildContext context) {
    // Shows service name and upcoming arrival minutes.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            bus['name'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ...bus['arriving'].map(
          (time) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$time mins'),
          ),
        ),
      ],
    );
  }
}
