import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: topBar(context),
        body: listView(),
      ),
    );
  }
}

AppBar topBar(BuildContext context) {
  return AppBar(
    leading: const Icon(Icons.settings),
    title: const Text("ToDoer"),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.account_circle),
        tooltip: 'Show Snackbar',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('This is a snackbar')));
        },
      ),
    ],
  );
}

// create a widget for the list of tasks
Widget listView() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text('Task $index'),
      );
    },
  );
}
