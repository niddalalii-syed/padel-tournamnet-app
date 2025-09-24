// // ignore_for_file: unused_local_variable

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:tournament_manager/app/app.locator.dart';
// import 'package:tournament_manager/service/userService.dart';

// class ModifyMatchesManuallyVM extends BaseViewModel {
//   final _snackbarService = locator<SnackbarService>();
//   final Userservice userService = locator<Userservice>();

//   late String _originalTitle;
//   List<String> _allTournamentPlayers = [];

//   List<String> selectedPlayers = [];
//   List<String> players = [];
//   List<Map<String, dynamic>> matchdays = [];

//   TabController? tabController;
//   TickerProvider? vsync;

//   void init(
//       String originalTitle, List<String> allPlayers, TickerProvider ticker) {
//     _originalTitle = originalTitle;
//     _allTournamentPlayers =
//         allPlayers;
//     print(
//         'ModifyMatchesManuallyVM: _allTournamentPlayers after init = $_allTournamentPlayers');
//     userService.allPlayers =
//         allPlayers;
//     vsync = ticker;
//   }

//   Future<void> loadMatches() async {
//     setBusy(true);
//     try {
//       final user = FirebaseAuth.instance.currentUser?.uid;
//       if (user == null) {
//         _snackbarService.showSnackbar(
//             message: 'User not logged in.', title: 'Error');
//         setBusy(false);
//         return;
//       }

//       final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection(user)
//           .doc(_originalTitle)
//           .collection('Matches')
//           .orderBy('matchday')
//           .get();

//       print(
//           'Query Snapshot docs count: ${querySnapshot.docs.length}');
//       final List<Map<String, dynamic>> loadedMatchdays = [];
//       for (var doc in querySnapshot.docs) {
//         print('Processing document: ${doc.id}');
//         final data = doc.data() as Map<String, dynamic>;
//         print('Document data for ${doc.id}: $data');

//         final List<dynamic> matchesData = data['matches'] ?? [];

//         List<Map<String, dynamic>> parsedMatches = [];
//         for (var matchWrapper in matchesData) {
//           if (matchWrapper is Map<String, dynamic> &&
//               matchWrapper.containsKey('match')) {
//             final List<dynamic> innerMatchArray = matchWrapper['match'];
//             if (innerMatchArray.isNotEmpty &&
//                 innerMatchArray[0] is Map<String, dynamic>) {
//               parsedMatches.add({
//                 'player1': innerMatchArray[0]['player1'],
//                 'player2': innerMatchArray[0]['player2'],
//                 'scores': innerMatchArray[0]['scores'] ??
//                     {'player1': 0, 'player2': 0},
//               });
//             }
//           }
//         }
//         print(
//             'Parsed matches count for ${doc.id}: ${parsedMatches.length}');

//         int matchdayNum = int.tryParse(doc.id.replaceFirst('matchday', '')) ??
//             loadedMatchdays.length + 1;

//         loadedMatchdays.add({
//           'matchday': matchdayNum,
//           'matches': parsedMatches,
//           'editable': true,
//         });
//       }

//       loadedMatchdays.sort(
//           (a, b) => (a['matchday'] as int).compareTo(b['matchday'] as int));

//       matchdays = loadedMatchdays;
//       print('Total loaded matchdays: ${matchdays.length}');

//       if (matchdays.isEmpty) {
//         addNewMatchDay();
//       } else {
//         _initTabController();
//         updateTabIndex(0);
//       }
//     } catch (e) {
//       _snackbarService.showSnackbar(
//           message: 'Error loading matches: $e', title: 'Error');
//       print('Error loading matches: $e');
//     } finally {
//       setBusy(false);
//       notifyListeners();
//     }
//   }

//   void _initTabController() {
//     if (vsync != null && matchdays.isNotEmpty) {
//       tabController = TabController(length: matchdays.length, vsync: vsync!);
//       tabController!.addListener(() {
//         if (!tabController!.indexIsChanging) {
//           updateTabIndex(tabController!.index);
//         }
//       });
//       notifyListeners();
//     }
//   }

// void _addNewMatchday() {
//   matchdays.add({
//     'matchday': matchdays.length + 1,
//     'matches': [],
//     'editable': true, // This flag is now conceptually always true
//   });

//   selectedPlayers.clear();
//   // For a newly added matchday, all players are initially available
//   players = List.from(userService.allPlayers);

//   _initTabController();
//   if (matchdays.isNotEmpty) {
//     // Ensure the tab controller is properly initialized before animating
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       tabController?.animateTo(matchdays.length - 1);
//       _currentTabIndex =
//           matchdays.length - 1; // Update current index to the new tab
//       notifyListeners(); // Notify again to ensure UI updates based on currentTabIndex
//     });
//   }
//   notifyListeners();
// }

//   void updateTabIndex(int index) {
//     if (matchdays.isEmpty || index < 0 || index >= matchdays.length) {
//       selectedPlayers.clear();
//       players.clear();
//       print(
//           'updateTabIndex: players (empty/invalid index) = $players');
//       notifyListeners();
//       return;
//     }
//     final matchday = matchdays[index];
//     selectedPlayers.clear();
//     players = _remainingPlayers(matchday['matches']);
//     print('updateTabIndex: players after update = $players');
//     notifyListeners();
//   }

//   List<String> _remainingPlayers(List<dynamic> matches) {
//     print('_remainingPlayers: matches input = $matches');
//     final used = matches.expand((m) => [m['player1'], m['player2']]).toSet();
//     print('_remainingPlayers: used players = $used');
//     final available =
//         _allTournamentPlayers.where((p) => !used.contains(p)).toList();
//     print('_remainingPlayers: available players = $available');
//     return available;
//   }

//   void selectPlayer(String playerName) {
//     if (selectedPlayers.contains(playerName)) {
//       _snackbarService.showSnackbar(message: 'Player already selected.');
//       return;
//     }

//     selectedPlayers.add(playerName);
//     players.remove(playerName);
//     notifyListeners();

//     if (selectedPlayers.length == 2) {
//       _addMatch();
//     }
//   }

//   void _addMatch() {
//     final matchday = matchdays[tabController!.index];
//     final currentMatches = matchday['matches'].length;
//     final limit = matchesLimit(_allTournamentPlayers.length);

//     if (currentMatches >= limit) {
//       _snackbarService.showSnackbar(
//           message:
//               'Match limit reached for this day. Cannot add more matches.');
//       players.addAll(selectedPlayers);
//       selectedPlayers.clear();
//       notifyListeners();
//       return;
//     }

//     final p1 = selectedPlayers[0];
//     final p2 = selectedPlayers[1];

//     bool isDuplicate = matchday['matches'].any((m) =>
//         (m['player1'] == p1 && m['player2'] == p2) ||
//         (m['player1'] == p2 && m['player2'] == p1));

//     if (isDuplicate) {
//       _snackbarService.showSnackbar(message: 'This match already exists.');
//       players.addAll(selectedPlayers); // Add back if duplicate
//       selectedPlayers.clear();
//       notifyListeners();
//       return;
//     }

//     matchday['matches'].add({
//       'player1': p1,
//       'player2': p2,
//       'scores': {'player1': 0, 'player2': 0}
//     });

//     selectedPlayers.clear();
//     players = _remainingPlayers(matchday['matches']);
//     notifyListeners();
//   }

//   void editMatch(int index) {
//     if (selectedPlayers.isNotEmpty) {
//       _snackbarService.showSnackbar(
//           message:
//               'Complete current selection first before editing another match.');
//       return;
//     }

//     final match = matchdays[tabController!.index]['matches'][index];
//     final playerToReSelect = match['player1'];

//     deleteMatch(index);

//     selectedPlayers.add(playerToReSelect);
//     players.remove(playerToReSelect);
//     print('editMatch: players after update (final) = $players');
//     notifyListeners();
//   }

//   void deleteMatch(int index) {
//     final currentMatchdayIndex = tabController!.index;
//     final match = matchdays[currentMatchdayIndex]['matches'][index];
//     matchdays[currentMatchdayIndex]['matches'].removeAt(index);

//     selectedPlayers.clear();

//     players = _remainingPlayers(matchdays[currentMatchdayIndex]['matches']);
//     print('deleteMatch: players after update = $players');
//     notifyListeners();
//   }

//   bool canAddMoreMatchesToCurrentDay() {
//     if (matchdays.isEmpty ||
//         tabController == null ||
//         tabController!.index >= matchdays.length) {
//       return false;
//     }
//     final currentMatchday = matchdays[tabController!.index];
//     return currentMatchday['matches'].length <
//         matchesLimit(_allTournamentPlayers.length);
//   }

//   int matchesLimit(int totalPlayers) {
//     if (totalPlayers < 4) return 1;
//     if (totalPlayers <= 5) return 2;
//     if (totalPlayers <= 7) return 3;
//     if (totalPlayers <= 9) return 4;
//     return 5;
//   }

//   @override
//   void dispose() {
//     tabController?.dispose();
//     super.dispose();
//   }
// }

// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/service/userService.dart';

class ModifyMatchesManuallyVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final Userservice userService = locator<Userservice>();

  late String _originalTitle;
  List<String> _allTournamentPlayers = [];

  List<String> selectedPlayers = [];
  List<String> players = [];
  List<Map<String, dynamic>> matchdays = [];

  TabController? tabController;
  TickerProvider? vsync;

  // Track the current tab index for accurate player availability
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void init(
      String originalTitle, List<String> allPlayers, TickerProvider ticker) {
    _originalTitle = originalTitle;
    _allTournamentPlayers = allPlayers;
    print(
        'ModifyMatchesManuallyVM: _allTournamentPlayers after init = $_allTournamentPlayers');
    userService.allPlayers = allPlayers;
    vsync = ticker;
  }

  void _initTabController() {
    if (vsync != null && matchdays.isNotEmpty) {
      tabController?.dispose();
      tabController = TabController(length: matchdays.length, vsync: vsync!);
      tabController!.addListener(() {
        if (!tabController!.indexIsChanging) {
          updateTabIndex(tabController!.index);
        }
      });
      notifyListeners();
    }
  }

  void updateTabIndex(int index) {
    _currentTabIndex = index;
    if (matchdays.isEmpty || index < 0 || index >= matchdays.length) {
      selectedPlayers.clear();
      players.clear();
      print('updateTabIndex: players (empty/invalid index) = $players');
      notifyListeners();
      return;
    }
    final matchday = matchdays[_currentTabIndex];
    selectedPlayers.clear();
    players = _remainingPlayers(matchday['matches']);
    print('updateTabIndex: players after update = $players');
    notifyListeners();
  }

  List<String> _remainingPlayers(List<dynamic> matches) {
    print('_remainingPlayers: matches input = $matches');
    final used = matches.expand((m) => [m['player1'], m['player2']]).toSet();
    print('_remainingPlayers: used players = $used');
    final available =
        _allTournamentPlayers.where((p) => !used.contains(p)).toList();
    print('_remainingPlayers: available players = $available');
    return available;
  }

  void selectPlayer(String playerName) {
    if (selectedPlayers.contains(playerName)) {
      _snackbarService.showSnackbar(message: 'Player already selected.');
      return;
    }

    selectedPlayers.add(playerName);
    players.remove(playerName);
    notifyListeners();

    if (selectedPlayers.length == 2) {
      _addMatch();
    }
  }

  void _addMatch() {
    final matchday = matchdays[_currentTabIndex];
    final currentMatches = (matchday['matches'] as List).length;
    final limit = matchesLimit(_allTournamentPlayers.length);

    if (currentMatches >= limit) {
      _snackbarService.showSnackbar(
          message:
              'Match limit reached for this day. Cannot add more matches.');
      players.addAll(selectedPlayers);
      selectedPlayers.clear();
      notifyListeners();
      return;
    }

    final p1 = selectedPlayers[0];
    final p2 = selectedPlayers[1];

    bool isDuplicate = (matchday['matches'] as List).any((m) =>
        (m['player1'] == p1 && m['player2'] == p2) ||
        (m['player1'] == p2 && m['player2'] == p1));

    if (isDuplicate) {
      _snackbarService.showSnackbar(message: 'This match already exists.');
      players.addAll(selectedPlayers);
      selectedPlayers.clear();
      notifyListeners();
      return;
    }

    matchday['matches'].add({
      'player1': p1,
      'player2': p2,
      'scores': {'player1': 0, 'player2': 0}
    });

    selectedPlayers.clear();
    players = _remainingPlayers(matchday['matches']);
    notifyListeners();
  }

  void editMatch(int index) {
    if (selectedPlayers.isNotEmpty) {
      _snackbarService.showSnackbar(
          message:
              'Complete current selection first before editing another match.');
      return;
    }

    final match = matchdays[_currentTabIndex]['matches'][index];
    deleteMatch(index);
    selectedPlayers = [match['player1']];
    notifyListeners();
  }

  void deleteMatch(int index) {
    final currentMatchdayIndex = _currentTabIndex;
    final match = matchdays[currentMatchdayIndex]['matches'][index];
    (matchdays[currentMatchdayIndex]['matches'] as List).removeAt(index);

    selectedPlayers.clear();
    players = _remainingPlayers(matchdays[currentMatchdayIndex]['matches']);
    print('deleteMatch: players after update = $players');
    notifyListeners();
  }

  bool canAddMoreMatchesToCurrentDay() {
    if (matchdays.isEmpty || _currentTabIndex >= matchdays.length) {
      return false;
    }
    final currentMatchday = matchdays[_currentTabIndex];
    return (currentMatchday['matches'] as List).length <
        matchesLimit(_allTournamentPlayers.length);
  }

  int matchesLimit(int totalPlayers) {
    if (totalPlayers < 2) return 0;
    if (totalPlayers == 2) return 1;
    if (totalPlayers <= 4) return (totalPlayers / 2).ceil();
    if (totalPlayers <= 8) return (totalPlayers / 2).ceil();
    if (totalPlayers <= 12) return (totalPlayers / 2).ceil();
    if (totalPlayers <= 16) return (totalPlayers / 2).ceil();
    return (totalPlayers / 2).ceil();
  }

  // Future<void> loadMatches() async {
  //   setBusy(true);
  //   try {
  //     final user = FirebaseAuth.instance.currentUser?.uid;
  //     if (user == null) {
  //       _snackbarService.showSnackbar(
  //           message: 'User not logged in.', title: 'Error');
  //       setBusy(false);
  //       return;
  //     }

  //     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection(user)
  //         .doc(_originalTitle)
  //         .collection('Matches')
  //         .orderBy('matchday')
  //         .get();

  //     print('Query Snapshot docs count: ${querySnapshot.docs.length}');
  //     final List<Map<String, dynamic>> loadedMatchdays = [];
  //     for (var doc in querySnapshot.docs) {
  //       print('Processing document: ${doc.id}');
  //       final data = doc.data() as Map<String, dynamic>;
  //       print('Document data for ${doc.id}: $data');

  //       final List<dynamic> matchesData = data['matches'] ?? [];

  //       List<Map<String, dynamic>> parsedMatches = [];
  //       for (var matchWrapper in matchesData) {
  //         if (matchWrapper is Map<String, dynamic> &&
  //             matchWrapper.containsKey('match')) {
  //           final List<dynamic> innerMatchArray = matchWrapper['match'];
  //           if (innerMatchArray.isNotEmpty &&
  //               innerMatchArray[0] is Map<String, dynamic>) {
  //             parsedMatches.add({
  //               'player1': innerMatchArray[0]['player1'],
  //               'player2': innerMatchArray[0]['player2'],
  //               'scores': innerMatchArray[0]['scores'] ??
  //                   {'player1': 0, 'player2': 0},
  //             });
  //           }
  //         }
  //       }
  //       print('Parsed matches count for ${doc.id}: ${parsedMatches.length}');

  //       int matchdayNum = int.tryParse(doc.id.replaceFirst('matchday', '')) ??
  //           loadedMatchdays.length + 1;

  //       loadedMatchdays.add({
  //         'matchday': matchdayNum,
  //         'matches': parsedMatches,
  //         'editable': true,
  //       });
  //     }

  //     loadedMatchdays.sort(
  //         (a, b) => (a['matchday'] as int).compareTo(b['matchday'] as int));

  //     matchdays = loadedMatchdays;
  //     print('Total loaded matchdays: ${matchdays.length}');

  //     if (matchdays.isEmpty) {
  //       addNewMatchDay();
  //     } else {
  //       _initTabController();
  //       updateTabIndex(0);
  //     }
  //   } catch (e) {
  //     _snackbarService.showSnackbar(
  //         message: 'Error loading matches: $e', title: 'Error');
  //     print('Error loading matches: $e');
  //   } finally {
  //     setBusy(false);
  //     notifyListeners();
  //   }
  // }
  Future<void> loadMatches() async {
    setBusy(true);
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      if (user == null) {
        _snackbarService.showSnackbar(
            message: 'User not logged in.', title: 'Error');
        setBusy(false);
        return;
      }

      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(user)
          .doc(_originalTitle)
          .collection('Matches')
          .orderBy('matchday')
          .get();

      print('Query Snapshot docs count: ${querySnapshot.docs.length}');
      final List<Map<String, dynamic>> loadedMatchdays = [];
      for (var doc in querySnapshot.docs) {
        print('Processing document: ${doc.id}');
        final data = doc.data() as Map<String, dynamic>;
        print('Document data for ${doc.id}: $data');

        final List<dynamic> matchesData = data['matches'] ?? [];

        List<Map<String, dynamic>> parsedMatches = [];
        for (var match in matchesData) {
          if (match is Map<String, dynamic>) {
            parsedMatches.add({
              'player1': match['player1'],
              'player2': match['player2'],
              'scores': match['scores'] ?? {'player1': 0, 'player2': 0},
            });
          }
        }
        print('Parsed matches count for ${doc.id}: ${parsedMatches.length}');

        int matchdayNum = int.tryParse(doc.id.replaceFirst('matchday', '')) ??
            loadedMatchdays.length + 1;

        loadedMatchdays.add({
          'matchday': matchdayNum,
          'matches': parsedMatches,
          'editable': true,
        });
      }

      loadedMatchdays.sort(
          (a, b) => (a['matchday'] as int).compareTo(b['matchday'] as int));

      matchdays = loadedMatchdays;
      print('Total loaded matchdays: ${matchdays.length}');

      if (matchdays.isEmpty) {
        addNewMatchDay();
      } else {
        _initTabController();
        updateTabIndex(0);
      }
    } catch (e) {
      _snackbarService.showSnackbar(
          message: 'Error loading matches: $e', title: 'Error');
      print('Error loading matches: $e');
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  void addNewMatchDay() {
    matchdays.add({
      'matchday': matchdays.length + 1,
      'matches': [],
      'editable': true,
    });

    selectedPlayers.clear();
    players = List.from(_allTournamentPlayers);
    print('addNewMatchDay: players after update = $players');

    _initTabController();
    tabController?.animateTo(matchdays.length - 1);
    notifyListeners();
  }

  Future<void> addNewMatchDayWithConfirmation(context) async {
    // Before adding a new matchday, check if the current one is full
    if (matchdays.isNotEmpty) {
      final currentMatchday = matchdays[_currentTabIndex];
      final currentMatchesCount = (currentMatchday['matches'] as List).length;
      final maxMatchesForCurrentDay =
          matchesLimit(userService.allPlayers.length);

      if (currentMatchesCount < maxMatchesForCurrentDay &&
          currentMatchesCount > 0) {
        // AlertDialog(
        //   title: const Text('Warning'),
        //   content: const Text(
        //       'Current matchday is not full. Add more matches or proceed?'),
        //   actions: <Widget>[
        //     TextButton(
        //       onPressed: () {
        //         Navigator.of(context).pop(false); // User tapped "No"
        //       },
        //       child: const Text('No'),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         addNewMatchDay(); // User tapped "Yes"
        //       },
        //       child: const Text('Yes'),
        //     ),
        //   ],
        // );
        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Are you sure?',
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              content: Text(
                                'This will overwrite any existing matches. Do you want to proceed?',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    addNewMatchDay(); // User tapped "Yes"
                                  },
                                  child: Text(
                                    'Yes',
                                    style: GoogleFonts.poppins(
                                      color: Colors.green,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
        return; // Don't add immediately, wait for user action or snackbar timeout
      }
    }
    addNewMatchDay(); // Add new matchday directly if current is full or empty
  }

  Future<void> saveMatchdays(String originalTitle) async {
    setBusy(true);
    final user = FirebaseAuth.instance.currentUser?.uid;
    if (user == null) {
      _snackbarService.showSnackbar(
          message: 'User not logged in.', title: 'Error');
      return;
    }

    final collectionRef = FirebaseFirestore.instance
        .collection(user)
        .doc(originalTitle)
        .collection('Matches');

    await _deleteAllMatchesFromFirestore(collectionRef);

    for (int i = 0; i < matchdays.length; i++) {
      var day = matchdays[i];

      if (day['matches'].isEmpty) {
        continue;
      }

      int sequentialMatchday = i + 1;

      await collectionRef.doc('matchday$sequentialMatchday').set({
        'matchday': sequentialMatchday,
        'matches': day['matches'].map((match) {
          return {
            'matchday': sequentialMatchday,
            'player1': match['player1'],
            'player2': match['player2'],
            'scores': {'player1': 0, 'player2': 0},
          };
        }).toList(),
      });
    }
    setBusy(false);
    _snackbarService.showSnackbar(
        message: 'Schedule saved successfully!',
        title: 'Success',
        duration: const Duration(seconds: 2));
  }

  Future<void> _deleteAllMatchesFromFirestore(
      CollectionReference collectionRef) async {
    final QuerySnapshot snapshot = await collectionRef.get();
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
