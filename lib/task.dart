import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isDone;

  Task(this.name, this.description, this.isDone);
}