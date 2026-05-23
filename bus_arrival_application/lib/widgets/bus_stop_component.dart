import 'package:flutter/material.dart';

class BusStopComponent extends StatelessWidget {
  const BusStopComponent({
    super.key,
    required this.isFav,
    required this.isExpanded,
  });

  final bool isFav;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                isFav ? Icons.star : Icons.star_outline,
                size: 36,
                color: Colors.blueAccent,
              ),
              onPressed: () {},
            ),
            Text("Bus Stop Name"),
            IconButton(
              icon: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 36,
              ),
              onPressed: () {},
            ),
          ],
        ),
        isExpanded ? Text("bus arrival timings") : SizedBox(),
      ],
    );
  }
}
