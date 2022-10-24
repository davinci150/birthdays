
import 'package:url_launcher/url_launcher.dart';

class PhoneUtils {
  Future<void> makingPhoneCallandSms({String? scheme, String? path}) async{
    final uri = Uri(scheme: scheme, path: path);
    if (await canLaunchUrl(uri)){
      await launchUrl(uri);
    } else {
      final Error error = ArgumentError('Could not launch');
      throw error;
    }
  }
}