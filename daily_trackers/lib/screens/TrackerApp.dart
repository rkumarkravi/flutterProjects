import 'package:daily_trackers/widgets/NotesFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:daily_trackers/screens/default_settings.dart';
import 'package:daily_trackers/screens/dev_info.dart';
import 'package:daily_trackers/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_handler/share_handler.dart';
import '../models/Tracker.dart';
import '../db/DatabaseHelper.dart';
import '../providers/ThemeProvider.dart';
import '../widgets/TrackerFormScreen.dart';
import 'CalenderScreen.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
);
void main() async {
  runApp(TrackerApp());
}

class TrackerApp extends StatelessWidget {
  const TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Tracker App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: const TrackerListScreen(),
    );
  }
}

class TrackerListScreen extends StatefulWidget {
  const TrackerListScreen({super.key});

  @override
  _TrackerListScreenState createState() => _TrackerListScreenState();
}

class _TrackerListScreenState extends State<TrackerListScreen> {
  List<Tracker> trackers = [];

  @override
  void initState() {
    super.initState();
    fetchTrackers();
    initPlatformState();
  }

  SharedMedia? media;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final handler = ShareHandlerPlatform.instance;
    media = await handler.getInitialSharedMedia();

    handler.sharedMediaStream.listen((SharedMedia media) {
      print(media);
      if (!mounted) return;
      setState(() {
        this.media = media;
      });
      if(this.media !=null && this.media?.content!=null){
        print(this.media?.content);
        _navigateToSpecificScreen(this.media?.content);
      }
    });
    if (!mounted) return;
  }

  void _navigateToSpecificScreen(String? value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotesFormScreen(note: value, trackerId: 1,),
      ),
    );
  }

  Future<void> fetchTrackers() async {
    final db = DatabaseHelper.instance;
    DatabaseHelper.instance.loadDefaults();
    final trackerData = await db.query('Trackers');
    setState(() {
      trackers = trackerData.map((e) => Tracker.fromMap(e)).toList();
    });
  }

  Future<void> deleteTracker(int trackerId) async {
    final db = DatabaseHelper.instance;

    // Delete the tracker
    await db.database.then(
      (dbInstance) => dbInstance.delete(
        'Trackers',
        where: 'id = ?',
        whereArgs: [trackerId],
      ),
    );

    // Delete associated entries
    await db.database.then(
      (dbInstance) => dbInstance.delete(
        'Entries',
        where: 'tracker_id = ?',
        whereArgs: [trackerId],
      ),
    );

    setState(() {
      trackers.removeWhere((tracker) => tracker.id == trackerId);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Tracker deleted successfully')));
  }

  void confirmDeleteTracker(int trackerId, String trackerName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Tracker'),
          content: Text('Are you sure you want to delete "$trackerName"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteTracker(trackerId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String getTrailingData(tracker, snapshot) {
      switch (tracker.type) {
        case 'Manual Expense':
          return '₹ ${snapshot.data!}';
        case 'Milk Delivery':
          return '₹ ${snapshot.data!}';
        default:
          return '';
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('My Trackers'), actions: [PopupMenu()]),
      body: ListView.separated(
        itemCount: trackers.length,
        itemBuilder: (context, index) {
          final tracker = trackers[index];
          return GestureDetector(
            onLongPress: () {
              confirmDeleteTracker(tracker.id!, tracker.name);
            },
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CalendarScreen(
                          trackerId: tracker.id!,
                          trackerObj: tracker,
                        ),
                  ),
                ).then((_) {
                  fetchTrackers(); // Reload entries after adding
                });
                ;
              },
              child: ListTile(
                horizontalTitleGap: 5,
                title: Text(tracker.name),
                subtitle: Text('Type: ${tracker.type} , id: ${tracker.id}'),
                trailing: FutureBuilder<double>(
                  future: DatabaseHelper.instance.fetchSumByIdCurrMonth(
                    tracker.id!,
                    tracker.type,
                  ), // The async operation
                  builder: (context, snapshot) {
                    // Handle different states of the Future
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading spinner while waiting for the result
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Show an error message if something went wrong
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      // Display the result once the data is fetched
                      return Text(
                        getTrailingData(tracker, snapshot),
                        style: TextStyle(fontSize: 15),
                      );
                    } else {
                      // If the future returns no data
                      return Text('No data available');
                    }
                  },
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            // Separator widget
            color: Colors.grey,
            thickness: 1,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TrackerFormScreen()),
          );
          if (result == true) {
            fetchTrackers();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder:
          (BuildContext context) => <PopupMenuItem<int>>[
            PopupMenuItem<int>(value: 1, child: Text('Default Values')),
            PopupMenuItem<int>(value: 2, child: Text('Settings')),
            PopupMenuItem<int>(value: 3, child: Text('Developer Info')),
          ],
      onSelected: (int value) {
        if (value == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DefaultSettings()),
          );
        } else if (value == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsScreen()),
          );
        }else if (value == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeveloperInfoWidget()),
          );
        }
      },
    );
  }
}
