import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  const StorageService._();
  factory StorageService() {
    return _instance;
  }
  static StorageService _instance = StorageService._();

  Future<String> _getDocumentsPath() async =>
      (await getApplicationDocumentsDirectory()).path;

  Future<String> _getFileName() async =>
      '${await _getDocumentsPath()}/todolist.json';

  Future<File> _getFile() async => File(await _getFileName());

  Future<void> writeJsonList(List<dynamic> jsonData) async =>
      (await _getFile()).writeAsString(jsonEncode(jsonData));

  Future<List<dynamic>> readJsonList() async =>
      jsonDecode(await (await _getFile()).readAsString()) as List<dynamic>;
}

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
  int _nextTaskId = 0;
  Task? _lastTaskDismissed;

  @override
  void initState() {
    final widgetsBindingInstance = WidgetsBinding.instance;
    if (widgetsBindingInstance != null) {
      widgetsBindingInstance.addPostFrameCallback((timeStamp) async {
        final storage = StorageService();

        try {
          final jsonList = await storage.readJsonList();
          setState(() {
            _tasks.addAll(jsonList
                .map((taskJson) =>
                    Task.fromJson(taskJson as Map<String, dynamic>))
                .toList());
          });
        } on Exception {}
      });
    }

    super.initState();
  }

  @override
  Future<void> dispose() async {
    _taskTitleController.dispose();
    Future.delayed(Duration.zero, () async {
      await StorageService()
          .writeJsonList(_tasks.map((task) => task.toJson()).toList());
    });

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
                                  title: _taskTitleController.text,
                                  id: _nextTaskId++,
                                ));
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
                      onDismisssedCanceled: () => setState(
                          () => _tasks.insert(index, _lastTaskDismissed!)),
                      onDismissed: () {
                        _lastTaskDismissed = _tasks[index];
                        setState(() => _tasks.removeAt(index));
                      },
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
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'finished': finished,
        'id': id,
      };
  factory Task.fromJson(Map<String, dynamic> jsonTask) => Task(
        title: jsonTask['title'] as String,
        id: jsonTask['id'] as int,
        finished: jsonTask['finished'] as bool,
      );

  bool finished;
  final String title;
  final int id;
}

class TodoListTile extends StatelessWidget {
  TodoListTile({
    required Task task,
    required this.onChanged,
    required this.onDismissed,
    required this.onDismisssedCanceled,
  })   : finished = task.finished,
        title = Text(task.title),
        dismissibleKey = Key('${task.id}'),
        super(key: ValueKey(task.title));

  final bool finished;
  final Text title;
  final ValueChanged<bool> onChanged;
  final Key dismissibleKey;
  final VoidCallback onDismissed;
  final VoidCallback onDismisssedCanceled;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: dismissibleKey,
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        onDismissed();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Tarefa ${title.data} removida.'),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: onDismisssedCanceled,
          ),
          duration: Duration(seconds: 3),
        ));
      },
      background: Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.delete, color: Colors.white),
            )),
        color: Colors.orange,
      ),
      child: ListTile(
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
      ),
    );
  }
}
