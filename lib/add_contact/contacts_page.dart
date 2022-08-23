import 'dart:developer';

import 'package:birthdays/add_contact/add_contact_page.dart';
import 'package:birthdays/contacts_repository.dart';
import 'package:birthdays/model/user_model.dart';
import 'package:birthdays/presentation/colors.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../home/widgets/material_button_widget.dart';
import '../home/widgets/search_text_field.dart';
import '../utils/physics_list_view.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact>? _contacts;
  late ContactsRepository repository;
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

  Future<void> getContacts() async {
    final PermissionStatus permissionStatus = await _getPermission();

    if (permissionStatus == PermissionStatus.granted) {
      await setContact();
    } else {
      if (await Permission.contacts.request().isGranted) {
        await setContact();
      }
    }
  }

  @override
  void initState() {
    repository = ContactsRepository.instance;
    getContacts();
    super.initState();
  }

  Future<void> setContact() async {
    final List<Contact> contacts = await ContactsService.getContacts();

    setState(() {
      contacts.sort((a, b) => a.displayName!.compareTo(b.displayName!));
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 31),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButtonWidget(
                text: 'Create',
                onTap: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (context) => AddContacPage(
                              onSaveUser: (UserModel user) {
                                repository.addUser(user);
                              },
                            )),
                  );
                },
              )
            ],
          ),
        ),
        backgroundColor: AppColors.mortar,
        body: _contacts == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SearchTextFiled(),
                    const SizedBox(
                      height: 20,
                    ),
                    //  TextButton(
                    //    onPressed: () async {
                    //
                    //    },
                    //    child: Row(
                    //      mainAxisAlignment: MainAxisAlignment.center,
                    //      children: const [
                    //        Icon(Icons.add),
                    //        SizedBox(width: 6),
                    //        Text('Create contact')
                    //      ],
                    //    ),
                    //  ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4, left: 10),
                        child: Scrollbar(
                          thickness: 6,
                          radius: const Radius.circular(100),
                          child: ListView.builder(
                            physics: const CustomScrollPhysics(),
                            itemCount: _contacts?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final contact = _contacts?.elementAt(index);
                              return userCard(contact);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  Widget userCard(Contact? contact) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (contact?.avatar != null &&
                  contact!.avatar != null &&
                  contact.avatar!.isNotEmpty)
                CircleAvatar(
                  backgroundImage: MemoryImage(contact.avatar!),
                )
              else
                CircleAvatar(
                  child: Text(contact?.initials() ?? ''),
                ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    contact?.displayName ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  if ((contact?.phones ?? []).isNotEmpty)
                    Text(
                      contact?.phones?.first.value ?? '',
                      style: const TextStyle(color: Colors.white),
                    )
                ],
              ),
            ],
          ),
          TextButton(
              onPressed: () {
              
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => AddContacPage(
                            userModel: UserModel(
                                avatar: contact?.avatar,
                                name: contact?.displayName,
                                date: contact?.birthday),
                            onSaveUser: (UserModel user) {
                              repository.addUser(user);
                            },
                          )),
                );
                //await showModalBottomSheet(
                //    constraints: const BoxConstraints(minHeight: 500),
                //    shape: const RoundedRectangleBorder(
                //        borderRadius:
                //            BorderRadius.vertical(top: Radius.circular(29))),
                //    backgroundColor: Colors.white,
                //    context: context,
                //    builder: (ctx) => AddContacPage(
                //        userModel: UserModel(
                //            avatar: contact?.avatar,
                //            id: null,
                //            name: contact?.displayName,
                //            date: contact?.birthday),
                //        onSaveUser: (model) {
                //          repository.addUser(model);
                //        }));

                // Navigator.pop(context);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ) // const Text('Add'),
              )
        ],
      ),
    );
  }
}
