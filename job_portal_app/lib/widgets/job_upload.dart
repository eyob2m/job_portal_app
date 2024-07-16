// ignore_for_file: deprecated_member_use, avoid_print, prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class JobUpload extends StatefulWidget {
  @override
  _JobUploadState createState() => _JobUploadState();
}

class _JobUploadState extends State<JobUpload> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadJob() async {
    if (_formKey.currentState!.validate() && _image != null) {
      var uri = Uri.parse("http://192.168.158.34:80/api/createjob");
      var request = http.MultipartRequest("POST", uri);

      request.headers.addAll(
          {"Accept": "application/json", "Content-Type": "application/json"});

      var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
      var length = await _image!.length();

      var multipartFile = http.MultipartFile('company_logo', stream, length,
          filename: basename(_image!.path));

      request.files.add(multipartFile);

      request.fields['company_name'] = _companyNameController.text;
      request.fields['title'] = _titleController.text;
      request.fields['description'] = _descriptionController.text;
      request.fields['location'] = _locationController.text;
      request.fields['salary'] = _salaryController.text;
      request.fields['start_date'] = _startDateController.text;
      request.fields['end_date'] = _endDateController.text;

      print("sending data to server");

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        print("Job uploaded successfully");
      } else {
        print("response body: $responseBody");
        print("Upload failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _companyNameController,
                decoration: InputDecoration(labelText: 'Company Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter salary';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                    labelText: 'Start Date', hintText: "DD/MM/YY"),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DateInputFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                    labelText: 'End Date', hintText: "DD/MM/YY"),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DateInputFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter end date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Pick Company Logo'),
                  ),
                  SizedBox(width: 20),
                  _image != null
                      ? Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                        )
                      : Text('No image selected.'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadJob,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length > 8) {
      return oldValue;
    }
    StringBuffer newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      newText.write(text[i]);
      if ((i == 1 || i == 3) && i != text.length - 1) {
        newText.write('-');
      }
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
