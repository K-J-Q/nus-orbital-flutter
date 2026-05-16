import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blueAccent)),
      home: const MyHomePage(title: 'Bus Arrival App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFav = false;
  bool isExpanded = false;

  void favButtonPressed() {
    setState(() {
      isFav = !isFav;
    });
  }

  void expandButtonPressed() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Column(
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
                    onPressed: favButtonPressed,
                  ),
                  Text("Bus Stop Name"),
                  IconButton(
                    icon: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 36,
                    ),
                    onPressed: expandButtonPressed,
                  ),
                ],
              ),
              isExpanded ? Text("bus arrival timings") : SizedBox(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Bus Arrival Times',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'Bus Services',
          ),
        ],
      ),
    );
  }
}
