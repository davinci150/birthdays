import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  User(
      {required this.name,
      this.avatar,
      required this.id,
      required this.date,
      required this.phone});

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String phone;

  @HiveField(4)
  Uint8List? avatar;
}
