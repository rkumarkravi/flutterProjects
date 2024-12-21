import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Expense.dart';
import '../db/DatabaseHelper.dart';

class ManualExpenseForm extends StatefulWidget {
  final Function()? onSave;

  final trackerId; // Callback for when the form is saved

  const ManualExpenseForm({super.key, this.onSave,this.trackerId});

  @override
  _ManualExpenseFormState createState() => _ManualExpenseFormState();
}

class _ManualExpenseFormState extends State<ManualExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String? _selectedCategory;
  final List<String> _categories = [
    'Groceries',
    'Rent',
    'Utilities',
    'Entertainment',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Field
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Date Picker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text('Select Date'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Category'),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Description Field (Optional)
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description (Optional)'),
                maxLines: 3,
              ),
              SizedBox(height: 24),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Save Expense'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Date Picker Handler
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Submit Form Handler
  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final expense = Expense(
        date: DateFormat('yyyy-MM-dd').format(_selectedDate),
        amount: double.parse(_amountController.text),
        category: _selectedCategory!,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : '',
        trackerId: widget.trackerId,
      );

      // Save expense to database
      await DatabaseHelper.instance.insertExpense(expense);

      // Notify user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Expense added successfully!')),
      );

      // Call the optional onSave callback and close the form
      if (widget.onSave != null) widget.onSave!();
      Navigator.pop(context);
    }
  }
}
