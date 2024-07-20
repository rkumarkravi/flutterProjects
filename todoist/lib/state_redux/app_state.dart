import 'package:todoist/models/todoist_model.dart';

class AppState {
  Map<String, List<TodoistModel>> todos = <String, List<TodoistModel>>{};

  AppState({required this.todos});

  AppState.fromAppState(AppState appState);
}
