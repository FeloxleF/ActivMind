import 'dart:convert';
import 'package:activmind_app/Screens/Calendar.dart';
import 'package:activmind_app/common/gen_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class createTask extends StatefulWidget {
  final Map<String, dynamic>? taskData;
  final String? operation;

  const createTask({Key? key, this.taskData, required this.operation})
      : super(key: key);

  @override
  State<createTask> createState() => _createTaskState();
}

class _createTaskState extends State<createTask> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  late final TextEditingController _timeendController;
  late final String operation;
  late final Map<String, dynamic> taskData;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late bool alarm;
  late bool repetation;
  late bool done;

  late final TextEditingController _dateIfCancel;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.taskData?['title'] ?? '');
    _descriptionController =
        TextEditingController(text: widget.taskData?['discription'] ?? '');
    _dateController =
        TextEditingController(text: widget.taskData?['do_date'] ?? '');
    _timeController =
        TextEditingController(text: widget.taskData?['start_time'] ?? '');
    _timeendController =
        TextEditingController(text: widget.taskData?['end_time'] ?? '');
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    alarm = widget.taskData?['alarm'] ?? false;
    repetation = widget.taskData?['repetition'] ?? false;
    done = widget.taskData?['done'] ?? false;

    _dateIfCancel =
        TextEditingController(text: widget.taskData?['do_date'] ?? '');

    operation = widget.operation ?? '';
    taskData = widget.taskData ?? {};
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter =
        DateFormat.Hms(); // 'H' for 24-hour format, 'm' for minutes
    return formatter.format(dt);
  }

  Future<void> selectOperation(
      String? operation, Map<String, dynamic>? taskData) async {
    print(operation);
    if (operation == 'creat') {
      createTask();
    } else {
      updateTask(taskData);
    }
  }

  Future<void> createTask() async {
    try {
      final form = _formKey.currentState;
      String title = _titleController.text;
      String description = _descriptionController.text;
      String dodate = _dateController.text;
      String strtime = _timeController.text;
      String endtime = _timeendController.text;

      if (endtime == '') {
        endtime = strtime;
      }

      Map<String, dynamic> taskData = {
        "title": title,
        "discription": description,
        "do_date": dodate,
        "start_time": strtime,
        "end_time": endtime,
        "alarm": alarm,
        "repetation": repetation,
      };
      if (form!.validate()) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        const String apiUrl = 'http://10.0.2.2:8000/tasks/';
        print(apiUrl);

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          },
          body: jsonEncode(taskData),
        );
        print(jsonEncode(taskData));
        print(response.headers);

        if (response.statusCode == 201) {
          // Task created successfully
          print('Task updated successfully');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => Calendar(
                    selectedDay:
                        DateFormat('yyyy-MM-dd').parse(_dateController.text)),
              ),
              (Route<dynamic> route) => false);
        } else {
          // Task creation failed
          print('Failed to create task. Status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      // Exception occurred while creating task
      print('Error creting task: $error');
    }
  }

  Future<void> updateTask(task) async {
    try {
      final form = _formKey.currentState;
      String title = _titleController.text;
      String description = _descriptionController.text;
      String dodate = _dateController.text;
      String strtime = _timeController.text;
      String endtime = _timeendController.text;

      if (endtime == '') {
        endtime = strtime;
      }

      Map<String, dynamic> taskData = {
        "title": title,
        "discription": description,
        "do_date": dodate,
        "start_time": strtime,
        "end_time": endtime,
        "alarm": alarm,
        "repetation": repetation,
        "id": task["id"]
      };
      if (form!.validate()) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        final String apiUrl = 'http://10.0.2.2:8000/tasks/${taskData["id"]}/';
        print(apiUrl);
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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => Calendar(
                    selectedDay:
                        DateFormat('yyyy-MM-dd').parse(_dateController.text)),
              ),
              (Route<dynamic> route) => false);
        } else {
          // Task update failed
          print('Failed to update task. Status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      // Exception occurred while updating task
      print('Error updating task: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 139, 140, 242),
        ),
        backgroundColor: const Color.fromARGB(255, 139, 140, 242),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: const Color.fromARGB(255, 139, 140, 242),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10.0),
                      const Text(
                        "Ajouter une tâche",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25.0),
                      ),
                      const SizedBox(height: 20.0),
                      GetTextFormField(
                        controller: _titleController,
                        icon: Icons.title,
                        hintName: 'titre*',
                        inputtype: TextInputType.text,
                      ),
                      const SizedBox(height: 10.0),
                      GetTextFormField(
                        controller: _descriptionController,
                        icon: Icons.description,
                        hintName: 'description *',
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _dateController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary:
                                          Color.fromARGB(255, 107, 109, 174),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDate != null &&
                                pickedDate != _selectedDate) {
                              setState(() {
                                _selectedDate = pickedDate;
                                _dateController.text = DateFormat('yyyy-MM-dd')
                                    .format(_selectedDate);
                              });
                            }
                          },
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Select Date',
                            hintText: 'Select Date',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a time';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _timeController,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: _selectedTime,
                            );
                            if (pickedTime != null &&
                                pickedTime != _selectedTime) {
                              setState(() {
                                _selectedTime = pickedTime;
                                // Format the time using 24-hour format
                                _timeController.text =
                                    _formatTimeOfDay(_selectedTime);
                              });
                            }
                          },
                          readOnly: true,
                          // Disable manual editing
                          decoration: const InputDecoration(
                            labelText: 'Heure de début *',
                            hintText: 'Heure de début *',
                            prefixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a time';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _timeendController,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: _selectedTime,
                            );
                            if (pickedTime != null &&
                                pickedTime != _selectedTime) {
                              setState(() {
                                _selectedTime = pickedTime;
                                // Format the time using 24-hour format
                                _timeendController.text =
                                    _formatTimeOfDay(_selectedTime);
                              });
                            }
                          },
                          readOnly: true, // Disable manual editing
                          decoration: const InputDecoration(
                            labelText: 'Heure de fin',
                            hintText: 'Heure de fin',
                            prefixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: alarm,
                              onChanged: (value) {
                                setState(() {
                                  alarm = value ??
                                      false; // Update the state variable
                                });
                              },
                            ),
                            const Text("Alarm"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: repetation,
                              onChanged: (value) {
                                setState(() {
                                  repetation = value ??
                                      false; // Update the state variable
                                });
                              },
                            ),
                            const Text("Repetation"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: done,
                              onChanged: (value) {
                                setState(() {
                                  done = value ??
                                      false; // Update the state variable
                                });
                              },
                            ),
                            const Text("Done"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 76, 77, 166),
                            ),
                            onPressed: () =>
                                selectOperation(operation, taskData),
                            child: const Text('soumettre'),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 76, 77, 166),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Calendar(
                                        selectedDay: DateFormat('yyyy-MM-dd')
                                            .parse(_dateIfCancel.text)),
                                  ),
                                  (Route<dynamic> route) => false);
                            },
                            child: const Text('Annoler'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
