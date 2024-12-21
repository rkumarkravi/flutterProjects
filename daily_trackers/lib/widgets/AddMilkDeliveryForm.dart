import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/MilkDelivery.dart';
import '../db/DatabaseHelper.dart';

class AddMilkDeliveryForm extends StatefulWidget {
  final int trackerId;
  const AddMilkDeliveryForm({super.key, required this.trackerId});

  @override
  _AddMilkDeliveryFormState createState() => _AddMilkDeliveryFormState();
}

class _AddMilkDeliveryFormState extends State<AddMilkDeliveryForm> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _milkmanController = TextEditingController();

  // Initialize date picker to show the current date
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    print(DatabaseHelper.instance.appDefaults);
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
    _priceController.text = DatabaseHelper.instance.appDefaults['milk_price_${widget.trackerId}']!;
    _milkmanController.text = DatabaseHelper.instance.appDefaults['milk_man_name_${widget.trackerId}']!;
    _quantityController.text = DatabaseHelper.instance.appDefaults['milk_quantity_${widget.trackerId}']!;
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
      final date = _dateController.text;
      final quantity = double.tryParse(_quantityController.text) ?? 0.0;
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final milkmanName = _milkmanController.text;

      // Create a MilkDelivery object
      final milkDelivery = MilkDelivery(
        date: date,
        quantity: quantity,
        price: price,
        milkmanName: milkmanName,
        trackerId: widget.trackerId,
      );

      print(milkDelivery.toString());
      // Insert the delivery into the database
      DatabaseHelper.instance.insertMilkDelivery(milkDelivery).then((_) {
        // Show a message and pop the screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Milk delivery added successfully!')),
        );
        Navigator.pop(context, true); // Pop and return to the previous screen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Milk Delivery')),
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

              // Quantity Field
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity (liters)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity of milk';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),

              // Price Field
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),

              // Milkman Name Field (Optional)
              TextFormField(
                controller: _milkmanController,
                decoration: InputDecoration(
                  labelText: 'Milkman Name (Optional)',
                ),
              ),

              // Submit Button
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
