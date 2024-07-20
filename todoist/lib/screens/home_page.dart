import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:todoist/models/todoist_model.dart';
import 'package:todoist/othercomps/DividerWithText.dart';
import 'package:todoist/othercomps/NoteNode.dart';
import 'package:todoist/state_redux/actions.dart';

import '../state_redux/app_state.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  Map<String, List<TodoistModel>> noteMapOfList =
      <String, List<TodoistModel>>{};

  List<Widget> getAllNoteList(noteMapOfList) {
    List<Widget> notes = [];

    for (var e in noteMapOfList.entries) {
      notes.add(DividerWithText(text: e.key));
      notes.add(const SizedBox(
        height: 10,
      ));
      for (var f in e.value.reversed) {
        notes.add(NoteNode(model: f));
      }
    }

    return notes;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: screenWidth - 100,
                            child: TextField(
                                controller: textController,
                                decoration: const InputDecoration(
                                    hintText: "Add your todo 😀",
                                    filled: true,
                                    prefixIcon: Icon(Icons.note))),
                          ),
                          TextButton(
                              onPressed: () {
                                if (textController.text != '') {
                                  TodoistModel model = TodoistModel();
                                  model.text = textController.text;
                                  model.completed = false;
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(AddTodo(model));
                                  textController.clear();
                                }
                              },
                              child: const Text("Submit"))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getAllNoteList(state.todos),
                          )),
                    )
                  ],
                );
              })),
    );
  }
}
