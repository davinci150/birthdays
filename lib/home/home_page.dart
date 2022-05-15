import 'dart:math';

import 'package:birthdays/add_contact/add_contact_page.dart';
import 'package:birthdays/contacts_repository.dart';
import 'package:birthdays/home/widgets/user_card_widet.dart';
import 'package:birthdays/model/user_model.dart';
import 'package:flutter/material.dart';

import '../service/notification_service.dart';
import 'widgets/user_card_widet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<UserModel> list = [];
  final listImage = ['assets/images/human2.png', 'assets/images/human1.png'];
  final listColors = const [Color(0xFFF8DA89), Color(0xFFD6CAFE)];
  NotificationService notificationService = NotificationService();
  late TextEditingController searchTextController;
  late ContactsRepository repository;
  String searchText = '';
  @override
  void initState() {
    searchTextController = TextEditingController();
    repository = ContactsRepository.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final listContact = searchText.isNotEmpty
    //     ? list.where((element) => element.name!.contains(searchText)).toList()
    //     : list;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF6100FF),
          child: const Icon(Icons.add, size: 32),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddContactPage()),
            );

            //addContactDialog();
          },
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      backgroundColor: const Color(0xFFF6ECF2),
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //notificationService.getActiveNotifications(context);
              },
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
      ),
      body: StreamBuilder<List<UserModel>>(
          stream: repository.getUsers(searchText),
          builder: (context, snapshot) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  // color: Color(0xFFFDF6F6),
                  height: 49,
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: TextField(
                    controller: searchTextController,
                    onChanged: (text) {
                      searchText = text;
                      setState(() {});
                    },
                    maxLines: 1,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        suffixIcon: searchText.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  searchTextController.clear();
                                  searchText = '';
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.cancel_outlined,
                                  color: Color(0xFFD5C9F3),
                                ),
                              )
                            : null,
                        contentPadding: EdgeInsets.zero,
                        hintStyle: const TextStyle(
                            color: Color(0xFF8F8F8F), fontSize: 20),
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
                        padding: const EdgeInsets.fromLTRB(30, 40, 30, 185),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (ctx, i) {
                          final rnd = Random().nextInt(2);
                          return UserCard(
                            avatarCallback: (details) {
                              //_showPopup(context);

                              showMenu(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(36.0))),
                                  context: context,
                                  position: RelativeRect.fromRect(
                                      Rect.fromCenter(
                                          center: details.globalPosition,
                                          width: 0,
                                          height: 0),
                                      Rect.zero),
                                  items: [
                                    PopupMenuItem<String>(
                                      onTap: null,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                repository.deleteContact(i);
                                              },
                                              icon: const Icon(Icons.delete)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.edit)),
                                        ],
                                      ),
                                    )
                                  ]);
                            },
                            userModel: snapshot.data![i],
                            imagePath: listImage[rnd],
                            avatarColor: listColors[rnd],
                          );
                        },
                        separatorBuilder: (ctx, i) {
                          return const SizedBox(height: 21);
                        },
                        itemCount: snapshot.data?.length ?? 0)),
              ],
            );
          }),
      bottomNavigationBar: BottomAppBar(
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
      ),
    );
  }

  void showPopup(Offset offset) {}
}
