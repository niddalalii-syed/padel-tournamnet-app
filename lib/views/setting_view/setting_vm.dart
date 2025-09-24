import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingVM extends BaseViewModel {
  Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode
          .platformDefault, // Opens in default browser or in-app if available
      // mode: LaunchMode.inAppWebView, // Force opening in an in-app WebView
      // mode: LaunchMode.externalApplication, // Force opening in an external browser app
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
