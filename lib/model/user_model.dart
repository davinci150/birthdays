import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    this.name,
    this.id,
    this.avatar,
    this.date,
    this.phone,
  });

  final String? name;
  final Uint8List? avatar;
  final DateTime? date;
  final int? id;
  final String? phone;

  UserModel copyWith({
    int? id,
    String? name,
    Uint8List? avatar,
    DateTime? date,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      date: date ?? this.date,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [
        name,
        id,
        avatar,
        date,
        phone,
      ];

  @override
  String toString() {
    return 'User(name: $name, id: $id, phone: $phone)';
  }
}

extension UserModelExt on UserModel {
  String initials() {
    if (name == null) return '';
    final splitName = name!.split(' ');
    if (splitName.length > 1 && (splitName[1]).isNotEmpty) {
      return splitName[0][0] + splitName[1][0];
    } else if (splitName.isNotEmpty && (splitName[0]).isNotEmpty) {
      return splitName[0][0];
    } else {
      return '';
    }
  }
}
