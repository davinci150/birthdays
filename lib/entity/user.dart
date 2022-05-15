import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  User({required this.name, required this.date});

  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime date;
}
