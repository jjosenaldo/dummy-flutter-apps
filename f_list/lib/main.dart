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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  void _sortTasksUnfinishedFirst() {
    _tasks.sort((task1, task2) => task1.finished ? 1 : -1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: _autovalidate
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      decoration: InputDecoration(
                          hintText: 'Nova tarefa', errorMaxLines: 2),
                      controller: _taskTitleController,
                      validator: (title) => title == null
                          ? 'Nome da tarefa não pode ser vazio'
                          : title.isEmpty
                              ? 'Nome da tarefa não pode ser vazio'
                              : null,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff62c511))),
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          setState(() {
                            _autovalidate = false;
                            _tasks.insert(
                                0,
                                Task(
                                    finished: false,
                                    title: _taskTitleController.text));
                            _taskTitleController.text = '';
                          });
                        } else {
                          setState(() {
                            _autovalidate = true;
                          });
                        }
                      },
                      child: Text('Adicionar')),
                ],
              ),
              SizedBox(height: 4),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      setState(() => _sortTasksUnfinishedFirst()),
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
              ),
            ],
          ),
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
        finished ? Icons.check_circle : Icons.error,
        color: finished ? Colors.green : Colors.orange,
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
