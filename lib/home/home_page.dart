import 'dart:developer';

import 'package:flutter/material.dart';

import '../contacts_repository.dart';
import '../model/user_model.dart';
import '../presentation/colors.dart';
import 'settings_page.dart';
import 'widgets/bottom_bar_widget.dart';
import 'widgets/calendar_view_widget.dart';
import 'widgets/list_view_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController controller;

  late TextEditingController searchTextController;
  late ContactsRepository repository;

  String searchText = '';
  ValueNotifier<int> selectedBottomIndex = ValueNotifier(0);

  @override
  void initState() {
    controller = PageController();
    searchTextController = TextEditingController();
    repository = ContactsRepository.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mortar,
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push<void>(
                      MaterialPageRoute(builder: (context) => const SettingsPage()));
                  //final time = DateTime.now().add(const Duration(seconds: 2));
                  //final time2 = DateTime.now().add(const Duration(seconds: 4));
                  //notificationService.scheduleNotification(time, 'Test');
                  //notificationService.scheduleNotification(time2, 'Test2');
                  //notificationService.cancelNotification();
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Birthdays',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder<List<UserModel>>(
            stream: repository.getUsers(searchText),
            builder: (context, snapshot) {
              log((snapshot.data?.map((e) => e.toString()) ?? '').toString());
              return PageView(
                onPageChanged: (value) {
                  selectedBottomIndex.value = value;
                },
                controller: controller,
                children: [
                   ListViewWidget(
                    // onClickDelete: (index) {
                    //   repository.deleteContact(index);
                    // },
                   listUser: snapshot.data ?? [],
                  ),
                  CalendarViewWidget(
                    listUser: snapshot.data ?? [],
                  )
                ],
              );
            }),
        bottomNavigationBar: ValueListenableBuilder<int>(
            valueListenable: selectedBottomIndex,
            builder: (ctx, value, _) {
              return BottomBarWidget(
                selectedIndex: value,
                onChange: (index) {
                  selectedBottomIndex.value = index;
                  controller.animateTo(
                      index * MediaQuery.of(context).size.width,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
              );
            }));
  }
}
