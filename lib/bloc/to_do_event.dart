part of 'to_do_bloc.dart';

@immutable
abstract class ToDoEvent {}

class AddTask extends ToDoEvent {
  final Task task;

   AddTask(this.task);

  
  List<Object?> get props => [task];
}

class EditTask extends ToDoEvent {
  final int index;
  final Task task;

   EditTask(this.index, this.task);

  
  List<Object?> get props => [index, task];
}

class DeleteTask extends ToDoEvent {
  final int index;

   DeleteTask(this.index);

  List<Object?> get props => [index];
}

class ToggleTaskCompletion extends ToDoEvent {
  final int index;

   ToggleTaskCompletion(this.index);

  List<Object?> get props => [index];
}
