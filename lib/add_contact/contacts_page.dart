
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../contacts_repository.dart';
import '../home/widgets/material_button_widget.dart';
import '../home/widgets/search_text_field.dart';
import '../model/user_model.dart';
import '../presentation/colors.dart';
import '../utils/physics_list_view.dart';
import 'add_contact_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact>? _contacts;
  List<Contact> listContact = [];
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
  final  controller = TextEditingController();
  //late List<ContactsRepository> users;

  void searchUser(String query) {
  if (query.isNotEmpty){
    listContact=listContact.where((element) => element.displayName!.toLowerCase().contains(query.toLowerCase())
    || element.phones!.first.value!.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
  else {
    listContact = _contacts!.toList();
  }
  setState((){});
  }

  @override
  void initState() {
    repository = ContactsRepository.instance;
    getContacts();
    //users = repository.listUsers as List<ContactsRepository>;
    super.initState();
  }

  Future<void> setContact() async {
    final List<Contact> contacts = await ContactsService.getContacts();

    setState(() {
      contacts.sort((a, b) => a.displayName!.compareTo(b.displayName!));
      _contacts = contacts;
      listContact = _contacts!.toList();
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
                    SearchTextFiled(controller: controller,
                        onChanged:searchUser),
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
                            itemCount: listContact.length,
                            itemBuilder: (BuildContext context, int index) {
                              final contact = listContact.elementAt(index);
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

