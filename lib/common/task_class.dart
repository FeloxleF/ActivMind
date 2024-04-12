import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


extension TimeOfDayExtension on TimeOfDay {
  String formatHHmm() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

class Task {
  int? id;
  String title;
  String discription;
  DateTime doDate;
  TimeOfDay startTime;
  TimeOfDay? endTime;
  bool repetation;
  bool alarm;
  bool done;
  int userId;


Task({
    this.id,
    required this.title,
    required this.discription,
    required this.doDate,
    required this.startTime,
    this.endTime,
    this.repetation = false,
    this.alarm = false,
    this.done = false,
    required this.userId,
  });



  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      discription: json['discription'],
      doDate: DateTime.parse(json['do_date']).toLocal(),
      startTime: TimeOfDay.fromDateTime(
          DateFormat("HH:mm:ss").parse(json['start_time'])
      ),
      endTime: TimeOfDay.fromDateTime(
          DateFormat("HH:mm:ss").parse(json['end_time'])
      ),
      repetation: json['repetation'],
      alarm: json['alarm'],
      done: json['done'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'discription': discription,
      'do_date': doDate.toIso8601String(),
      'start_time': startTime.formatHHmm(),
      'end_time': endTime?.formatHHmm(),
      'repetition': repetation,
      'alarm': alarm,
      'done': done,
      'user': userId,
    };
  }
}

