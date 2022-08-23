import 'package:flutter/material.dart';

class CustomScrollPhysics extends BouncingScrollPhysics {
  const CustomScrollPhysics()
      : super(parent: const AlwaysScrollableScrollPhysics());
}
