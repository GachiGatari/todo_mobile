import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_v2/task.dart';
import 'add_task_page.dart';


class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String filter = "all";


  Widget _buildListView(){
    return WatchBoxBuilder(box: Hive.box("tasks"), builder: (context, tasksBox){
      if(filter == "done"){
        return ListView.builder(
          itemCount: tasksBox.length,
          itemBuilder: (context, index) {
            final task = tasksBox.getAt(index) as Task;
            if(task.isDone) {
              return ListTile(
                title: task.isDone ? Text(task.name, style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.bold)) : Text(task.name),
                subtitle: Container(
                  child: Text(
                    task.description,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                  width: 50,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    !task.isDone ?
                    IconButton(
                        onPressed: () =>
                        {tasksBox.putAt(
                            index, Task(task.name, task.description, true))},
                        icon: Icon(Icons.done)
                    ) :
                    IconButton(
                        onPressed: () =>
                        {tasksBox.putAt(
                            index, Task(task.name, task.description, false))},
                        icon: Icon(Icons.undo)
                    ),
                    IconButton(
                        onPressed: () => {tasksBox.deleteAt(index)},
                        icon: Icon(Icons.delete)
                    ),
                  ],
                ),
                onTap: () =>
                {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          AddTaskPage(name: task.name,
                            description: task.description,
                            taskIndex: index,),
                    ),
                  )
                },
              );
            }
            else return Container();
          },
        );
      } else if (filter == "not_done"){
        return ListView.builder(
          itemCount: tasksBox.length,
          itemBuilder: (context, index) {
            final task = tasksBox.getAt(index) as Task;
            if(!task.isDone) {
              return ListTile(
                title: task.isDone ? Text(task.name, style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.bold)) : Text(task.name),
                subtitle: Container(
                  child: Text(
                    task.description,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                  width: 50,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    !task.isDone ?
                    IconButton(
                        onPressed: () =>
                        {tasksBox.putAt(
                            index, Task(task.name, task.description, true))},
                        icon: Icon(Icons.done)
                    ) :
                    IconButton(
                        onPressed: () =>
                        {tasksBox.putAt(
                            index, Task(task.name, task.description, false))},
                        icon: Icon(Icons.undo)
                    ),
                    IconButton(
                        onPressed: () => {tasksBox.deleteAt(index)},
                        icon: Icon(Icons.delete)
                    ),
                  ],
                ),
                onTap: () =>
                {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          AddTaskPage(name: task.name,
                            description: task.description,
                            taskIndex: index,),
                    ),
                  )
                },
              );
            }
            else return Container();
          },
        );
      }
      else {
        return ListView.builder(
          itemCount: tasksBox.length,
          itemBuilder: (context, index) {
            final task = tasksBox.getAt(index) as Task;
            return ListTile(
              title: task.isDone ? Text(task.name, style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.bold)) : Text(task.name),
              subtitle: Container(
                child: Text(
                  task.description,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                width: 50,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  !task.isDone ?
                  IconButton(
                      onPressed: () =>
                      {tasksBox.putAt(
                          index, Task(task.name, task.description, true))},
                      icon: Icon(Icons.done)
                  ) :
                  IconButton(
                      onPressed: () =>
                      {tasksBox.putAt(
                          index, Task(task.name, task.description, false))},
                      icon: Icon(Icons.undo)
                  ),
                  IconButton(
                      onPressed: () => {tasksBox.deleteAt(index)},
                      icon: Icon(Icons.delete)
                  ),
                ],
              ),
              onTap: () =>
              {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        AddTaskPage(name: task.name,
                          description: task.description,
                          taskIndex: index,),
                  ),
                )
              },
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("ToDo"),
            SizedBox(width: 200,),
            DropdownButton<String>(
              value: filter,
              items: [
                 DropdownMenuItem<String>(
                  value: "all",
                  child: Text("Все"),
                 ),
                DropdownMenuItem<String>(
                  value: 'done',
                  child: Text("Сделано"),
                ),
                DropdownMenuItem<String>(
                  value: 'not_done',
                  child: Text("Текущие"),
                ),
                ],
              onChanged: (value) {
                setState(() {
                  filter = value!;
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildListView()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => {
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AddTaskPage(),
                    ),
                  )
                },
            ),
          )
        ],
      ),
    );
  }
}
