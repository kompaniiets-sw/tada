import 'package:flutter/material.dart';
import 'package:forui/forui.dart'; // Переконайтесь, що forui імпортовано
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tada/helpers/helper_functions.dart';
import 'package:tada/features/components/tasks/project_container.dart';
import 'package:tada/utils/constants/colors.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? EColors.dark : EColors.light,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: dark ? EColors.white : EColors.black,
        onPressed: () {},
        label: Text(
          'Add',
          style: TextStyle(color: dark ? EColors.dark : EColors.light),
        ),
        icon: Icon(
          Icons.add,
          color: dark ? EColors.dark : EColors.light,
          size: 25,
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: CustomSlidingSegmentedControl<int>(
                  isStretch: true,
                  initialValue: _selectedIndex,
                  children: {
                    0: Text(
                      'Projects',
                      style: TextStyle(
                        color: dark ? EColors.white : EColors.black,
                      ),
                    ),
                    1: Text(
                      'Tasks',
                      style: TextStyle(
                        color: dark ? EColors.white : EColors.black,
                      ),
                    ),
                  },
                  decoration: BoxDecoration(
                    color: dark ? EColors.black : EColors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: dark ? EColors.darkerGrey : EColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  onValueChanged: (v) {
                    setState(() {
                      _selectedIndex = v;
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [ProjectsContent(), TasksContent()],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectsContent extends StatelessWidget {
  const ProjectsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        const SizedBox(height: 8),
        FLineCalendar(
          // Припускаємо, що FLineCalendar працює коректно
          controller: FCalendarController.date(
            initialSelection: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ),

        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProjectContainerWidget(
              projectName: 'Проєкт ${index + 1}',
              time: '00:00:00',
              isDark: dark,
            );
          },
        ),
      ],
    );
  }
}

class TasksContent extends StatelessWidget {
  const TasksContent({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: FLineCalendar(
            // Припускаємо, що FLineCalendar працює коректно
            controller: FCalendarController.date(
              initialSelection: DateTime.now().subtract(
                const Duration(days: 1),
              ),
            ),
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProjectContainerWidget(
              projectName: 'Завдання ${index + 1}',
              time: '00:00:00',
              isDark: dark,
            );
          },
        ),
      ],
    );
  }
}
