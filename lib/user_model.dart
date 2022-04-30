class UserModel {
  final String? name;
   final DateTime? date;
   

  UserModel({this.name, this.date});

  UserModel copyWith({
    String? name,
    DateTime? date,
  }) {
    return UserModel(
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }
}
