import 'package:flutter/material.dart';

class Task {
  int? id;
  String title;
  String discription;
  DateTime creationDate;
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
    required this.creationDate,
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
      creationDate: DateTime.parse(json['creation_date']),
      doDate: DateTime.parse(json['do_date']).toLocal(),
      startTime: TimeOfDay.fromDateTime(DateTime.parse(json['start_time'])),
      endTime: json['end_time'] != null
          ? TimeOfDay.fromDateTime(DateTime.parse(json['end_time']))
          : null,
      repetation: json['repetation'],
      alarm: json['alarm'],
      done: json['done'],
      userId: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'discription': discription,
      'creation_date': creationDate.toIso8601String(),
      'do_date': doDate.toIso8601String(),
      'start_time': startTime.toString(),
      'end_time': endTime?.toString(),
      'repetition': repetation,
      'alarm': alarm,
      'done': done,
      'user': userId,
    };
  }
}

