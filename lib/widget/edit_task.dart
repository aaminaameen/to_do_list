import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/bloc/to_do_bloc.dart';
import 'package:to_do_list/model/task.dart';
import 'package:to_do_list/style/color_constant.dart';
import 'package:to_do_list/style/style_constant.dart';
import 'package:to_do_list/widget/date_format.dart';

class EditTaskDialog {
  static void show(BuildContext context, int index, Task existingTask) {
    final TextEditingController taskController =
        TextEditingController(text: existingTask.title);
    DateTime selectedDate = existingTask.date;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Task',
            style: TextStyle(color: ColorPalette.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration:
                    const InputDecoration(hintText: 'Enter new task title'),
              ),
              kHeight10,
              TextButton(
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (date != null && date != selectedDate) {
                    selectedDate = date;
                  }
                },
                child: Text(
                  'Selected Date: ${selectedDate.toLocal().toShortDateString()}',
                  style: const TextStyle(color: ColorPalette.primary),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  final updatedTask = Task(
                    title: taskController.text,
                    date: selectedDate,
                    isCompleted: existingTask.isCompleted,
                  );
                  context.read<ToDoBloc>().add(EditTask(index, updatedTask));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task title cannot be empty')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
