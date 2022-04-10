import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recruitment_task/data/database.dart';

import 'home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<MyDatabase>(
      create: (_) => MyDatabase(),
      dispose: (_, db) => db.close(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Builder(builder: (context) {
          return HomeView(
            title: 'Recruitment task',
            db: context.read<MyDatabase>(),
          );
        }),
      ),
    );
  }
}
