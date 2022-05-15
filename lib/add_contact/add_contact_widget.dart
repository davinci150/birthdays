import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/user_model.dart';

class AddContacWidget extends StatefulWidget {
  const AddContacWidget(
      {Key? key, required this.onSaveUser,})
      : super(key: key);
  final void Function(UserModel) onSaveUser;


  @override
  State<AddContacWidget> createState() => _AddContacWidgetState();
}

class _AddContacWidgetState extends State<AddContacWidget> {
  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
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
          InkWell(
            onTap: () {
              setData(context).then((value) {
                userModel = userModel.copyWith(date: value);
              
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(
                  width: 12,
                ),
                if (userModel.date != null)
                  Text(
                    DateFormat('d/MMMM/yyyy').format(userModel.date!),
                    style: const TextStyle(fontSize: 20),
                  )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                widget.onSaveUser(userModel);
                Navigator.of(context).pop();
              },
              child: const Text('SAVE'))
        ],
      ),
    );
  }

  Future<DateTime?> setData(BuildContext context) async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365)));
  }
}
