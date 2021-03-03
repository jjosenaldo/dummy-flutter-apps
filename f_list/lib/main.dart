import 'package:flutter/material.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskTitleController = TextEditingController();

  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskTitleController,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _tasks.insert(
                            0,
                            Task(
                                finished: false,
                                title: _taskTitleController.text));
                        _taskTitleController.text = '';
                      });
                    },
                    child: Text('Adicionar')),
              ],
            ),
            SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => TodoListTile(
                  onChanged: (finished) {
                    setState(() {
                      _tasks[index].finished = finished;
                    });
                  },
                  task: _tasks[index],
                ),
                itemCount: _tasks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  Task({
    required this.title,
    required this.finished,
  });

  bool finished;
  final String title;
}

class TodoListTile extends StatelessWidget {
  TodoListTile({
    required Task task,
    required this.onChanged,
  })   : finished = task.finished,
        title = Text(task.title),
        super(key: ValueKey(task.title));

  final bool finished;
  final Text title;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      leading: Icon(
        finished ? Icons.check_circle : Icons.cancel,
        color: finished ? Colors.green : Colors.red,
      ),
      trailing: Checkbox(
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        value: finished,
      ),
    );
  }
}
