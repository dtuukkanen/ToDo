import 'package:flutter/material.dart';

final now = DateTime.now();
final String time = "${now.day.toString()}/${now.month.toString().padLeft(2,'0')}/${now.year.toString().padLeft(2,'0')} ${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}";
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
        bottomNavigationBar: bottomNavigationBar(context),
        floatingActionButton: FloatingActionButton(
        elevation: 12,
        child: const Icon(Icons.add),
        onPressed: () {  
        },
      ),
    )
    );
  }
}

AppBar topBar(BuildContext context) {
  return AppBar(
    leading: const Icon(Icons.settings),
    title: const Text("ToDoer",
    style: TextStyle(fontSize: 24,),),
    centerTitle: true,
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
    itemExtent: 80.0,
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
          color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(20)
        ),
        title: Text('Task $index',
        textAlign: TextAlign.justify,
        ),
        subtitle:  Text(time,
        textAlign: TextAlign.justify,),
        leading: const Icon(
          Icons.circle,
          size: 40,),
        trailing: IconButton(
          icon: const Icon(
          Icons.delete,
          size: 30,),
        onPressed:() {},
        ), 
      );
    },
  );
}

BottomNavigationBar bottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.task),
      label: 'ToDoList',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.edit_calendar),
      label: 'Calendar',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.note),
      label: 'Notes',
      ),
  ],
  );

}

