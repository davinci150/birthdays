import 'dart:async';
import 'dart:math';

import 'package:birthdays/user_card_widet.dart';
import 'package:birthdays/user_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<UserModel> list = [];
  Iterable<Contact>? _contacts;

  @override
  void initState() {
    getContacts();

    super.initState();
  }

  Future<void> setContact() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();

    setState(() {
      _contacts = contacts;
    });
  }

  Future<void> getContacts() async {
    final PermissionStatus permissionStatus = await _getPermission();

    if (permissionStatus == PermissionStatus.granted) {
      setContact();
    } else {
      await Permission.contacts.request().then((value) {
        if (value == PermissionStatus.granted) {
          setContact();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF6100FF),
            child: const Icon(Icons.add, size: 32),
            onPressed: addContactDialog,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: bottomBar(),
        backgroundColor: const Color(0xFFF6ECF2),
        extendBody: true,
        appBar: appBar(),
        body: body());
  }

  Widget body2() {
    return ListView.builder(
      itemCount: _contacts?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final contact = _contacts?.elementAt(index);
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
          leading: (contact?.avatar != null &&
                  contact!.avatar != null &&
                  contact.avatar!.isNotEmpty)
              ? CircleAvatar(
                  backgroundImage: MemoryImage(contact.avatar!),
                )
              : CircleAvatar(
                  child: Text(contact?.initials() ?? ''),
                  backgroundColor: Theme.of(context).accentColor,
                ),
          title: Row(
            children: [
              Text(contact?.displayName ?? ''),
              Text(contact?.phones?.first.value ?? ''),
            ],
          ),
          //This can be further expanded to showing contacts detail
          // onPressed().
        );
      },
    );
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.restricted;
    } else {
      return permission;
    }
  }

  Widget bottomBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 70,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
                const Text('List')
              ],
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.calendar_today)),
                const Text('Calendar')
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Color(0xFF9F8EF6),
            ))
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Birthdays',
        style: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  final listImage = ['assets/images/human2.png', 'assets/images/human1.png'];
  final listColors = const [Color(0xFFF8DA89), Color(0xFFD6CAFE)];

  Widget body() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          // color: Color(0xFFFDF6F6),
          height: 49,
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: TextField(
            maxLines: 1,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintStyle:
                    const TextStyle(color: Color(0xFF8F8F8F), fontSize: 20),
                hintText: 'Search contact',
                prefixIcon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Color(0xFFD5C9F3),
                ),
                filled: true,
                fillColor: const Color(0xFFFDF6F6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                )),
          ),
        ),
        Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (ctx, i) {
                  final rnd = Random().nextInt(2);
                  return UserCard(
                    userModel: list[i],
                    imagePath: listImage[rnd],
                    avatarColor: listColors[rnd],
                  );
                },
                separatorBuilder: (ctx, i) {
                  return const SizedBox(height: 21);
                },
                itemCount: list.length)),
      ],
    );
  }

  void addContactDialog() {
    UserModel userModel = UserModel();

    showModalBottomSheet(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (context, state) {
        return SizedBox(
          height: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (name) {
                    userModel = userModel.copyWith(name: name);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setData().then((value) {
                          state(() {
                            userModel = userModel.copyWith(date: value);
                          });
                        });
                      },
                      icon: const Icon(Icons.calendar_today)),
                  Text(userModel.date.toString())
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    saveBirthday(userModel);
                    Navigator.of(context).pop();
                  },
                  child: const Text('SAVE'))
            ],
          ),
        );
      }),
    );
  }

  void saveBirthday(UserModel model) {
    list.add(model);
    setState(() {});
  }

  Future<DateTime?> setData() async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365)));
  }
}
