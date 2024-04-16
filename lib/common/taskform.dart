import 'dart:convert';

import 'package:activmind_app/Screens/tasklist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class MyFormDialog extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic>? locationData;
  final bool create; 

  const MyFormDialog({super.key, required this.formKey, required this.locationData, required this.create});

  @override
  _MyFormDialogState createState() => _MyFormDialogState();
}

class _MyFormDialogState extends State<MyFormDialog> {
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
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 209, 193, 238),
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40,
            top: -40,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.close),
              ),
            ),
          ),
          Form(
            key: widget.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: "title",
                      hintText: 'Veuillez entrer un nom de l\'activité ',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 232, 217, 255),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nom de l\'activité';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.locationData?["title"] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "description",
                      hintText: 'Si vous voulez, vous pouvez entrer votre description (c\'est optionnel)',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 232, 217, 255),
                      filled: true,
                    ),
                    onSaved: (value) {
                      widget.locationData?["discription"] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: dodateController,
                    keyboardType: TextInputType.datetime,
                    // maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "date de fair",
                      hintText: 'Veuillez entrer un date de fair ',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 232, 217, 255),
                      filled: true,
                    ),
                    onSaved: (value) {
                      widget.locationData?["do_date"] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: strtimeController,
                    keyboardType: TextInputType.datetime,
                    // maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Heure de début",
                      hintText: 'Veuillez entrer une heure de début ',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 232, 217, 255),
                      filled: true,
                    ),
                    onSaved: (value) {
                      widget.locationData?["start_time"] = value;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: endtimeController,
                    keyboardType: TextInputType.datetime,
                    // maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Heure de fin",
                      hintText: 'Veuillez entrer une heure de fin ',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 232, 217, 255),
                      filled: true,
                    ),
                    onSaved: (value) {
                      widget.locationData?["end_time"] = value;
                    },
                  ),
                ),



                Row(
                  children: [
                    Checkbox(
                      value: alarm,
                      onChanged: (value) {
                        setState(() {
                          alarm = value ?? false; // Update the state variable
                        });
                      },
                    ),
                    const Text("Alarm"),
                  ],
                ),
                // Other form fields...
                Row(
                  children: [
                    Checkbox(
                      value: repetation,
                      onChanged: (value) {
                        setState(() {
                          repetation = value ?? false; // Update the state variable
                        });
                      },
                    ),
                    const Text("Repetation"),
                  ],
                ),
                // Other form fields...
                Row(
                  children: [
                    Checkbox(
                      value: done,
                      onChanged: (value) {
                        setState(() {
                          done = value ?? false; // Update the state variable
                        });
                      },
                    ),
                    const Text("Done"),
                  ],
                ),
                // Other form fields...
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 255, 255, 255), backgroundColor: const Color.fromARGB(255, 65, 64, 155),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Annuler'),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 44, 41, 223), backgroundColor: const Color.fromARGB(255, 255, 181, 70),
                        ),
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            widget.formKey.currentState!.save();
                            // Update taskData with the new values
                            
                            widget.locationData?["alarm"] = alarm;
                            widget.locationData?["repetation"] = repetation;
                            widget.locationData?["done"] = done;
                            // Call your API to update the task 
                            if (widget.create){
                              createTask(widget.locationData);
                            }
                            else{
                              updateTask(widget.locationData);
                              
                            }
                            Navigator.of(context).pop();
                            
                          }
                        },
                        child: const Text('Enregistrer'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
