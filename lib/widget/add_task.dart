import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/bloc/to_do_bloc.dart';
import 'package:to_do_list/model/task.dart';
import 'package:to_do_list/style/color_constant.dart';
import 'package:to_do_list/style/style_constant.dart';
import 'package:to_do_list/widget/date_format.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AddTaskDialog();
      },
    );
  }

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController taskController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'New Task',
        style: TextStyle(color: ColorPalette.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add a new task to your to-do list.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: taskController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(1960),
                lastDate: DateTime(2101),
              );
              if (date != null && date != selectedDate) {
                setState(() {
                  selectedDate = date;
                });
              }
            },
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: ColorPalette.primary,
                ),
                kWidth5,
                Text(
                  selectedDate.toLocal().toShortDateString(),
                  style: const TextStyle(color: ColorPalette.primary),
                ),
              ],
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
              final task = Task(
                title: taskController.text,
                date: selectedDate,
              );
              context.read<ToDoBloc>().add(AddTask(task));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task title cannot be empty')),
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
