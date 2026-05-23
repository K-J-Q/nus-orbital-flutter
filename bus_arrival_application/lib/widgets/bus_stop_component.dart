import 'package:flutter/material.dart';

class BusStopComponent extends StatefulWidget {
  const BusStopComponent({
    super.key,
  });

  @override
  State<BusStopComponent> createState() => _BusStopComponentState();
}

class _BusStopComponentState extends State<BusStopComponent> {
  bool _isFav = false;
  bool _isExpanded = false;
  
  void _favButtonPressed() {
    setState(() {
      _isFav = !_isFav;
    });
  }

  void _expandButtonPressed() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                _isFav ? Icons.star : Icons.star_outline,
                size: 36,
                color: Colors.blueAccent,
              ),
              onPressed: _favButtonPressed,
            ),
            Text("Bus Stop Name"),
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
        _isExpanded ? Text("bus arrival timings") : SizedBox(),
      ],
    );
  }
}
