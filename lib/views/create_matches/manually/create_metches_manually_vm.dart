// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:tournament_manager/app/app.locator.dart';
// import 'package:tournament_manager/service/userService.dart';

// class CreateMatchesManuallyVM extends BaseViewModel {
//   final _snackbarService = locator<SnackbarService>();
//   final Userservice userService = locator<Userservice>();

//   List<String> selectedPlayers = [];
//   List<String> players = [];
//   List<Map<String, dynamic>> matchdays = [];

//   TabController? tabController;
//   TickerProvider? vsync;

//   void init(List<String> allPlayers, TickerProvider ticker) {
//     userService.allPlayers = allPlayers;
//     vsync = ticker;
//     _addNewMatchday(); // Add initial matchday
//   }

//   void _initTabController() {
//     if (vsync != null) {
//       tabController = TabController(length: matchdays.length, vsync: vsync!);
//       tabController!.addListener(() {
//         if (!tabController!.indexIsChanging) {
//           updateTabIndex(tabController!.index);
//         }
//       });
//       notifyListeners();
//     }
//   }

//   Future<void> saveMatchdays(String originalTitle) async {
//     // Removed all editable flag manipulation and problematic matchday additions/removals
//     final user = FirebaseAuth.instance.currentUser?.uid;

//     final collection = FirebaseFirestore.instance
//         .collection(user!)
//         .doc(originalTitle)
//         .collection('Matches');

//     for (int i = 0; i < matchdays.length; i++) {
//       var day = matchdays[i];

//       // Sequential matchday number for Firebase document ID
//       int sequentialMatchday = i + 1;

//       await collection.doc('matchday$sequentialMatchday').set({
//         'matchday': sequentialMatchday,
//         'matches': day['matches'].map((match) {
//           return {
//             'match': [
//               {
//                 'matchday': sequentialMatchday,
//                 'player1': match['player1'],
//                 'player2': match['player2'],
//                 'scores': match['scores']
//               },
//             ]
//           };
//         }).toList(),
//       });
//     }
//     _snackbarService.showSnackbar(
//         message: 'Schedule saved successfully!',
//         title: 'Success',
//         duration: const Duration(seconds: 2));
//   }

//   void _addNewMatchday() {
//     // No longer setting previous matchdays to non-editable
//     matchdays.add({
//       'matchday': matchdays.length + 1,
//       'matches': [],
//       'editable': true, // This flag is now conceptually always true
//     });

//     selectedPlayers.clear();
//     // For a newly added matchday, all players are initially available
//     players = List.from(userService.allPlayers);

//     _initTabController();
//     if (matchdays.isNotEmpty) {
//       tabController?.animateTo(matchdays.length - 1);
//     }
//     notifyListeners();
//   }

//   Future<void> addNewMatchDayWithConfirmation(BuildContext context) async {
//     // Removed the entire dialog box logic as per requirement.
//     // New matchday is now added directly.
//     _addNewMatchday();
//   }

//   void updateTabIndex(int index) {
//     // Logic to update available players based on the selected matchday
//     final matchday = matchdays[index];
//     selectedPlayers.clear();
//     players = _remainingPlayers(matchday['matches']);
//     notifyListeners();
//   }

//   List<String> _remainingPlayers(List<dynamic> matches) {
//     final used = matches.expand((m) => [m['player1'], m['player2']]).toSet();
//     return userService.allPlayers.where((p) => !used.contains(p)).toList();
//   }

//   void selectPlayer(String playerName) {
//     // Removed editable check
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
//     final limit = matchesLimit(userService.allPlayers.length);

//     if (currentMatches >= limit) {
//       _snackbarService.showSnackbar(
//           message:
//               'Match limit reached for this day. Cannot add more matches.');
//       // Return selected players to available list if match couldn't be added
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
//       // Return selected players to available list if duplicate
//       players.addAll(selectedPlayers);
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
//     // Removed editable check
//     if (selectedPlayers.isNotEmpty) {
//       _snackbarService.showSnackbar(
//           message:
//               'Complete current selection first before editing another match.');
//       return;
//     }

//     final match = matchdays[tabController!.index]['matches'][index];
//     deleteMatch(index); // Delete the match to put players back into 'available'
//     selectedPlayers = [match['player1']]; // Set first player for re-selection
//     notifyListeners();
//   }

//   void deleteMatch(int index) {
//     // Removed editable check
//     final match = matchdays[tabController!.index]['matches'][index];
//     matchdays[tabController!.index]['matches'].removeAt(index);
//     players.addAll([
//       match['player1'],
//       match['player2']
//     ]); // Add players back to available list
//     notifyListeners();
//   }

//   // Renamed from isCurrentMatchdayEditable for clarity.
//   // It now only checks if the current matchday has capacity for more matches.
//   bool canAddMoreMatchesToCurrentDay() {
//     if (matchdays.isEmpty ||
//         tabController == null ||
//         tabController!.index >= matchdays.length) {
//       return false;
//     }
//     final currentMatchday = matchdays[tabController!.index];
//     return currentMatchday['matches'].length <
//         matchesLimit(userService.allPlayers.length);
//   }

//   int matchesLimit(int totalPlayers) {
//     if (totalPlayers < 4) return 1;
//     if (totalPlayers <= 5) return 2;
//     if (totalPlayers <= 7) return 3;
//     if (totalPlayers <= 9) return 4;
//     return 5;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/service/userService.dart';

class CreateMatchesManuallyVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final Userservice userService = locator<Userservice>();

  List<String> selectedPlayers = [];
  List<String> players = [];
  List<Map<String, dynamic>> matchdays = [];

  TabController? tabController;
  TickerProvider? vsync;

  // Track the current tab index for accurate player availability
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void init(List<String> allPlayers, TickerProvider ticker) {
    userService.allPlayers = allPlayers;
    vsync = ticker;
    _addNewMatchday(); // Add initial matchday
  }

  void _initTabController() {
    if (vsync != null) {
      // Dispose old controller if exists to prevent memory leaks and issues
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
    // Recalculate available players for the newly selected matchday
    final matchday = matchdays[_currentTabIndex];
    selectedPlayers.clear();
    players = _remainingPlayers(matchday['matches']);
    notifyListeners();
  }

  Future<void> saveMatchdays(String originalTitle) async {
    setBusy(true); // Start busy state
    final user = FirebaseAuth.instance.currentUser?.uid;

    if (user == null) {
      _snackbarService.showSnackbar(
          message: 'User not logged in. Cannot save schedule.',
          title: 'Error',
          duration: const Duration(seconds: 2));
      setBusy(false); // End busy state
      return;
    }

    // Validate that all matchdays have at least one match
    for (var i = 0; i < matchdays.length; i++) {
      if ((matchdays[i]['matches'] as List).isEmpty) {
        setBusy(false); // End busy state
        _snackbarService.showSnackbar(
            message:
                'Matchday ${i + 1} has no matches. Please add at least one match per day',
            title: 'Error',
            duration: const Duration(seconds: 4));
        return;
      }
    }

    try {
      final collection = FirebaseFirestore.instance
          .collection(user)
          .doc(originalTitle)
          .collection('Matches');

      // Delete existing matches for this tournament to avoid duplicates/stale data
      // This is crucial if you're overwriting the entire schedule
      final existingDocs = await collection.get();
      for (var doc in existingDocs.docs) {
        await doc.reference.delete();
      }

      for (int i = 0; i < matchdays.length; i++) {
        var day = matchdays[i];

        int sequentialMatchday = i + 1; // Matchday numbers start from 1

        await collection.doc('matchday$sequentialMatchday').set({
          'matchday': sequentialMatchday,
          'startDate': '',
          'endDate': '',
          'matches': (day['matches'] as List).map((match) {
            return {
              'matchday':
                  sequentialMatchday, // Ensure matchday is within the nested match data
              'player1': match['player1'],
              'player2': match['player2'],
              'scores': match['scores'] ??
                  {'player1': 0, 'player2': 0}, // Default scores if null
              // Add other necessary fields if they exist in your match structure:
            };
          }).toList(),
        });
      }
      _snackbarService.showSnackbar(
          message: 'Schedule saved successfully!',
          title: 'Success',
          duration: const Duration(seconds: 2));
    } catch (e) {
      _snackbarService.showSnackbar(
          message: 'Error saving schedule: $e',
          title: 'Error',
          duration: const Duration(seconds: 5));
      print('Error saving matchdays: $e');
    } finally {
      setBusy(false); // End busy state
    }
  }

  void _addNewMatchday() {
    matchdays.add({
      'matchday': matchdays.length + 1,
      'matches': [],
      'editable': true, // This flag is now conceptually always true
    });

    selectedPlayers.clear();
    // For a newly added matchday, all players are initially available
    players = List.from(userService.allPlayers);

    _initTabController();
    if (matchdays.isNotEmpty) {
      // Ensure the tab controller is properly initialized before animating
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tabController?.animateTo(matchdays.length - 1);
        _currentTabIndex =
            matchdays.length - 1; // Update current index to the new tab
        notifyListeners(); // Notify again to ensure UI updates based on currentTabIndex
      });
    }
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
        //         _addNewMatchday(); // User tapped "Yes"
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
                'Current matchday is not full. Add more matches or proceed?',
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
                    _addNewMatchday(); // User tapped "Yes"
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
    _addNewMatchday(); // Add new matchday directly if current is full or empty
  }

  List<String> _remainingPlayers(List<dynamic> matches) {
    final used = matches.expand((m) => [m['player1'], m['player2']]).toSet();
    return userService.allPlayers.where((p) => !used.contains(p)).toList();
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
    final matchday = matchdays[_currentTabIndex]; // Use _currentTabIndex
    final currentMatches = (matchday['matches'] as List).length; // Cast to List
    final limit = matchesLimit(userService.allPlayers.length);

    if (currentMatches >= limit) {
      _snackbarService.showSnackbar(
          message:
              'Match limit reached for this day. Cannot add more matches.');
      // Return selected players to available list if match couldn't be added
      players.addAll(selectedPlayers);
      selectedPlayers.clear();
      notifyListeners();
      return;
    }

    final p1 = selectedPlayers[0];
    final p2 = selectedPlayers[1];

    bool isDuplicate = (matchday['matches'] as List).any((m) => // Cast to List
        (m['player1'] == p1 && m['player2'] == p2) ||
        (m['player1'] == p2 && m['player2'] == p1));

    if (isDuplicate) {
      _snackbarService.showSnackbar(message: 'This match already exists.');
      // Return selected players to available list if duplicate
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

    print(matchday['matches']);

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

    // Use _currentTabIndex to get the correct matchday
    final match = matchdays[_currentTabIndex]['matches'][index];
    deleteMatch(index); // Delete the match to put players back into 'available'
    selectedPlayers = [match['player1']]; // Set first player for re-selection
    notifyListeners();
  }

  void deleteMatch(int index) {
    // Use _currentTabIndex to get the correct matchday
    final match = matchdays[_currentTabIndex]['matches'][index];
    (matchdays[_currentTabIndex]['matches'] as List)
        .removeAt(index); // Cast to List
    players.addAll([
      match['player1'],
      match['player2']
    ]); // Add players back to available list
    notifyListeners();
  }

  bool canAddMoreMatchesToCurrentDay() {
    if (matchdays.isEmpty || _currentTabIndex >= matchdays.length) {
      return false;
    }
    final currentMatchday = matchdays[_currentTabIndex];
    return (currentMatchday['matches'] as List).length < // Cast to List
        matchesLimit(userService.allPlayers.length);
  }

  // --- New `matchesLimit` Logic ---
  int matchesLimit(int totalPlayers) {
    if (totalPlayers < 2)
      return 0; // Cannot have matches with less than 2 players
    if (totalPlayers == 2) return 1; // Only 1 match possible (A vs B)

    if (totalPlayers <= 4) {
      // 2, 3, 4 players
      return (totalPlayers / 2).ceil(); // 2p: 1, 3p: 2, 4p: 2
    } else if (totalPlayers <= 8) {
      // 5, 6, 7, 8 players
      return (totalPlayers / 2).ceil(); // 5p: 3, 6p: 3, 7p: 4, 8p: 4
    } else if (totalPlayers <= 12) {
      // 9, 10, 11, 12 players
      return (totalPlayers / 2).ceil(); // 9p: 5, 10p: 5, 11p: 6, 12p: 6
    } else if (totalPlayers <= 16) {
      // 13, 14, 15, 16 players
      return (totalPlayers / 2).ceil(); // 13p: 7, 14p: 7, 15p: 8, 16p: 8
    } else {
      // 17-20 players (or more if your range extends)
      return (totalPlayers / 2).ceil(); // Max 10 matches for 20 players
    }
  }
}
