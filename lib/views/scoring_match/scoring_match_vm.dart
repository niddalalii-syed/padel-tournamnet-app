import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';

class ScoringMatchVM extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController player1ScoreController = TextEditingController();
  TextEditingController player2ScoreController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  List<int> scores = [0, 0];
  String winner = '';
  String loser = '';
  bool isDraw = false;

  init(player1, player2, date, time) {
    dateController.text = date ?? '';
    timeController.text = time ?? '';
    scores = [player1, player2];
    if (scores[0] == 1 || scores[1] == 1) {
      player1ScoreController.text = scores[0].toString();
      player2ScoreController.text = scores[1].toString();
      isDraw = true;
    } else {
      if (scores[0] > 0 || scores[1] > 0) {
        player1ScoreController.text = scores[0].toString();
        player2ScoreController.text = scores[1].toString();
      }
      isDraw = false;
    }
    notifyListeners();
  }

  void setDraw(bool value) {
    isDraw = value;
    if (isDraw) {
      scores = [1, 1]; // Give both players 1 point
    } else {
      scores = [0, 0];
    }
    notifyListeners();
  }

  Future<void> uploadMatchdays(String originalTitle, int index, int matchDay,
      String player1, String player2, String tournamentName) async {
    final collection = FirebaseFirestore.instance
        .collection(user!)
        .doc(originalTitle)
        .collection('Matches')
        .doc('matchday$matchDay');

    final snapshot = await collection.get();
    final data = snapshot.data();
    if (data == null) return;

    var matches = List.from(data['matches']);

    if (!isDraw) {
      if (scores[0] > scores[1]) {
        winner = player1;
        loser = player2;
      } else if (scores[0] < scores[1]) {
        winner = player2;
        loser = player1;
      }
    }

    matches[index] = {
      'matchday': matchDay,
      'player1': player1,
      'player2': player2,
      'scores': {
        'player1': scores[0],
        'player2': scores[1],
      },
      'winner': isDraw ? '' : winner,
      'loser': isDraw ? '' : loser,
      'draw': isDraw,
      'date': dateController.text.isNotEmpty ? dateController.text : '',
      'time': timeController.text.isNotEmpty ? timeController.text : '',
    };

    await collection.update({'matches': matches}).then((value) {
      NavigationService().replaceWithScoreboardView(
        tournamentName: tournamentName,
        originalTitle: originalTitle,
        index: matchDay - 1, // important: zero-based tab index
      );
    }).catchError((error) {
      print('Failed to update matchday: $error');
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFF7F27), // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Color.fromARGB(255, 58, 57, 57), // Background color
              onSurface: Colors.white, // Text color
            ),
            dialogBackgroundColor: const Color.fromARGB(255, 58, 57, 57),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      dateController.text = formattedDate;
      notifyListeners();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFF7F27),
              onPrimary: Colors.white,
              surface: Color.fromARGB(255, 58, 57, 57),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color.fromARGB(255, 58, 57, 57),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

// Format as AM/PM
      timeController.text = DateFormat.jm().format(dateTime);

      notifyListeners();
    }
  }
}
