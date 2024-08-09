part of 'to_do_bloc.dart';

@immutable
abstract class ToDoState {}

class ToDoLoadState extends ToDoState{
  final List<Task> tasks;

   ToDoLoadState({this.tasks = const <Task>[]});

  List<Object?> get props => [tasks];
}
