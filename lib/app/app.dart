import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/service/upload_images.dart';
import 'package:tournament_manager/service/userService.dart';
import 'package:tournament_manager/views/add_existing_tournament/add_existing_tournament_view.dart';
import 'package:tournament_manager/views/all_participants/add_participant_view/add_participant_view.dart';
import 'package:tournament_manager/views/all_participants/edit_particpant_view/edit_participant_view.dart';
import 'package:tournament_manager/views/all_participants/participants/all_participants_view.dart';
import 'package:tournament_manager/views/create_matches/manually/create_matches_manually_view.dart';
import 'package:tournament_manager/views/delete_account_view/delete_account_view.dart';
import 'package:tournament_manager/views/modify_matches/manually/modify_match_manually_view.dart';
import 'package:tournament_manager/views/modify_matches/randomly/modify_match_randomly_view.dart';
import 'package:tournament_manager/views/participant/add_participant_view/add_participant_view.dart';
import 'package:tournament_manager/views/participant/edit_particpant_view/edit_participant_view.dart';
import 'package:tournament_manager/views/add_tournament_view/add_tournament_view.dart';
import 'package:tournament_manager/views/create_matches/randomly/create_matches_view.dart';
import 'package:tournament_manager/views/home_screen/home_view.dart';
import 'package:tournament_manager/views/login_screen/login_view.dart';
import 'package:tournament_manager/views/participant_view/participant_view.dart';
import 'package:tournament_manager/views/scoreboard_view/scoreboard_view.dart';
import 'package:tournament_manager/views/scoring_match/scoring_match_view.dart';
import 'package:tournament_manager/views/setting_view/setting_view.dart';
import 'package:tournament_manager/views/splash_screen/splash_view.dart';
import 'package:tournament_manager/views/standing_view/standing_view.dart';
import 'package:tournament_manager/views/torunament_view/tournament_view.dart';
import 'package:tournament_manager/views/tournament_details/tournament_details_view.dart';
import 'package:tournament_manager/views/tournament_options.dart/tournament_option_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: NewTournamentView),
    MaterialRoute(page: TournamentOptionView),
    MaterialRoute(page: TournamentDetailsView),
    MaterialRoute(page: ParticipantView),
    MaterialRoute(page: AddParticipantView),
    MaterialRoute(page: EditParticipantView),
    MaterialRoute(page: CreateMatchesView),
    MaterialRoute(page: CreateMatchesManuallyView),
    MaterialRoute(page: ScoreboardView),
    MaterialRoute(page: ScoringMatchView),
    MaterialRoute(page: StandingView),
    MaterialRoute(page: ExistingTournamentView),
    MaterialRoute(page: ModifyMatchesView),
    MaterialRoute(page: ModifyMatchesManuallyView),
    MaterialRoute(page: TournamentView),
    MaterialRoute(page: AllParticipantView),
    MaterialRoute(page: AddtoAllParticipantView),
    MaterialRoute(page: EditAllParticipantView),
    MaterialRoute(page: SettingView),
    MaterialRoute(page: DeleteUserView),
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    Singleton(classType: BottomSheetService),
    Singleton(classType: DialogService),
    Singleton(classType: SnackbarService),
    LazySingleton(classType: Userservice),
    LazySingleton(classType: UploadImageApi),
  ],
)
class App {}
