import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_v2/task.dart';
import 'package:todo_v2/tasks_page.dart';

class AddTaskPage extends StatefulWidget {
  String name;
  String description;
  int taskIndex;

  AddTaskPage({Key? key, this.name = "", this.description = "", this.taskIndex = -1}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => {returnBack()},
                icon: Icon(Icons.arrow_back)
            ),
            Text("Добавление задачи")
          ],
        ),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: widget.name,
                  decoration: const InputDecoration(
                    labelText: 'Название задачи'
                  ),
                  onSaved: (input) => widget.name = input!,
                  validator: (input) => input?.trim() == "" ? 'Название не должно быть пустым!' : null,
                ),
                TextFormField(
                  initialValue: widget.description,
                  decoration: const InputDecoration(
                      labelText: 'Описание задачи'
                  ),
                  onSaved: (input) => widget.description = input!,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _submit();
                        },
                        child: Text('Добавить'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void returnBack(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TasksPage(),
      ),
    );
  }

  void _submit(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      final tasksBox = Hive.box("tasks");
      Task task = Task(widget.name, widget.description, false);
      if(widget.taskIndex == -1){
        tasksBox.add(task);
      }
      else{
        tasksBox.putAt(widget.taskIndex, task);
      }
      returnBack();
    }
  }

}
