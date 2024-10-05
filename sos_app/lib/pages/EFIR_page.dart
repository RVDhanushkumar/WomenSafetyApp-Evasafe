import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EFIRPage extends StatefulWidget {
  @override
  _EFIRPageState createState() => _EFIRPageState();
}

class _EFIRPageState extends State<EFIRPage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? phoneNumber;
  String? address;
  String? incidentDescription;
  File? imageFile;
  DateTime? selectedDate;
  
  // Method to pick image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  // Method to select incident date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // Method to submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Send data to server or police station via email
      // Display a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("FIR Submitted Successfully"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File E-FIR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value;
                },
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: selectedDate == null
                          ? 'Select Date of Incident'
                          : selectedDate.toString().split(' ')[0],
                    ),
                    validator: (value) {
                      if (selectedDate == null) {
                        return 'Please select the date of incident';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description of Incident'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe the incident';
                  }
                  return null;
                },
                onSaved: (value) {
                  incidentDescription = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Upload Evidence (Optional)'),
              ),
              if (imageFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.file(
                    imageFile!,
                    height: 200,
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit FIR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
