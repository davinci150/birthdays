import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImageUtils{
  Future<Uint8List?> setImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final uint8 = await image?.readAsBytes();
    return uint8;
  }
}