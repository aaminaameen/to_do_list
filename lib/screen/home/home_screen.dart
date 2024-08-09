import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/bloc/to_do_bloc.dart';
import 'package:to_do_list/style/color_constant.dart';
import 'package:to_do_list/widget/add_task.dart';

import 'package:to_do_list/widget/date_format.dart';
import 'package:to_do_list/widget/edit_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'To-Do List',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: BlocBuilder<ToDoBloc, ToDoLoadState>(
          builder: (context, state) {
            if (state.tasks.isEmpty) {
              return Center(
                child: Text('No tasks available.',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: ColorPalette.black)),
              );
            }

            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Slidable(
                  key: ValueKey(task.title),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          EditTaskDialog.show(context, index, task);
                        },
                        backgroundColor: ColorPalette.primary.withOpacity(.8),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          context.read<ToDoBloc>().add(DeleteTask(index));
                        },
                        backgroundColor: ColorPalette.error,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      activeColor: ColorPalette.primary,
                      checkColor: ColorPalette.white,
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        context
                            .read<ToDoBloc>()
                            .add(ToggleTaskCompletion(index));
                      },
                    ),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${task.title}\n',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                          ),
                          TextSpan(
                            text: task.date.toLocal().toShortDateString(),
                            style: TextStyle(
                              color: ColorPalette.black,
                              fontSize: 12,
                              height: 1.2,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: ColorPalette.white,
          ),
          onPressed: () {
            AddTaskDialog.show(context);
          },
        ),
      ),
    );
  }
}
