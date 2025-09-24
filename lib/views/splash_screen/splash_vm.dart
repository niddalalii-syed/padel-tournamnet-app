import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';

class SplashVM extends BaseViewModel {
  initialize() async {
    // Simulate a delay for splash screen
    await Future.delayed(const Duration(seconds: 2));
    NavigationService().replaceWithLoginView();
  }
}
