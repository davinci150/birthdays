import 'package:birthdays/entity/user.dart';
import 'package:birthdays/model/user_model.dart';
import 'package:birthdays/service/notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'service/box_manager.dart';

class ContactsRepository {
  ContactsRepository._() {
    _setup();
  }
  static final ContactsRepository instance = ContactsRepository._();
  BehaviorSubject<List<UserModel>> listUsers = BehaviorSubject.seeded([]);

  Stream<List<UserModel>> getUsers(String search) {
    if (search.isNotEmpty) {
      final list = listUsers.stream.value;
      return Stream.value(
          list.where((element) => element.name!.contains(search)).toList());
    }
    return listUsers.stream;
  }

  NotificationService notificationService = NotificationService();

  void addUser(UserModel model) {
    final list = listUsers.value;
    list.add(model);
    list.sort((a, b) => a.date!.compareTo(b.date!));
    listUsers.sink.add(list);
    saveGroup(User(name: model.name!, date: model.date!));
    final now = DateTime.now();
    notificationService.scheduleNotification(
        DateTime(now.year, model.date!.month, model.date!.day, 08, 30, 00),
        //DateTime.now().add(Duration(seconds: 4)),
        'День рождения у ${model.name}');
  }

  List<User> listUserModel = [];

  late Future<Box<User>> _box;
  late ValueListenable<Object> _listenableBox;

  Future<void> _setup() async {
    _box = BoxManager.instance.openGroupBox();

    await _readGroupsFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox.addListener(_readGroupsFromHive);
  }

  Future<void> _readGroupsFromHive() async {
    listUserModel = (await _box).values.toList();
    List<UserModel> list = [];
    for (var user in listUserModel) {
      final us = UserModel(name: user.name, date: user.date);
      list.add(us);
    }
    listUsers.sink.add(list);
  }

  Future<void> deleteContact(int groupIndex) async {
    final box = await _box;
    final groupKey = (await _box).keyAt(groupIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
    await Hive.deleteBoxFromDisk(taskBoxName);

    await box.deleteAt(groupIndex);
  }

  Future<void> saveGroup(User user) async {
    final box = await BoxManager.instance.openGroupBox();
    final group = User(name: user.name, date: user.date);
    await box.add(group);
    await BoxManager.instance.closeBox(box);
  }
}
