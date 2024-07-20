import 'package:intl/intl.dart';
import 'package:todoist/state_redux/app_state.dart';
import 'package:todoist/state_redux/actions.dart';

import '../models/todoist_model.dart';

AppState reducer(AppState prevState, dynamic action) {
  //AppState newState = AppState.fromAppState(prevState);

  void addToNote(TodoistModel model) {
    var todaysDate = DateTime.now();
    String dateWise = DateFormat.yMMMMd().format(todaysDate).toString();
    model.date = DateFormat.jms().format(todaysDate).toString();
    if (!prevState.todos.containsKey(dateWise)) {
      List<TodoistModel> list = [];
      list.add(model);
      prevState.todos[dateWise] = list;
    } else {
      prevState.todos[dateWise]?.add(model);
    }
  }

  if (action is AddTodo) {
    addToNote(action.payload);
  }

  return prevState;
}
