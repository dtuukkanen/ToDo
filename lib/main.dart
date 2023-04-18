import 'package:flutter/material.dart';

final now = DateTime.now();
final String time = "${now.day.toString()}/${now.month.toString().padLeft(2,'0')}/${now.year.toString().padLeft(2,'0')} ${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}";
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  TextEditingController editingController = TextEditingController();
  //List<String> tasks = List.generate(10, (index) => 'Task $index');
  List<String> tasks = ['Attend class', 'Study', 'Make food', 'Walk the dog', 'Eat', 'Sleep'];

  Widget listView() {
  return ListView.builder(
    shrinkWrap: true,
    itemExtent: 80.0,
    itemCount: tasks.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
          color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(20)
        ),
        title: Text(tasks[index],
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
        onPressed:() {
          setState(() {
            tasks.removeAt(index);
          });
        },
        ), 
      );
    },
  );
}

  Widget floatingActionButton() {
  return FloatingActionButton(
    elevation: 12,
    child: const Icon(Icons.add),
    onPressed: () {
      showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add new task'),
          content: TextField(
            controller: editingController,
            decoration: const InputDecoration(
              hintText: 'Write new task here...'
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')
            ),
            TextButton(onPressed: () {
              setState(() {
                tasks.add(editingController.text);
                editingController.clear();
              });
              Navigator.of(context).pop();
            }, child: const Text('Add'))
          ],
        );
      });
    }
    );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: topBar(context),
        body: Container(
          margin: const EdgeInsets.only(bottom: 80.0, left: 5.0, right: 5.0, top: 5.0),
          child: listView(),
        ),
        bottomNavigationBar: bottomNavigationBar(context),
        floatingActionButton: floatingActionButton()
    )
    );
  }
}

AppBar topBar(BuildContext context) {
  return AppBar(
    leading: const IconButton(
      icon: Icon(Icons.settings),
      onPressed: onSettingsPressed,
      ),
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

void onSettingsPressed() {}


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
