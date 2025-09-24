import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';

class LoginVM extends BaseViewModel {
  NavigationService navigationService = NavigationService();

  checkUser() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((SharedPreferences preferences) {
      final isLoggedIn = preferences.getBool("isloggedIn") ?? false;
      if (isLoggedIn) {
        // If user is logged in, navigate to HomeView
        navigationService.replaceWithHomeView();
      } else {
        // If user is not logged in, navigate to LoginView
      }
    });
  }

  navigateToHome() {
    // Navigate to HomeView
    navigationService.replaceWithHomeView();
  }
}
