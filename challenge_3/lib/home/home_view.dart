import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // miejsce na dowolną implementację Widgetu prezentującego rozwiązanie
      body: const Center(
        child: Text('Space for a solution'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add current timestamp',
        child: const Icon(Icons.more_time),
      ),
    );
  }
}
