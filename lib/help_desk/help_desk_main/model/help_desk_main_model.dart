import 'package:senior_project/core/model/help_desk/task.dart';

class HelpDeskMainModel {
  List<Task> _tasks = [];

  HelpDeskMainModel();

  HelpDeskMainModel.overloaddedConstructor(List<Task> tasks) {
    _tasks = tasks;
  }

  List<Task> get getTask => _tasks;
  Task getTaskIndex(int index) => _tasks[index];

  void addTask(Task task) {
    _tasks.add(task);
  }

  void addTaskList(List<Task> tasks) {
    _tasks.addAll(tasks);
  }

  Map<String, dynamic> getTaskDetail(int index) {
    return {
      "id": "#${_tasks[index].getTaskId}",
      "taskHeader": _tasks[index].getTitle,
      "taskDetail": _tasks[index].getContent.getText,
      "priority": _tasks[index].getPriority, 
      "status": _tasks[index].getStatus, 
      "category": _tasks[index].getCategory,
      "time": _tasks[index].getDateCreate
    };
  }
}
