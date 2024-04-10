import 'dart:convert';
import 'package:activmind_app/Screens/tasklist.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFormPage extends StatefulWidget {
  final bool create;
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic>? locationData;
  const MyFormPage({Key? key, required this.create, required this.formKey, this.locationData}) : super(key: key);

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dodateController;
  late TextEditingController strtimeController;
  late TextEditingController endtimeController;
  late bool alarm;
  late bool repetation;
  late bool done;

  Future<void> updateTask(Map<String, dynamic>? taskData) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String apiUrl = 'http://10.0.2.2:8000/tasks/${taskData?["id"]}/'; // Update the URL with your API endpoint

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(taskData), // Convert task data to JSON format
    );

    if (response.statusCode == 200) {
      // Task updated successfully
      print('Task updated successfully');
      
    } else {
      // Task update failed
      print('Failed to update task. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Exception occurred while updating task
    print('Error updating task: $error');
  }
}


Future<void> createTask(Map<String, dynamic>? taskData) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    const String apiUrl = 'http://10.0.2.2:8000/tasks/'; // Update the URL with your API endpoint

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(taskData), // Convert task data to JSON format
    );
    print(jsonEncode(taskData));
    print(response.headers);

    if (response.statusCode == 200) {
      // Task updated successfully
      print('Task updated successfully');
      const TaskList();
      // home: TaskList();
    } else {
      // Task update failed
      print('Failed to update task. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Exception occurred while updating task
    print('Error updating task: $error');
  }
}

  

  @override
  void initState() {
    super.initState();
    // Initialize boolean variables based on taskData
    
    titleController = TextEditingController(text: widget.locationData?["title"]);
    descriptionController = TextEditingController(text: widget.locationData?["discription"]);
    dodateController = TextEditingController(text: widget.locationData?["do_date"]);
    strtimeController = TextEditingController(text: widget.locationData?["start_time"]);
    endtimeController = TextEditingController(text: widget.locationData?["end_time"]);
    alarm = widget.locationData?["alarm"] ?? false;
    repetation = widget.locationData?["repetation"] ?? false;
    done = widget.locationData?["done"] ?? false;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.create ? 'Create Task' : 'Modify Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        // child: MyForm(
        //   formKey: _formKey,
        //   create: widget.create,
        //   // Pass other necessary variables to MyForm widget
        // ),
      ),
    );
  }
}
