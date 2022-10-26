
import 'package:url_launcher/url_launcher.dart';

class UriLauncher {

  Future<void> call(String phone) async{
    final Uri? url = Uri.tryParse('tel://$phone');
    if (phone.isNotEmpty){
      await launchUrl(url!);
    } else {
      final Error error = ArgumentError('Can not found $phone');
      throw error;
    }
  }

  Future<void>sms(String phone) async{
    final Uri? url = Uri.tryParse('sms://$phone');
    if (phone.isNotEmpty){
      await launchUrl(url!);
    }else {
      final Error error = ArgumentError('Can not found $phone');
      throw error;
    }
  }
}