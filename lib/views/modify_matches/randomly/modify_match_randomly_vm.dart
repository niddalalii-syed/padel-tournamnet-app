// // ignore_for_file: sl

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/service/userService.dart';

class ModifyMatchesVM extends BaseViewModel {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userService = locator<Userservice>();

  int rounds = 1; // This might be fully replaced by gamesPerOpponentPair
  int pointsVictory = 1;
  int pointsTie = 0;
  int pointsLose = 0;

  int gamesPerOpponentPair = 2; // Default to 2 (home and away)

  // REMOVED: maxMatchesPerDay property and its setter, as there is no fixed constraint anymore.

  init(tournamentName) {
    getParticipantsNames(tournamentName);
    notifyListeners();
  }

  void setRounds(int value) {
    rounds = value;
    notifyListeners();
  }

  void setGamesPerOpponentPair(int value) {
    gamesPerOpponentPair = value;
    notifyListeners();
  }

  void setPointsVictory(int value) {
    pointsVictory = value;
    notifyListeners();
  }

  void setPointsTie(int value) {
    pointsTie = value;
    notifyListeners();
  }

  void setPointsLose(int value) {
    pointsLose = value;
    notifyListeners();
  }

  void generateRandomly(originalTitle, index, tournamentName) async {
    setBusy(true);
    SnackbarService().showSnackbar(
        message: 'Generating matches, please wait...',
        duration: const Duration(seconds: 2));
    try {
      var matchdays = createMatchSchedule(
          userService.allParticipantsName, gamesPerOpponentPair);
      printSchedule(matchdays);
      await addMatchRules(originalTitle);
      await uploadMatchdays(matchdays, originalTitle);
      log('Matchdays uploaded successfully.');
      setBusy(false);
      SnackbarService().showSnackbar(
          message: 'Matches generated successfully!',
          duration: const Duration(seconds: 2));
      NavigationService().replaceWithTournamentOptionView(
          tournamentName: tournamentName,
          originalTitle: originalTitle,
          index: index);
    } catch (e) {
      setBusy(false);
      SnackbarService().showSnackbar(
          message: 'Error generating matches: ${e.toString()}',
          duration: const Duration(seconds: 2));
      log('Error in generateRandomly: $e');
    }
  }

  getParticipantsNames(tournamentName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log('User not logged in.');
      SnackbarService().showSnackbar(
          message: 'Error: User not logged in.',
          duration: const Duration(seconds: 2));
      return;
    }

    Map<String, dynamic> singleData = {};
    userService.allParticipantsName = [];
    notifyListeners();

    try {
      final querySnapshot = await firestore
          .collection(user.uid)
          .doc(tournamentName)
          .collection('Participant')
          .get();

      for (int i = 0; i < querySnapshot.docs.length; i++) {
        singleData = querySnapshot.docs[i].data();
        userService.allParticipantsName.add(singleData['name']);
      }
      log("Participant Names: ${userService.allParticipantsName}");
      notifyListeners();
    } catch (e) {
      log("Error fetching participants: $e");
      SnackbarService().showSnackbar(
          message: 'Error fetching participants: ${e.toString()}',
          duration: const Duration(seconds: 2));
    }
  }

  Future<void> addMatchRules(tournamentName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log('User not logged in.');
      SnackbarService().showSnackbar(
          message: 'Error: User not logged in.',
          duration: const Duration(seconds: 2));
      return;
    }

    try {
      await firestore
          .collection(user.uid)
          .doc(tournamentName)
          .collection('MatchRules')
          .doc('Rules')
          .set(
        {
          'pointsVictory': pointsVictory,
          'pointsTie': pointsTie,
          'pointsLose': pointsLose,
          'gamesPerOpponentPair': gamesPerOpponentPair,
          // REMOVED: maxMatchesPerDay from here
        },
      );
      SnackbarService().showSnackbar(
          message: 'Match rules added successfully!',
          duration: const Duration(seconds: 2));
    } catch (e) {
      log("Error adding match rules: $e");
      SnackbarService().showSnackbar(
          message: 'Error adding match rules: ${e.toString()}',
          duration: const Duration(seconds: 2));
    }
  }

  // OLD `calculateMatchesPerDay` and `totalMatch` methods are removed,
  // as the new `createMatchSchedule` directly uses `maxMatchesPerDay`
  // for grouping, and `totalMatch` was a derived calculation.

  /**
   * Generates a round-robin match schedule based on the number of players
   * and how many times each pair should play each other.
   * Each matchday will contain the natural number of simultaneous matches
   * for a round-robin setup (N_effective / 2).
   *
   * @param players The list of player names.
   * @param gamesPerOpponentPair The number of times each player pair should play.
   */
  List<Map<String, dynamic>> createMatchSchedule(
      List<String> players, int gamesPerOpponentPair) {
    if (players.length < 2) {
      log("Not enough players to create a schedule (need at least 2).");
      return [];
    }

    bool isOddPlayers = players.length % 2 != 0;
    String dummyPlayer = "_BYE_";

    List<String> tempPlayers = List.from(players);
    if (isOddPlayers) {
      tempPlayers.add(dummyPlayer);
    }

    int N_effective = tempPlayers.length;
    int numBasicSingleRounds = N_effective - 1;

    // Step 1: Generate a single basic round-robin schedule
    // Each inner list here represents a 'logical round' of the circle method.
    // For 20 players, each logical round will have 10 matches.
    List<List<Map<String, dynamic>>> baseRoundRobinSchedule = [];

    for (int r = 0; r < numBasicSingleRounds; r++) {
      List<Map<String, dynamic>> currentLogicalRoundMatches = [];

      String p1Fixed = tempPlayers[0];
      String p2Fixed = tempPlayers[N_effective - 1];
      if (p1Fixed != dummyPlayer && p2Fixed != dummyPlayer) {
        currentLogicalRoundMatches.add({
          'player1': p1Fixed,
          'player2': p2Fixed,
          'scores': {'player1': 0, 'player2': 0},
          'matchId': '${p1Fixed}_vs_${p2Fixed}_R${r + 1}_G1'
        });
      }

      for (int i = 1; i < N_effective ~/ 2; i++) {
        String p1 = tempPlayers[i];
        String p2 = tempPlayers[N_effective - 1 - i];
        if (p1 != dummyPlayer && p2 != dummyPlayer) {
          currentLogicalRoundMatches.add({
            'player1': p1,
            'player2': p2,
            'scores': {'player1': 0, 'player2': 0},
            'matchId': '${p1}_vs_${p2}_R${r + 1}_G1'
          });
        }
      }
      if (currentLogicalRoundMatches.isNotEmpty) {
        baseRoundRobinSchedule.add(currentLogicalRoundMatches);
      }

      if (N_effective > 1) {
        String lastPlayer = tempPlayers.removeLast();
        tempPlayers.insert(1, lastPlayer);
      }
    }

    // Step 2: Duplicate and reverse the basic schedule based on `gamesPerOpponentPair`.
    // Each 'logical round' will now become a single 'matchday'.
    List<Map<String, dynamic>> finalMatchdays = [];
    int globalMatchdayCounter = 1;

    for (int g = 0; g < gamesPerOpponentPair; g++) {
      bool isReversedRound = (g % 2 != 0);

      for (int r = 0; r < baseRoundRobinSchedule.length; r++) {
        List<Map<String, dynamic>> matchesForThisMatchday =
            []; // This will be our actual matchday

        for (var match in baseRoundRobinSchedule[r]) {
          if (isReversedRound) {
            matchesForThisMatchday.add({
              'player1': match['player2'],
              'player2': match['player1'],
              'scores': {'player1': 0, 'player2': 0},
              'matchId':
                  '${match['player2']}_vs_${match['player1']}_R${r + 1}_G${g + 1}'
            });
          } else {
            matchesForThisMatchday.add({
              'player1': match['player1'],
              'player2': match['player2'],
              'scores': {'player1': 0, 'player2': 0},
              'matchId':
                  '${match['player1']}_vs_${match['player2']}_R${r + 1}_G${g + 1}'
            });
          }
        }

        // Add the entire logical round as a single matchday
        if (matchesForThisMatchday.isNotEmpty) {
          finalMatchdays.add({
            'matchday': globalMatchdayCounter++,
            'matches': matchesForThisMatchday,
          });
        }
      }
    }

    final int matchesPerNaturalDay = N_effective ~/ 2;
    log("Generated ${finalMatchdays.length} matchdays across $gamesPerOpponentPair game(s) per opponent pair. Each matchday will have up to $matchesPerNaturalDay matches.");
    if (isOddPlayers) {
      log("Note: A dummy player was used. Players scheduled against '_BYE_' get a rest for that matchday.");
    }
    return finalMatchdays;
  }

  void printSchedule(List<Map<String, dynamic>> matchdays) {
    log('Total Matchdays: ${matchdays.length}');

    for (var day in matchdays) {
      log('Matchday ${day['matchday']}:');
      var matches = day['matches'];
      if (matches.isEmpty) {
        log('   (No matches scheduled for this day)');
      } else {
        for (var match in matches) {
          log('   ${match['player1']} vs ${match['player2']} (ID: ${match['matchId']})');
        }
      }
      log('');
    }
  }

  Future<void> uploadMatchdays(
      List<Map<String, dynamic>> matchdays, String originalTitle) async {
    final user = FirebaseAuth.instance.currentUser?.uid;
    if (user == null) {
      log('User not logged in for upload.');
      SnackbarService().showSnackbar(
          message: 'Error: User not logged in for upload.',
          duration: const Duration(seconds: 2));
      return;
    }

    final collection = FirebaseFirestore.instance
        .collection(user)
        .doc(originalTitle)
        .collection('Matches');

    try {
      final oldMatches = await collection.get();
      for (var doc in oldMatches.docs) {
        await doc.reference.delete();
      }
      log('Cleared previous matches for $originalTitle.');
    } catch (e) {
      log('Error clearing previous matches: $e');
    }

    for (int i = 0; i < matchdays.length; i++) {
      var day = matchdays[i];

      int sequentialMatchday = i + 1;
      await collection.doc('matchday$sequentialMatchday').set({
        'matchday': sequentialMatchday,
        'matches': day['matches'].map((match) {
          return {
            'player1': match['player1'],
            'player2': match['player2'],
            'scores': match['scores'],
          };
        }).toList(),
      });
    }
  }

  onDeleteMatchesandMatchRules(tournament) async {
    // await deleteTournament(tournament);
    await deleteSubsectionsInTournament(tournament);
    notifyListeners();
  }

  Future<void> deleteSubsectionsInTournament(String tournament) async {
    final user = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    final tournamentDoc = firestore.collection(user!.uid).doc(tournament);

    await _deleteSub(tournamentDoc, 'MatchRules');
    await _deleteSub(tournamentDoc, 'Matches');

    print('Matches and MatchRules subcollections deleted.');
  }

  Future<void> _deleteSub(
      DocumentReference parentDoc, String subcollectionName) async {
    final subcollection = parentDoc.collection(subcollectionName);
    final snapshots = await subcollection.get();

    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
