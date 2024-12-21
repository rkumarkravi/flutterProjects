import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Note.dart';
import '../db/DatabaseHelper.dart';

class NotesFormScreen extends StatefulWidget {
  final int trackerId;
  final Note? existingNote; // For editing a note (optional)
  final String? note;

  const NotesFormScreen({super.key, required this.trackerId, this.existingNote, this.note});

  @override
  _NotesFormScreenState createState() => _NotesFormScreenState();
}

class _NotesFormScreenState extends State<NotesFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _dateController = TextEditingController();

  // Initialize date picker to show the current date or note's date if editing
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // If editing an existing note, populate fields
    if (widget.existingNote != null) {
      final existingNote = widget.existingNote!;
      _titleController.text = existingNote.title;
      _contentController.text = existingNote.content;
      _selectedDate = DateTime.parse(existingNote.date);
    }
    if(widget.note!=null){
      _contentController.text=widget.note!;
    }
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  // Function to pick a date
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  // Function to submit the form
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Get values from the form
      final title = _titleController.text;
      final content = _contentController.text;
      final date = _dateController.text;

      // Create a Note object
      final note = Note(
        id: widget.existingNote?.id, // Use existing ID for updates
        title: title,
        content: content,
        date: date,
        trackerId: widget.trackerId,
      );

      // Insert or update the note in the database
      if (widget.existingNote == null) {
        // Add a new note
        DatabaseHelper.instance.insertNote(note).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Note added successfully!')),
          );
          Navigator.pop(context, true); // Pop and return to the previous screen
        });
      } else {
        // Update an existing note
        DatabaseHelper.instance.updateNote(note).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Note updated successfully!')),
          );
          Navigator.pop(context, true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingNote == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Date Picker Field
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _pickDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),

              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),

              // Content Field
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the content of the note';
                  }
                  return null;
                },
              ),

              // Submit Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.existingNote == null ? 'Submit' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
