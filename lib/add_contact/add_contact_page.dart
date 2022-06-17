import 'package:birthdays/add_contact/add_contact_widget.dart';
import 'package:birthdays/contacts_repository.dart';
import 'package:birthdays/model/user_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
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
      setContact();
    } else {
      if (await Permission.contacts.request().isGranted) {
        setContact();
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
    final Iterable<Contact> contacts = await ContactsService.getContacts();

    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new contact'),
        ),
        body: _contacts == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      await showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(29))),
                          //constraints: const BoxConstraints(minHeight: 500),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (ctx) =>
                              AddContacWidget(onSaveUser: (model) {
                                repository.addUser(model);
                              }));

                      // Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add),
                        SizedBox(width: 6),
                        Text('Create contact')
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _contacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final contact = _contacts?.elementAt(index);
                        return userCard(contact);
                      },
                    ),
                  ),
                ],
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
              (contact?.avatar != null &&
                      contact!.avatar != null &&
                      contact.avatar!.isNotEmpty)
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(contact.avatar!),
                    )
                  : CircleAvatar(
                      child: Text(contact?.initials() ?? ''),
                    ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(contact?.displayName ?? ''),
                  if ((contact?.phones ?? []).isNotEmpty)
                    Text(contact?.phones?.first.value ?? ''),
                ],
              ),
            ],
          ),
          TextButton(
              onPressed: () async {
                await showModalBottomSheet(
                    constraints: const BoxConstraints(minHeight: 500),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(29))),
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (ctx) => AddContacWidget(
                        userModel: UserModel(
                            avatar: contact?.avatar,
                            id: null,
                            name: contact?.displayName,
                            date: contact?.birthday),
                        onSaveUser: (model) {
                          repository.addUser(model);
                        }));

                // Navigator.pop(context);
              },
              child: const Text('Add'))
        ],
      ),
    );
  }
}
