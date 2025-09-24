import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class StandingViewModel extends BaseViewModel {
  List<Map<String, dynamic>> standings = [];

  Future<void> fetchStandings(String title) async {
    setBusy(true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final rulesSnap = await FirebaseFirestore.instance
        .collection(user.uid)
        .doc(title)
        .collection('MatchRules')
        .doc('Rules')
        .get();

    final pointsVictory = rulesSnap['pointsVictory'] ?? 3;
    final pointsTie = rulesSnap['pointsTie'] ?? 1;
    final pointsLose = rulesSnap['pointsLose'] ?? 0;

    final matchSnapshot = await FirebaseFirestore.instance
        .collection(user.uid)
        .doc(title)
        .collection('Matches')
        .get();

    Map<String, Map<String, dynamic>> players = {};

    for (var doc in matchSnapshot.docs) {
      final data = doc.data();
      final matches = List.from(data['matches']);

      for (var match in matches) {
        final player1 = match['player1'];
        final player2 = match['player2'];
        final score1 = match['scores']['player1'] ?? 0;
        final score2 = match['scores']['player2'] ?? 0;
        final isDraw = match['draw'] ?? false;

        players.putIfAbsent(
            player1,
            () => {
                  'name': player1,
                  'played': 0,
                  'win': 0,
                  'draw': 0,
                  'loss': 0,
                  'points': 0,
                  'pf': 0,
                  'pa': 0,
                });

        players.putIfAbsent(
            player2,
            () => {
                  'name': player2,
                  'played': 0,
                  'win': 0,
                  'draw': 0,
                  'loss': 0,
                  'points': 0,
                  'pf': 0,
                  'pa': 0,
                });

        if (score1 != 0 || score2 != 0) {
          players[player1]!['played']++;
          players[player2]!['played']++;

          players[player1]!['pf'] += score1;
          players[player1]!['pa'] += score2;
          players[player2]!['pf'] += score2;
          players[player2]!['pa'] += score1;

          if (isDraw) {
            players[player1]!['draw']++;
            players[player2]!['draw']++;
            players[player1]!['points'] += pointsTie;
            players[player2]!['points'] += pointsTie;
          } else if (score1 > score2) {
            players[player1]!['win']++;
            players[player2]!['loss']++;
            players[player1]!['points'] += pointsVictory;
            players[player2]!['points'] += pointsLose;
          } else {
            players[player2]!['win']++;
            players[player1]!['loss']++;
            players[player2]!['points'] += pointsVictory;
            players[player1]!['points'] += pointsLose;
          }
        }
      }
    }

    standings = players.values.toList();

    // Sort standings with tiebreaker logic
    standings.sort((a, b) {
      if (b['points'] != a['points']) {
        return b['points'].compareTo(a['points']);
      }
      final aDiff = (a['pf'] as int) - (a['pa'] as int);
      final bDiff = (b['pf'] as int) - (b['pa'] as int);

      if (bDiff != aDiff) {
        return bDiff.compareTo(aDiff);
      }
      return (a['name'] as String).compareTo(b['name'] as String);
    });

    setBusy(false);
  }

  String buildPlayerName(String name) {
    return name;
  }
}
