import 'package:get/get.dart';

class TasksController extends GetxController {
  static TasksController get instance => Get.find();

  final tasks = <Task>[].obs;

  void addTask() {
    // Логіка додавання завдання
  }

  void removeTask(Task task) {
    tasks.remove(task);
  }

  void toggleTask(Task task) {
    task.isCompleted.toggle();
  }
}

class Task {
  final String title;
  final String description;
  final RxBool isCompleted;

  Task({
    required this.title,
    required this.description,
    bool isCompleted = false,
  }) : isCompleted = isCompleted.obs;
}
