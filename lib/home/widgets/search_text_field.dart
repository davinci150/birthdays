import 'package:flutter/material.dart';

class SearchTextFiled extends StatefulWidget {
  const SearchTextFiled({
    Key? key,
    this.onChanged,
    this.controller,
    this.onTapRestoreList,
  }) : super(key: key);

  final void Function(String)? onChanged;
  final void Function()? onTapRestoreList;
  final TextEditingController? controller;

  @override
  State<SearchTextFiled> createState() => _SearchTextFiledState();
}

class _SearchTextFiledState extends State<SearchTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          suffixIcon: widget.controller?.text.isNotEmpty ?? false
              ? GestureDetector(
                  onTap: widget.onTapRestoreList,
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Color(0xFFD5C9F3),
                  ),
                )
              : null,
          contentPadding: EdgeInsets.zero,
          hintStyle: const TextStyle(color: Color(0xFF8F8F8F), fontSize: 18),
          hintText: 'Search contact',
          prefixIcon: const Icon(
            Icons.search,
            size: 22,
            color: Colors.black,
          ),
          filled: true,
          fillColor: const Color(0xFFFDF6F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          )),
    );
  }
}
