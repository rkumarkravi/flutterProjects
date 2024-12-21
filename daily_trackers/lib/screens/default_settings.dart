import 'package:flutter/material.dart';

import '../models/DefaultSetting.dart';
import '../db/DatabaseHelper.dart';
class DefaultSettings extends StatefulWidget {
  const DefaultSettings({super.key});

  @override
  _DefaultSettingsState createState() => _DefaultSettingsState();
}

class _DefaultSettingsState extends State<DefaultSettings> {
  List<DefaultSetting> settings = [];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from the database
  Future<void> _loadSettings() async {
    List<DefaultSetting> allSettings =
    await DatabaseHelper.instance.fetchAllDefaults();
    setState(() {
      settings = allSettings;
    });
  }

  // Show dialog to update a setting
  void _updateSetting(DefaultSetting setting) {
    final TextEditingController _valueController =
    TextEditingController(text: setting.value);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Defaults'),
        content: TextField(
          controller: _valueController,
          decoration: InputDecoration(labelText: 'Value'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_valueController.text.isNotEmpty) {
                await DatabaseHelper.instance.insertOrUpdateDefault(
                    setting.key, _valueController.text);
                Navigator.pop(context);
                _loadSettings();
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  // Delete a setting
  void _deleteSetting(String key) async {
    await DatabaseHelper.instance.deleteSetting(key);
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          final setting = settings[index];
          return Card(
            child: ListTile(
              title: Text(setting.key),
              subtitle: Text(setting.value ?? 'No value set'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _updateSetting(setting),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteSetting(setting.key),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSetting,
        child: Icon(Icons.add),
      ),
    );
  }

  // Show dialog to add a new setting
  void _addSetting() {
    final TextEditingController _keyController = TextEditingController();
    final TextEditingController _valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Setting'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _keyController,
              decoration: InputDecoration(labelText: 'Key'),
            ),
            TextField(
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Value'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_keyController.text.isNotEmpty) {
                await DatabaseHelper.instance.insertOrUpdateDefault(
                    _keyController.text, _valueController.text);
                Navigator.pop(context);
                _loadSettings();
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
