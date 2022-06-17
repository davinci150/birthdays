import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  User({required this.name, this.avatar, required this.id, required this.date});

  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  Uint8List? avatar;

  @HiveField(3)
  int? id;
}
