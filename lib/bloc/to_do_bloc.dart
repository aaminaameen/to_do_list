import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_list/model/task.dart';
import 'package:to_do_list/service/task_service.dart';
part 'to_do_event.dart';
part 'to_do_state.dart';



class ToDoBloc extends Bloc<ToDoEvent, ToDoLoadState> {
  final TaskStorageService _storageService = TaskStorageService();

  ToDoBloc() : super(ToDoLoadState()) {
    on<AddTask>(_onAddTask);
    on<EditTask>(_onEditTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);

    _loadTasks();
  }

  Future<void> _onAddTask(AddTask event, Emitter<ToDoLoadState> emit) async {
    final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
    await _storageService.saveTasks(updatedTasks);
    emit(ToDoLoadState(tasks: updatedTasks));
  }

  Future<void> _onEditTask(EditTask event, Emitter<ToDoLoadState> emit) async {
    final updatedTasks = List<Task>.from(state.tasks)
      ..[event.index] = event.task;
    await _storageService.saveTasks(updatedTasks);
    emit(ToDoLoadState(tasks: updatedTasks));
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<ToDoLoadState> emit) async {
    final updatedTasks = List<Task>.from(state.tasks)..removeAt(event.index);
    await _storageService.saveTasks(updatedTasks);
    emit(ToDoLoadState(tasks: updatedTasks));
  }

  Future<void> _onToggleTaskCompletion(ToggleTaskCompletion event, Emitter<ToDoLoadState> emit) async {
    final updatedTask = state.tasks[event.index]
        .copyWith(isCompleted: !state.tasks[event.index].isCompleted);
    final updatedTasks = List<Task>.from(state.tasks)
      ..[event.index] = updatedTask;
    await _storageService.saveTasks(updatedTasks);
    emit(ToDoLoadState(tasks: updatedTasks));
  }

  Future<void> _loadTasks() async {
    final tasks = await _storageService.loadTasks();
    emit(ToDoLoadState(tasks: tasks)); 
  }
}
