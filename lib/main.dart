import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  final Color primaryColor = const Color(0xFF916BD3); // Replace with #916bd3

  final MaterialColor customPrimarySwatch = MaterialColor(
    0xFF916BD3,
    <int, Color>{
      50: Color(0xFFE5DBF4),
      100: Color(0xFFD2C2E8),
      200: Color(0xFFBFABDB),
      300: Color(0xFFAD93CE),
      400: Color(0xFF9A7AC1),
      500: Color(0xFF8852B5),
      600: Color(0xFF7A47A0),
      700: Color(0xFF6B3C8B),
      800: Color(0xFF5D3276),
      900: Color(0xFF4F275E),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: customPrimarySwatch,
        scaffoldBackgroundColor: const Color(0xFFE2D3F2),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontFamily: 'Roboto Mono',
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text.rich(
            TextSpan(
              children: [
                ColoredTextSpan(
                  text: '2',
                  color: Color(0xFFEB4382),
                ),
                ColoredTextSpan(
                  text: 'D',
                  color: Color(0xFFDBB0DB),
                ),
                ColoredTextSpan(
                  text: 'o',
                  color: Color(0xFF2FC3F1),
                ),
                ColoredTextSpan(
                  text: ' ',
                  color: Color(0xFFFAE881),
                ),
                ColoredTextSpan(
                  text: 'L',
                  color: Color(0xFFE678AB),
                ),
                ColoredTextSpan(
                  text: 'i',
                  color: Color(0xFF5DDBD7),
                ),
                ColoredTextSpan(
                  text: 's',
                  color: Color(0xFF8CDE89),
                ),
                ColoredTextSpan(
                  text: 't',
                  color: Color(0xFFEB4382),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: ToDoListScreen(),
        bottomNavigationBar: Container(
          height: 60,
          color: primaryColor,
          child: Center(
            child: GestureDetector(
              onTap: () {
                launch('https://lightraptor2310.github.io/to-do-list/');
              },
              child: Text(
                'Original code from Lightraptor Todo-list',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
      // home: ToDoListScreen(),
//       body: ToDoListScreen(),
//       bottomNavigationBar: Container(
//         height: 60,
//         color: primaryColor,
//         child: Center(
//           child: GestureDetector(
//             onTap: () {
//               launch('https://lightraptor2310.github.io/to-do-list/');
//             },
//             child: Text(
//               'Original code from Lightraptor Todo-list',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontStyle: FontStyle.italic,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ),
//         ),
//       ),
//     // ),
//     );
//   }
// }

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  TextEditingController _inputController = TextEditingController();
  List<String> _tasks = [];
  List<bool> _taskCompleted = [];
  int _editingIndex = -1;
  TextEditingController _editingController = TextEditingController();

  void _addTask() {
    String taskName = _inputController.text.trim();

    if (taskName.isNotEmpty) {
      setState(() {
        _tasks.add(taskName);
        _taskCompleted.add(false); // Initialize task completion status
        _inputController.clear();
      });
    }
  }

  void _editTask(int index, String newTaskName) {
    setState(() {
      _tasks[index] = newTaskName;
      _editingIndex = -1;
      _editingController.clear();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _taskCompleted.removeAt(index); // Remove task completion status
      if (_editingIndex == index) {
        _editingIndex = -1;
        _editingController.clear();
      }
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _taskCompleted[index] = !_taskCompleted[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              ColoredTextSpan(
                text: '2',
                color: Color(0xFFEB4382),
              ),
              ColoredTextSpan(
                text: 'D',
                color: Color(0xFFDBB0DB),
              ),
              ColoredTextSpan(
                text: 'o',
                color: Color(0xFF2FC3F1),
              ),
              ColoredTextSpan(
                text: ' ',
                color: Color(0xFFFAE881),
              ),
              ColoredTextSpan(
                text: 'L',
                color: Color(0xFFE678AB),
              ),
              ColoredTextSpan(
                text: 'i',
                color: Color(0xFF5DDBD7),
              ),
              ColoredTextSpan(
                text: 's',
                color: Color(0xFF8CDE89),
              ),
              ColoredTextSpan(
                text: 't',
                color: Color(0xFFEB4382),
              ),
            ],
          ),
        ),
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
                      onSubmitted: (newTaskName) => _editTask(index, newTaskName),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () => _editTask(index, _editingController.text.trim()),
                    ),
                  );
                } else {
                  return ListTile(
                    leading: Checkbox(
                      value: _taskCompleted[index],
                      onChanged: (value) => _toggleTaskCompletion(index),
                    ),
                    title: Text(
                      _tasks[index],
                      style: TextStyle(
                        decoration: _taskCompleted[index] ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
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

class ColoredTextSpan extends TextSpan {
  ColoredTextSpan({
    required String text, // Mark 'text' parameter as required
    required Color color,
  }) : super(
    text: text,
    style: TextStyle(color: color),
  );
}
