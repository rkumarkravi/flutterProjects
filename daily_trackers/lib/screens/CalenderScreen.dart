import 'package:flutter/material.dart';
import 'package:daily_trackers/models/MilkDelivery.dart';
import 'package:daily_trackers/models/Tracker.dart';
import 'package:daily_trackers/widgets/AddMilkDeliveryForm.dart';
import 'package:daily_trackers/widgets/ManualExpenseForm.dart';
import 'package:table_calendar/table_calendar.dart';
import '../db/DatabaseHelper.dart';
import 'package:intl/intl.dart';

import '../widgets/NotesFormScreen.dart';

class CalendarScreen extends StatefulWidget {
  final int trackerId; // Link the calendar to a specific tracker
  final Tracker trackerObj;

  const CalendarScreen({
    super.key,
    required this.trackerId,
    required this.trackerObj,
  });

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarFormat _calendarFormat;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  List<dynamic> _entries = [];
  late Future<List<dynamic>> _datesAvailable;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _datesAvailable = DatabaseHelper.instance.fetchAllItemsByIdCurrMonth(
      widget.trackerId,
      widget.trackerObj.type,
    );
    _loadEntriesForDate(_selectedDay!);
  }

  Future<void> _loadEntriesForDate(DateTime date) async {
    final db = DatabaseHelper.instance;
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // Fetch data based on the type (from the relevant table)
    List<Map<String, dynamic>> result;
    print("getting data");
    switch (widget.trackerObj.type) {
      case 'Milk Delivery':
        result = await db.query(
          'MilkDelivery',
          where: 'date = ? AND tracker_id=?',
          whereArgs: [formattedDate, widget.trackerId],
        );
        _entries = result.map((entry) => MilkDelivery.fromMap(entry)).toList();
        break;
      case 'Water Intake':
        // result = await db.query('WaterIntake', where: 'date = ?', whereArgs: [formattedDate]);
        // _entries = result.map((entry) => WaterIntake.fromMap(entry)).toList();
        break;
      case 'Manual Expense':
        _entries = await DatabaseHelper.instance.fetchExpensesByDate(
          formattedDate,
          widget.trackerId,
        );
        break;
      case 'Notes':
        _entries = await DatabaseHelper.instance.fetchNotesByDate(
          formattedDate,
          widget.trackerId,
        );
        break;
      default:
        _entries = [];
    }

    setState(() {});
  }

  void _openAddEntryForm() {
    switch (widget.trackerObj.type) {
      case 'Milk Delivery':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => AddMilkDeliveryForm(trackerId: widget.trackerId),
          ),
        ).then((_) {
          _loadEntriesForDate(_selectedDay!); // Reload entries after adding
        });
        break;
      case 'Water Intake':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => AddMilkDeliveryForm(trackerId: widget.trackerId),
          ),
        ).then((_) {
          _loadEntriesForDate(_selectedDay!); // Reload entries after adding
        });
        break;
      case 'Manual Expense':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ManualExpenseForm(trackerId: widget.trackerId),
          ),
        ).then((_) {
          _loadEntriesForDate(_selectedDay!); // Reload entries after adding
        });
        break;
      case 'Notes':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesFormScreen(trackerId: widget.trackerId),
          ),
        ).then((_) {
          _loadEntriesForDate(_selectedDay!); // Reload entries after adding
        });
        break;
      default:
        ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Calendar View | ${widget.trackerObj.type}')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                // _note = _notesByDate[selectedDay] ?? '';
                _loadEntriesForDate(_selectedDay!);
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, _) {
                return FutureBuilder(
                  future: checkAnyEntryForDate(date),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data == true) {
                      return Positioned(
                        bottom: 4,
                        child: Icon(Icons.circle, size: 16, color: Colors.blue),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                );
              },
            ),
          ),
          Expanded(child: getListByType()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEntryForm,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<bool> checkAnyEntryForDate(DateTime dateTime) {
    return _datesAvailable.then((data) {
      return data.any((entry) {
        print(entry.date);
        return dateTime.toShortString() == entry.date;
      });
    });
  }

  Widget getListByType() {
    switch (widget.trackerObj.type) {
      case 'Milk Delivery':
        return ListView.builder(
          itemCount: _entries.length,
          itemBuilder: (context, index) {
            final entry = _entries.toList()[index];
            final date = entry.date;
            final price = entry.price.toString();
            final quantity = entry.quantity.toString();
            return GestureDetector(
              onLongPress: () {
                confirmDeleteData(entry.id!, '${entry.date} milk entry');
              },
              child: ListTile(
                title: Text(date),
                subtitle: Text('$quantity L - ₹ $price'),
              ),
            );
          },
        );
      case 'Water Intake':
        return ListView.builder(
          itemCount: _entries.length,
          itemBuilder: (context, index) {
            final entry = _entries.toList()[index];
            final date = entry.date;
            final note = entry.price.toString();
            final quantity = entry.quantity.toString();
            return GestureDetector(
              onLongPress: () {
                confirmDeleteData(entry.id!, '${entry.date} water intake');
              },
              child: ListTile(
                title: Text(date),
                subtitle: Text('$quantity L - ₹ $note'),
              ),
            );
          },
        );
      case 'Manual Expense':
        return ListView.builder(
          itemCount: _entries.length,
          itemBuilder: (context, index) {
            final entry = _entries.toList()[index];
            final date = entry.date;
            final note = entry.description.toString();
            final amount = entry.amount.toString();
            final cat = entry.category.toString();
            return GestureDetector(
              onLongPress: () {
                confirmDeleteData(entry.id!, '$note expense');
              },
              child: ListTile(
                title: Text('$date | $cat'),
                subtitle: Text('$note of ₹ $amount'),
              ),
            );
          },
        );
      case 'Notes':
        return ListView.builder(
          itemCount: _entries.length,
          itemBuilder: (context, index) {
            final entry = _entries.toList()[index];
            final date = entry.date;
            final note = entry.content.toString();
            final title = entry.title;
            return GestureDetector(
              onLongPress: () {
                confirmDeleteData(entry.id!, '$title note');
              },
              child: ListTile(
                title: Text('$date | $title'),
                subtitle: Text(note),
              ),
            );
          },
        );

      default:
        return SizedBox();
    }
  }

  void confirmDeleteData(int itemId, String itemName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Tracker'),
          content: Text('Are you sure you want to delete "$itemName"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                DatabaseHelper.instance.deleteItemById(
                  itemId,
                  widget.trackerObj.type,
                );
                _loadEntriesForDate(_selectedDay!);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

extension DateTimeExtensions on DateTime {
  String toShortString() {
    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }
}
