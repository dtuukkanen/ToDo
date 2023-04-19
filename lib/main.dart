import 'package:flutter/material.dart';

final now = DateTime.now();
final String time =
    "${now.day.toString()}/${now.month.toString().padLeft(2, '0')}/${now.year.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
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
  List<String> tasks = [
    'Attend class',
    'Study',
    'Make food',
    'Walk the dog',
    'Eat',
    'Sleep'
  ];

  Widget listView() {
    return ListView.builder(
      shrinkWrap: true,
      itemExtent: 80.0,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(20)),
            title: Text(
              tasks[index],
              textAlign: TextAlign.justify,
            ),
            subtitle: Text(
              time,
              textAlign: TextAlign.justify,
            ),
            leading: const Icon(
              Icons.circle,
              size: 40,
              color: Colors.blue,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                size: 30,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  tasks.removeAt(index);
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
        backgroundColor: Colors.blue,
        elevation: 12,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add new task'),
                  content: TextField(
                    controller: editingController,
                    decoration: const InputDecoration(
                        hintText: 'Write new task here...'),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            tasks.add(editingController.text);
                            editingController.clear();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'))
                  ],
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
            appBar: topBar(context),
            body: Container(
                margin: const EdgeInsets.only(
                    bottom: 80.0, left: 5.0, right: 5.0, top: 5.0),
                child: Column(
                  children: <Widget>[
                    searchAndSortBar(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: listView(),
                    ),
                  ],
                )),
            bottomNavigationBar: bottomNavigationBar(context),
            floatingActionButton: floatingActionButton()));
  }

  AppBar topBar(BuildContext context) {
    return AppBar(
      leading: const IconButton(
        icon: Icon(Icons.settings),
        onPressed: onSettingsPressed,
      ),
      title: const Text(
        "ToDoer",
        style: TextStyle(
          fontSize: 24,
        ),
      ),
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

  BottomNavigationBar bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      items: const [
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

  Widget searchAndSortBar() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.grey,
                contentPadding: EdgeInsets.all(8.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Text("Date"),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: PopupMenuButton(
              icon: const Icon(Icons.sort),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Date'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Name'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void onSettingsPressed() {}

//dark mode
