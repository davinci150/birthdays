import 'dart:typed_data';

import 'package:flutter/services.dart';

class ImageService {
  static Future<Uint8List> uint8listFromAsset(String asset) async {
    final ByteData bytes = await rootBundle.load(asset);
    final Uint8List list = bytes.buffer.asUint8List();
    return list;
  }
}
