import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  TextEditingController _inputController = TextEditingController();
  List<String> _tasks = [];
  int _editingIndex = -1;
  TextEditingController _editingController = TextEditingController();

  void _addTask() {
    String task = _inputController.text.trim();

    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(task);
        _inputController.clear();
      });
    }
  }

  void _editTask(int index, String newTask) {
    setState(() {
      _tasks[index] = newTask;
      _editingIndex = -1;
      _editingController.clear();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = -1;
        _editingController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      hintText: 'Add your text',
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                if (_editingIndex == index) {
                  return ListTile(
                    title: TextField(
                      controller: _editingController,
                      decoration: InputDecoration(
                        hintText: 'Edit task',
                      ),
                      autofocus: true,
                      onSubmitted: (newTask) => _editTask(index, newTask),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () => _editTask(index, _editingController.text.trim()),
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text(_tasks[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _editingIndex = index;
                              _editingController.text = _tasks[index];
                              Future.delayed(Duration.zero, () {
                                _editingController.selection = TextSelection.fromPosition(TextPosition(offset: _editingController.text.length));
                              });
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTask(index),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
