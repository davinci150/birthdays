import 'package:flutter/material.dart';

import '../contacts_repository.dart';
import '../model/user_model.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key,
    //required this.id,
  }) : super(key: key);
  //final int id;

  @override
  State<UserProfilePage> createState() => _UserProfilPageState();
}

class _UserProfilPageState extends State<UserProfilePage> {
  late ContactsRepository repository;
  late UserModel user;
  @override
  void initState() {
    repository = ContactsRepository.instance;
    //user = repository.getById(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}