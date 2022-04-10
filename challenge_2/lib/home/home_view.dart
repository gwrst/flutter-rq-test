import 'package:flutter/material.dart';
import 'package:recruitment_task/data/database.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
    required this.title,
    required this.db,
  }) : super(key: key);

  final String title;
  final MyDatabase db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: StreamBuilder<List<MyTime>>(
          stream: db.watchEntries(),
          initialData: const <MyTime>[],
          builder: (_, snapshot) {
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Text('No data');
            }
            if (snapshot.hasData) {
              List<MyTime> times = snapshot.data!;
              return ListView.builder(
                itemCount: times.length,
                itemBuilder: (context, index) {
                  final time = times[index];
                  return _ListElement(
                    time: time,
                    onDelete: () => db.deleteMyTime(time.id),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return const Text('Something went wrong :(');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          db.addMyTime(DateTime.now().millisecondsSinceEpoch);
        },
        tooltip: 'Add current timestamp',
        child: const Icon(Icons.more_time),
      ),
    );
  }
}

class _ListElement extends StatelessWidget {
  const _ListElement({
    Key? key,
    required this.time,
    required this.onDelete,
  }) : super(key: key);

  final MyTime time;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text('${time.id}'),
        title: Text(
          '${DateTime.fromMillisecondsSinceEpoch(time.timestamp)}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
