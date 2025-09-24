// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i25;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i26;
import 'package:tournament_manager/views/add_existing_tournament/add_existing_tournament_view.dart'
    as _i16;
import 'package:tournament_manager/views/add_tournament_view/add_tournament_view.dart'
    as _i5;
import 'package:tournament_manager/views/all_participants/add_participant_view/add_participant_view.dart'
    as _i21;
import 'package:tournament_manager/views/all_participants/edit_particpant_view/edit_participant_view.dart'
    as _i22;
import 'package:tournament_manager/views/all_participants/participants/all_participants_view.dart'
    as _i20;
import 'package:tournament_manager/views/create_matches/manually/create_matches_manually_view.dart'
    as _i12;
import 'package:tournament_manager/views/create_matches/randomly/create_matches_view.dart'
    as _i11;
import 'package:tournament_manager/views/delete_account_view/delete_account_view.dart'
    as _i24;
import 'package:tournament_manager/views/home_screen/home_view.dart' as _i4;
import 'package:tournament_manager/views/login_screen/login_view.dart' as _i3;
import 'package:tournament_manager/views/modify_matches/manually/modify_match_manually_view.dart'
    as _i18;
import 'package:tournament_manager/views/modify_matches/randomly/modify_match_randomly_view.dart'
    as _i17;
import 'package:tournament_manager/views/participant/add_participant_view/add_participant_view.dart'
    as _i9;
import 'package:tournament_manager/views/participant/edit_particpant_view/edit_participant_view.dart'
    as _i10;
import 'package:tournament_manager/views/participant_view/participant_view.dart'
    as _i8;
import 'package:tournament_manager/views/scoreboard_view/scoreboard_view.dart'
    as _i13;
import 'package:tournament_manager/views/scoring_match/scoring_match_view.dart'
    as _i14;
import 'package:tournament_manager/views/setting_view/setting_view.dart'
    as _i23;
import 'package:tournament_manager/views/splash_screen/splash_view.dart' as _i2;
import 'package:tournament_manager/views/standing_view/standing_view.dart'
    as _i15;
import 'package:tournament_manager/views/torunament_view/tournament_view.dart'
    as _i19;
import 'package:tournament_manager/views/tournament_details/tournament_details_view.dart'
    as _i7;
import 'package:tournament_manager/views/tournament_options.dart/tournament_option_view.dart'
    as _i6;

class Routes {
  static const splashView = '/';

  static const loginView = '/login-view';

  static const homeView = '/home-view';

  static const newTournamentView = '/new-tournament-view';

  static const tournamentOptionView = '/tournament-option-view';

  static const tournamentDetailsView = '/tournament-details-view';

  static const participantView = '/participant-view';

  static const addParticipantView = '/add-participant-view';

  static const editParticipantView = '/edit-participant-view';

  static const createMatchesView = '/create-matches-view';

  static const createMatchesManuallyView = '/create-matches-manually-view';

  static const scoreboardView = '/scoreboard-view';

  static const scoringMatchView = '/scoring-match-view';

  static const standingView = '/standing-view';

  static const existingTournamentView = '/existing-tournament-view';

  static const modifyMatchesView = '/modify-matches-view';

  static const modifyMatchesManuallyView = '/modify-matches-manually-view';

  static const tournamentView = '/tournament-view';

  static const allParticipantView = '/all-participant-view';

  static const addtoAllParticipantView = '/addto-all-participant-view';

  static const editAllParticipantView = '/edit-all-participant-view';

  static const settingView = '/setting-view';

  static const deleteUserView = '/delete-user-view';

  static const all = <String>{
    splashView,
    loginView,
    homeView,
    newTournamentView,
    tournamentOptionView,
    tournamentDetailsView,
    participantView,
    addParticipantView,
    editParticipantView,
    createMatchesView,
    createMatchesManuallyView,
    scoreboardView,
    scoringMatchView,
    standingView,
    existingTournamentView,
    modifyMatchesView,
    modifyMatchesManuallyView,
    tournamentView,
    allParticipantView,
    addtoAllParticipantView,
    editAllParticipantView,
    settingView,
    deleteUserView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i4.HomeView,
    ),
    _i1.RouteDef(
      Routes.newTournamentView,
      page: _i5.NewTournamentView,
    ),
    _i1.RouteDef(
      Routes.tournamentOptionView,
      page: _i6.TournamentOptionView,
    ),
    _i1.RouteDef(
      Routes.tournamentDetailsView,
      page: _i7.TournamentDetailsView,
    ),
    _i1.RouteDef(
      Routes.participantView,
      page: _i8.ParticipantView,
    ),
    _i1.RouteDef(
      Routes.addParticipantView,
      page: _i9.AddParticipantView,
    ),
    _i1.RouteDef(
      Routes.editParticipantView,
      page: _i10.EditParticipantView,
    ),
    _i1.RouteDef(
      Routes.createMatchesView,
      page: _i11.CreateMatchesView,
    ),
    _i1.RouteDef(
      Routes.createMatchesManuallyView,
      page: _i12.CreateMatchesManuallyView,
    ),
    _i1.RouteDef(
      Routes.scoreboardView,
      page: _i13.ScoreboardView,
    ),
    _i1.RouteDef(
      Routes.scoringMatchView,
      page: _i14.ScoringMatchView,
    ),
    _i1.RouteDef(
      Routes.standingView,
      page: _i15.StandingView,
    ),
    _i1.RouteDef(
      Routes.existingTournamentView,
      page: _i16.ExistingTournamentView,
    ),
    _i1.RouteDef(
      Routes.modifyMatchesView,
      page: _i17.ModifyMatchesView,
    ),
    _i1.RouteDef(
      Routes.modifyMatchesManuallyView,
      page: _i18.ModifyMatchesManuallyView,
    ),
    _i1.RouteDef(
      Routes.tournamentView,
      page: _i19.TournamentView,
    ),
    _i1.RouteDef(
      Routes.allParticipantView,
      page: _i20.AllParticipantView,
    ),
    _i1.RouteDef(
      Routes.addtoAllParticipantView,
      page: _i21.AddtoAllParticipantView,
    ),
    _i1.RouteDef(
      Routes.editAllParticipantView,
      page: _i22.EditAllParticipantView,
    ),
    _i1.RouteDef(
      Routes.settingView,
      page: _i23.SettingView,
    ),
    _i1.RouteDef(
      Routes.deleteUserView,
      page: _i24.DeleteUserView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
      );
    },
    _i4.HomeView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.HomeView(),
        settings: data,
      );
    },
    _i5.NewTournamentView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.NewTournamentView(),
        settings: data,
      );
    },
    _i6.TournamentOptionView: (data) {
      final args = data.getArgs<TournamentOptionViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.TournamentOptionView(
            key: args.key,
            tournamentName: args.tournamentName,
            originalTitle: args.originalTitle,
            index: args.index,
            tournamentData: args.tournamentData),
        settings: data,
      );
    },
    _i7.TournamentDetailsView: (data) {
      final args = data.getArgs<TournamentDetailsViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.TournamentDetailsView(
            key: args.key,
            tournamentName: args.tournamentName,
            index: args.index),
        settings: data,
      );
    },
    _i8.ParticipantView: (data) {
      final args = data.getArgs<ParticipantViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ParticipantView(
            key: args.key,
            originalTitle: args.originalTitle,
            index: args.index),
        settings: data,
      );
    },
    _i9.AddParticipantView: (data) {
      final args = data.getArgs<AddParticipantViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.AddParticipantView(
            key: args.key,
            originalTitle: args.originalTitle,
            index: args.index),
        settings: data,
      );
    },
    _i10.EditParticipantView: (data) {
      final args = data.getArgs<EditParticipantViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.EditParticipantView(
            key: args.key,
            tournamentName: args.tournamentName,
            participantName: args.participantName),
        settings: data,
      );
    },
    _i11.CreateMatchesView: (data) {
      final args = data.getArgs<CreateMatchesViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.CreateMatchesView(
            key: args.key,
            originalTitle: args.originalTitle,
            index: args.index,
            tournamentName: args.tournamentName),
        settings: data,
      );
    },
    _i12.CreateMatchesManuallyView: (data) {
      final args =
          data.getArgs<CreateMatchesManuallyViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.CreateMatchesManuallyView(
            key: args.key,
            players: args.players,
            originalTitle: args.originalTitle,
            tournamentName: args.tournamentName,
            index: args.index),
        settings: data,
      );
    },
    _i13.ScoreboardView: (data) {
      final args = data.getArgs<ScoreboardViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.ScoreboardView(
            key: args.key,
            tournamentName: args.tournamentName,
            originalTitle: args.originalTitle,
            index: args.index,
            tournamentData: args.tournamentData),
        settings: data,
      );
    },
    _i14.ScoringMatchView: (data) {
      final args = data.getArgs<ScoringMatchViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.ScoringMatchView(
            key: args.key,
            player1: args.player1,
            player2: args.player2,
            matchday: args.matchday,
            originalTitle: args.originalTitle,
            matchIndex: args.matchIndex,
            tournamentName: args.tournamentName,
            player1Score: args.player1Score,
            player2Score: args.player2Score,
            date: args.date,
            time: args.time),
        settings: data,
      );
    },
    _i15.StandingView: (data) {
      final args = data.getArgs<StandingViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.StandingView(
            key: args.key, tournamentTitle: args.tournamentTitle),
        settings: data,
      );
    },
    _i16.ExistingTournamentView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.ExistingTournamentView(),
        settings: data,
      );
    },
    _i17.ModifyMatchesView: (data) {
      final args = data.getArgs<ModifyMatchesViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.ModifyMatchesView(
            key: args.key,
            originalTitle: args.originalTitle,
            index: args.index,
            tournamentName: args.tournamentName),
        settings: data,
      );
    },
    _i18.ModifyMatchesManuallyView: (data) {
      final args =
          data.getArgs<ModifyMatchesManuallyViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.ModifyMatchesManuallyView(
            key: args.key,
            originalTitle: args.originalTitle,
            allPlayers: args.allPlayers),
        settings: data,
      );
    },
    _i19.TournamentView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.TournamentView(),
        settings: data,
      );
    },
    _i20.AllParticipantView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.AllParticipantView(),
        settings: data,
      );
    },
    _i21.AddtoAllParticipantView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.AddtoAllParticipantView(),
        settings: data,
      );
    },
    _i22.EditAllParticipantView: (data) {
      final args = data.getArgs<EditAllParticipantViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.EditAllParticipantView(
            key: args.key, participantName: args.participantName),
        settings: data,
      );
    },
    _i23.SettingView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.SettingView(),
        settings: data,
      );
    },
    _i24.DeleteUserView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.DeleteUserView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TournamentOptionViewArguments {
  const TournamentOptionViewArguments({
    this.key,
    required this.tournamentName,
    required this.originalTitle,
    required this.index,
    this.tournamentData,
  });

  final _i25.Key? key;

  final String tournamentName;

  final String originalTitle;

  final int index;

  final dynamic tournamentData;

  @override
  String toString() {
    return '{"key": "$key", "tournamentName": "$tournamentName", "originalTitle": "$originalTitle", "index": "$index", "tournamentData": "$tournamentData"}';
  }

  @override
  bool operator ==(covariant TournamentOptionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.tournamentName == tournamentName &&
        other.originalTitle == originalTitle &&
        other.index == index &&
        other.tournamentData == tournamentData;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        tournamentName.hashCode ^
        originalTitle.hashCode ^
        index.hashCode ^
        tournamentData.hashCode;
  }
}

class TournamentDetailsViewArguments {
  const TournamentDetailsViewArguments({
    this.key,
    required this.tournamentName,
    required this.index,
  });

  final _i25.Key? key;

  final String tournamentName;

  final int index;

  @override
  String toString() {
    return '{"key": "$key", "tournamentName": "$tournamentName", "index": "$index"}';
  }

  @override
  bool operator ==(covariant TournamentDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.tournamentName == tournamentName &&
        other.index == index;
  }

  @override
  int get hashCode {
    return key.hashCode ^ tournamentName.hashCode ^ index.hashCode;
  }
}

class ParticipantViewArguments {
  const ParticipantViewArguments({
    this.key,
    required this.originalTitle,
    required this.index,
  });

  final _i25.Key? key;

  final String originalTitle;

  final int index;

  @override
  String toString() {
    return '{"key": "$key", "originalTitle": "$originalTitle", "index": "$index"}';
  }

  @override
  bool operator ==(covariant ParticipantViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.originalTitle == originalTitle &&
        other.index == index;
  }

  @override
  int get hashCode {
    return key.hashCode ^ originalTitle.hashCode ^ index.hashCode;
  }
}

class AddParticipantViewArguments {
  const AddParticipantViewArguments({
    this.key,
    required this.originalTitle,
    required this.index,
  });

  final _i25.Key? key;

  final String originalTitle;

  final int index;

  @override
  String toString() {
    return '{"key": "$key", "originalTitle": "$originalTitle", "index": "$index"}';
  }

  @override
  bool operator ==(covariant AddParticipantViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.originalTitle == originalTitle &&
        other.index == index;
  }

  @override
  int get hashCode {
    return key.hashCode ^ originalTitle.hashCode ^ index.hashCode;
  }
}

class EditParticipantViewArguments {
  const EditParticipantViewArguments({
    this.key,
    required this.tournamentName,
    required this.participantName,
  });

  final _i25.Key? key;

  final String tournamentName;

  final String participantName;

  @override
  String toString() {
    return '{"key": "$key", "tournamentName": "$tournamentName", "participantName": "$participantName"}';
  }

  @override
  bool operator ==(covariant EditParticipantViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.tournamentName == tournamentName &&
        other.participantName == participantName;
  }

  @override
  int get hashCode {
    return key.hashCode ^ tournamentName.hashCode ^ participantName.hashCode;
  }
}

class CreateMatchesViewArguments {
  const CreateMatchesViewArguments({
    this.key,
    required this.originalTitle,
    required this.index,
    required this.tournamentName,
  });

  final _i25.Key? key;

  final String originalTitle;

  final int index;

  final String tournamentName;

  @override
  String toString() {
    return '{"key": "$key", "originalTitle": "$originalTitle", "index": "$index", "tournamentName": "$tournamentName"}';
  }

  @override
  bool operator ==(covariant CreateMatchesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.originalTitle == originalTitle &&
        other.index == index &&
        other.tournamentName == tournamentName;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        originalTitle.hashCode ^
        index.hashCode ^
        tournamentName.hashCode;
  }
}

class CreateMatchesManuallyViewArguments {
  const CreateMatchesManuallyViewArguments({
    this.key,
    required this.players,
    required this.originalTitle,
    required this.tournamentName,
    required this.index,
  });

  final _i25.Key? key;

  final List<String> players;

  final String originalTitle;

  final String tournamentName;

  final int index;

  @override
  String toString() {
    return '{"key": "$key", "players": "$players", "originalTitle": "$originalTitle", "tournamentName": "$tournamentName", "index": "$index"}';
  }

  @override
  bool operator ==(covariant CreateMatchesManuallyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.players == players &&
        other.originalTitle == originalTitle &&
        other.tournamentName == tournamentName &&
        other.index == index;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        players.hashCode ^
        originalTitle.hashCode ^
        tournamentName.hashCode ^
        index.hashCode;
  }
}

class ScoreboardViewArguments {
  const ScoreboardViewArguments({
    this.key,
    required this.tournamentName,
    required this.originalTitle,
    required this.index,
    this.tournamentData,
  });

  final _i25.Key? key;

  final String tournamentName;

  final String originalTitle;

  final int index;

  final dynamic tournamentData;

  @override
  String toString() {
    return '{"key": "$key", "tournamentName": "$tournamentName", "originalTitle": "$originalTitle", "index": "$index", "tournamentData": "$tournamentData"}';
  }

  @override
  bool operator ==(covariant ScoreboardViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.tournamentName == tournamentName &&
        other.originalTitle == originalTitle &&
        other.index == index &&
        other.tournamentData == tournamentData;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        tournamentName.hashCode ^
        originalTitle.hashCode ^
        index.hashCode ^
        tournamentData.hashCode;
  }
}

class ScoringMatchViewArguments {
  const ScoringMatchViewArguments({
    this.key,
    required this.player1,
    required this.player2,
    required this.matchday,
    required this.originalTitle,
    required this.matchIndex,
    required this.tournamentName,
    required this.player1Score,
    required this.player2Score,
    required this.date,
    required this.time,
  });

  final _i25.Key? key;

  final String player1;

  final String player2;

  final int matchday;

  final String originalTitle;

  final int matchIndex;

  final String tournamentName;

  final int player1Score;

  final int player2Score;

  final String date;

  final String time;

  @override
  String toString() {
    return '{"key": "$key", "player1": "$player1", "player2": "$player2", "matchday": "$matchday", "originalTitle": "$originalTitle", "matchIndex": "$matchIndex", "tournamentName": "$tournamentName", "player1Score": "$player1Score", "player2Score": "$player2Score", "date": "$date", "time": "$time"}';
  }

  @override
  bool operator ==(covariant ScoringMatchViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.player1 == player1 &&
        other.player2 == player2 &&
        other.matchday == matchday &&
        other.originalTitle == originalTitle &&
        other.matchIndex == matchIndex &&
        other.tournamentName == tournamentName &&
        other.player1Score == player1Score &&
        other.player2Score == player2Score &&
        other.date == date &&
        other.time == time;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        player1.hashCode ^
        player2.hashCode ^
        matchday.hashCode ^
        originalTitle.hashCode ^
        matchIndex.hashCode ^
        tournamentName.hashCode ^
        player1Score.hashCode ^
        player2Score.hashCode ^
        date.hashCode ^
        time.hashCode;
  }
}

class StandingViewArguments {
  const StandingViewArguments({
    this.key,
    required this.tournamentTitle,
  });

  final _i25.Key? key;

  final String tournamentTitle;

  @override
  String toString() {
    return '{"key": "$key", "tournamentTitle": "$tournamentTitle"}';
  }

  @override
  bool operator ==(covariant StandingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.tournamentTitle == tournamentTitle;
  }

  @override
  int get hashCode {
    return key.hashCode ^ tournamentTitle.hashCode;
  }
}

class ModifyMatchesViewArguments {
  const ModifyMatchesViewArguments({
    this.key,
    required this.originalTitle,
    required this.index,
    required this.tournamentName,
  });

  final _i25.Key? key;

  final String originalTitle;

  final int index;

  final String tournamentName;

  @override
  String toString() {
    return '{"key": "$key", "originalTitle": "$originalTitle", "index": "$index", "tournamentName": "$tournamentName"}';
  }

  @override
  bool operator ==(covariant ModifyMatchesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.originalTitle == originalTitle &&
        other.index == index &&
        other.tournamentName == tournamentName;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        originalTitle.hashCode ^
        index.hashCode ^
        tournamentName.hashCode;
  }
}

class ModifyMatchesManuallyViewArguments {
  const ModifyMatchesManuallyViewArguments({
    this.key,
    required this.originalTitle,
    required this.allPlayers,
  });

  final _i25.Key? key;

  final String originalTitle;

  final List<String> allPlayers;

  @override
  String toString() {
    return '{"key": "$key", "originalTitle": "$originalTitle", "allPlayers": "$allPlayers"}';
  }

  @override
  bool operator ==(covariant ModifyMatchesManuallyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.originalTitle == originalTitle &&
        other.allPlayers == allPlayers;
  }

  @override
  int get hashCode {
    return key.hashCode ^ originalTitle.hashCode ^ allPlayers.hashCode;
  }
}

class EditAllParticipantViewArguments {
  const EditAllParticipantViewArguments({
    this.key,
    required this.participantName,
  });

  final _i25.Key? key;

  final String participantName;

  @override
  String toString() {
    return '{"key": "$key", "participantName": "$participantName"}';
  }

  @override
  bool operator ==(covariant EditAllParticipantViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.participantName == participantName;
  }

  @override
  int get hashCode {
    return key.hashCode ^ participantName.hashCode;
  }
}

extension NavigatorStateExtension on _i26.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewTournamentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.newTournamentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTournamentOptionView({
    _i25.Key? key,
    required String tournamentName,
    required String originalTitle,
    required int index,
    dynamic tournamentData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.tournamentOptionView,
        arguments: TournamentOptionViewArguments(
            key: key,
            tournamentName: tournamentName,
            originalTitle: originalTitle,
            index: index,
            tournamentData: tournamentData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTournamentDetailsView({
    _i25.Key? key,
    required String tournamentName,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.tournamentDetailsView,
        arguments: TournamentDetailsViewArguments(
            key: key, tournamentName: tournamentName, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToParticipantView({
    _i25.Key? key,
    required String originalTitle,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.participantView,
        arguments: ParticipantViewArguments(
            key: key, originalTitle: originalTitle, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddParticipantView({
    _i25.Key? key,
    required String originalTitle,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addParticipantView,
        arguments: AddParticipantViewArguments(
            key: key, originalTitle: originalTitle, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditParticipantView({
    _i25.Key? key,
    required String tournamentName,
    required String participantName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editParticipantView,
        arguments: EditParticipantViewArguments(
            key: key,
            tournamentName: tournamentName,
            participantName: participantName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateMatchesView({
    _i25.Key? key,
    required String originalTitle,
    required int index,
    required String tournamentName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createMatchesView,
        arguments: CreateMatchesViewArguments(
            key: key,
            originalTitle: originalTitle,
            index: index,
            tournamentName: tournamentName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateMatchesManuallyView({
    _i25.Key? key,
    required List<String> players,
    required String originalTitle,
    required String tournamentName,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createMatchesManuallyView,
        arguments: CreateMatchesManuallyViewArguments(
            key: key,
            players: players,
            originalTitle: originalTitle,
            tournamentName: tournamentName,
            index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToScoreboardView({
    _i25.Key? key,
    required String tournamentName,
    required String originalTitle,
    required int index,
    dynamic tournamentData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.scoreboardView,
        arguments: ScoreboardViewArguments(
            key: key,
            tournamentName: tournamentName,
            originalTitle: originalTitle,
            index: index,
            tournamentData: tournamentData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToScoringMatchView({
    _i25.Key? key,
    required String player1,
    required String player2,
    required int matchday,
    required String originalTitle,
    required int matchIndex,
    required String tournamentName,
    required int player1Score,
    required int player2Score,
    required String date,
    required String time,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.scoringMatchView,
        arguments: ScoringMatchViewArguments(
            key: key,
            player1: player1,
            player2: player2,
            matchday: matchday,
            originalTitle: originalTitle,
            matchIndex: matchIndex,
            tournamentName: tournamentName,
            player1Score: player1Score,
            player2Score: player2Score,
            date: date,
            time: time),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStandingView({
    _i25.Key? key,
    required String tournamentTitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.standingView,
        arguments:
            StandingViewArguments(key: key, tournamentTitle: tournamentTitle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExistingTournamentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.existingTournamentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToModifyMatchesView({
    _i25.Key? key,
    required String originalTitle,
    required int index,
    required String tournamentName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.modifyMatchesView,
        arguments: ModifyMatchesViewArguments(
            key: key,
            originalTitle: originalTitle,
            index: index,
            tournamentName: tournamentName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToModifyMatchesManuallyView({
    _i25.Key? key,
    required String originalTitle,
    required List<String> allPlayers,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.modifyMatchesManuallyView,
        arguments: ModifyMatchesManuallyViewArguments(
            key: key, originalTitle: originalTitle, allPlayers: allPlayers),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTournamentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.tournamentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllParticipantView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allParticipantView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddtoAllParticipantView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addtoAllParticipantView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditAllParticipantView({
    _i25.Key? key,
    required String participantName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editAllParticipantView,
        arguments: EditAllParticipantViewArguments(
            key: key, participantName: participantName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDeleteUserView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.deleteUserView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewTournamentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.newTournamentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTournamentOptionView({
    _i25.Key? key,
    required String tournamentName,
    required String originalTitle,
    required int index,
    dynamic tournamentData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.tournamentOptionView,
        arguments: TournamentOptionViewArguments(
            key: key,
            tournamentName: tournamentName,
            originalTitle: originalTitle,
            index: index,
            tournamentData: tournamentData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTournamentDetailsView({
    _i25.Key? key,
    required String tournamentName,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.tournamentDetailsView,
        arguments: TournamentDetailsViewArguments(
            key: key, tournamentName: tournamentName, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithParticipantView({
    _i25.Key? key,
    required String originalTitle,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.participantView,
        arguments: ParticipantViewArguments(
            key: key, originalTitle: originalTitle, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddParticipantView({
    _i25.Key? key,
    required String originalTitle,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addParticipantView,
        arguments: AddParticipantViewArguments(
            key: key, originalTitle: originalTitle, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditParticipantView({
    _i25.Key? key,
    required String tournamentName,
    required String participantName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editParticipantView,
        arguments: EditParticipantViewArguments(
            key: key,
            tournamentName: tournamentName,
            participantName: participantName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateMatchesView({
    _i25.Key? key,
    required String originalTitle,
    required int index,
    required String tournamentName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createMatchesView,
        arguments: CreateMatchesViewArguments(
            key: key,
            originalTitle: originalTitle,
            index: index,
            tournamentName: tournamentName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateMatchesManuallyView({
    _i25.Key? key,
    required List<String> players,
    required String originalTitle,
    required String tournamentName,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createMatchesManuallyView,
        arguments: CreateMatchesManuallyViewArguments(
            key: key,
            players: players,
            originalTitle: originalTitle,
            tournamentName: tournamentName,
            index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithScoreboardView({
    _i25.Key? key,
    required String tournamentName,
    required String originalTitle,
    required int index,
    dynamic tournamentData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.scoreboardView,
        arguments: ScoreboardViewArguments(
            key: key,
            tournamentName: tournamentName,
            originalTitle: originalTitle,
            index: index,
            tournamentData: tournamentData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithScoringMatchView({
    _i25.Key? key,
    required String player1,
    required String player2,
    required int matchday,
    required String originalTitle,
    required int matchIndex,
    required String tournamentName,
    required int player1Score,
    required int player2Score,
    required String date,
    required String time,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.scoringMatchView,
        arguments: ScoringMatchViewArguments(
            key: key,
            player1: player1,
            player2: player2,
            matchday: matchday,
            originalTitle: originalTitle,
            matchIndex: matchIndex,
            tournamentName: tournamentName,
            player1Score: player1Score,
            player2Score: player2Score,
            date: date,
            time: time),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStandingView({
    _i25.Key? key,
    required String tournamentTitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.standingView,
        arguments:
            StandingViewArguments(key: key, tournamentTitle: tournamentTitle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExistingTournamentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.existingTournamentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithModifyMatchesView({
    _i25.Key? key,
    required String originalTitle,
    required int index,
    required String tournamentName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.modifyMatchesView,
        arguments: ModifyMatchesViewArguments(
            key: key,
            originalTitle: originalTitle,
            index: index,
            tournamentName: tournamentName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithModifyMatchesManuallyView({
    _i25.Key? key,
    required String originalTitle,
    required List<String> allPlayers,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.modifyMatchesManuallyView,
        arguments: ModifyMatchesManuallyViewArguments(
            key: key, originalTitle: originalTitle, allPlayers: allPlayers),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTournamentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.tournamentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllParticipantView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allParticipantView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddtoAllParticipantView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addtoAllParticipantView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditAllParticipantView({
    _i25.Key? key,
    required String participantName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editAllParticipantView,
        arguments: EditAllParticipantViewArguments(
            key: key, participantName: participantName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDeleteUserView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.deleteUserView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
