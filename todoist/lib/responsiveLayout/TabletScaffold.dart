import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todoist/configs/Consts.dart';
import 'package:todoist/models/todoist_model.dart';
import 'package:todoist/screens/home_page.dart';
import 'package:todoist/state_redux/actions.dart';

import '../othercomps/DividerWithText.dart';
import '../othercomps/NoteNode.dart';
import '../state_redux/app_state.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  _TabletScaffoldState createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  List<Widget> getAllNoteList(noteMapOfList) {
    List<Widget> notesDate = [];

    for (var e in noteMapOfList.entries) {
      notesDate.add(DividerWithText(text: e.key));
      notesDate.add(const SizedBox(
        height: 10,
      ));
      List<Widget> notesGridList = [];
      for (var f in e.value.reversed) {
        notesGridList.add(NoteNode(model: f));
      }

      notesDate.add(GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1.3,
          shrinkWrap: true,
          children: notesGridList));
    }

    return notesDate;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    final textController = TextEditingController();
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.9),
                      child: Column(
                        children: getAllNoteList(state.todos),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
