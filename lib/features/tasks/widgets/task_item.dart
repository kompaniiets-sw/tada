import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada/features/tasks/controllers/tasks_controller.dart';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/utils/constants/sizes.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = TasksController.instance;

    return Card(
      margin: const EdgeInsets.only(bottom: ESizes.spaceBtwItems),
      child: ListTile(
        leading: Obx(
          () => Checkbox(
            value: task.isCompleted.value,
            onChanged: (value) => controller.toggleTask(task),
          ),
        ),
        title: Obx(
          () => Text(
            task.title,
            style: TextStyle(
              decoration:
                  task.isCompleted.value
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
            ),
          ),
        ),
        subtitle: Text(task.description),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: EColors.error),
          onPressed: () => controller.removeTask(task),
        ),
      ),
    );
  }
}
