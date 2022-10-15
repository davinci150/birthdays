import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'entity/user.dart';
import 'model/user_model.dart';
import 'service/box_manager.dart';
import 'service/notification_service.dart';

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

  int _getUid() {
    int uid = 0;
    listUsers.value.forEach((element) {
      uid = (element.id ?? 0) > uid ? element.id! : uid;
    });

    return uid + 1;
  }

  UserModel getById(int id) {
    return listUsers.value.firstWhere((user) => user.id == id);
  }

  void addUser(UserModel model) {
    final userId = _getUid();
    final UserModel userModel = model.copyWith(id: userId);
    final list = listUsers.value
      ..add(userModel)
      ..sort((a, b) => a.date!.compareTo(b.date!));
    listUsers.sink.add(list);
    _saveUser(User(
        name: userModel.name!,
        avatar: userModel.avatar,
        id: userModel.id!,
        date: userModel.date!,
        phone: userModel.phone!));

    notificationService.scheduleNotification(
        userId, userModel.date!, 'День рождения у ${userModel.name}');
  }

  List<User> listUserModel = [];

  late Future<Box<User>> _box;
  late ValueListenable<Object> _listenableBox;

  Future<void> _setup() async {
    _box = BoxManager.instance.openUserBox();

    await _readGroupsFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox.addListener(_readGroupsFromHive);
  }

  Future<void> _readGroupsFromHive() async {
    listUserModel = (await _box).values.toList();
    final List<UserModel> list = [];
    for (final user in listUserModel) {
      final us = UserModel(
          name: user.name,
          date: user.date,
          avatar: user.avatar,
          id: user.id,
          phone: user.phone);
      list.add(us);
    }
    listUsers.sink.add(list);
  }

  Future<void> deleteContact(int id) async {
    final box = await _box;
    final users = (await _box).values.toList();
    final user = (await _box).values.firstWhere((element) => element.id == id);
    final groupKey = users.indexOf(user);
    log('GROUP KEY ${groupKey} ${id}');
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
    await Hive.deleteBoxFromDisk(taskBoxName);

    await box.deleteAt(groupKey);
    await notificationService.cancelNotification(id);
  }

  Future<void> editUser(UserModel user) async {
    await deleteContact(user.id!);
    await _saveUser(User(
        name: user.name!,
        id: user.id!,
        date: user.date!,
        avatar: user.avatar,
        phone: user.phone!));
  }

  Future<void> _saveUser(User user) async {
    final box = await BoxManager.instance.openUserBox();
    final group = User(
        name: user.name,
        avatar: user.avatar,
        id: user.id,
        date: user.date,
        phone: user.phone);
    await box.add(group);
    await BoxManager.instance.closeBox(box);
  }

  void close() {
    listUsers.close();
  }
}
