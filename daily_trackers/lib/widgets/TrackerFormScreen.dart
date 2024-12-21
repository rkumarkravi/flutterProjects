import 'package:flutter/material.dart';
import '../models/Tracker.dart';
import '../db/DatabaseHelper.dart';

class TrackerFormScreen extends StatefulWidget {
  const TrackerFormScreen({super.key});

  @override
  _TrackerFormScreenState createState() => _TrackerFormScreenState();
}

class _TrackerFormScreenState extends State<TrackerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String type = 'Select Tracker Type';
  String? goal = '';
  List<String> types=['Select Tracker Type','Milk Delivery', 'Manual Expense','Notes'];

  Future<void> saveTracker() async {
    final tracker = Tracker(name: name, type: type, goal: goal);
    int rowId=await DatabaseHelper.instance.insert('Trackers', tracker.toMap());

    final List<Map<String, dynamic>> result = await DatabaseHelper.instance.queryCols(
      'Trackers',
      columns: ['id'],
      where: 'rowid = ?',
      whereArgs: [rowId],
      limit: 1,
    );

    if(type=='Milk Delivery'){
      if (result.isNotEmpty) {
        int trackerId = result.first['id'] as int;
        DatabaseHelper.instance.insertOrUpdateDefault("milk_price_$trackerId", '75');
        DatabaseHelper.instance.insertOrUpdateDefault("milk_man_name_$trackerId", 'ENTER NAME');
        DatabaseHelper.instance.insertOrUpdateDefault("milk_quantity_$trackerId", '1.5');
      } else {
        throw Exception('Failed to retrieve trackerId');
      }
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tracker Name'),
                validator: (value) => value == null || value.isEmpty ? 'Name required' : null,
                onSaved: (value) => name = value!,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Tracker Type'),
                value: type,
                validator: (value) => value==null || value.isEmpty || value=='Select Tracker Type' ? 'Tracker Type required':null,
                items:
                    types.map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => type = value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Goal (Optional)'),
                onSaved: (value) => goal = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    saveTracker();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
