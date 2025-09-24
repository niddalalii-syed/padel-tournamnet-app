import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class ScoreboardVM extends BaseViewModel {
  List<Map<String, dynamic>> matchdays = [];

  Future<void> fetchMatchdays(title) async {
    setBusy(true);

    final user = FirebaseAuth.instance.currentUser?.uid;
    final collection = FirebaseFirestore.instance
        .collection(user!)
        .doc(title)
        .collection('Matches');

    final querySnapshot = await collection.get();

    matchdays = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final matches = (data['matches'] as List).map((e) {
        final matchData = e;
        return {
          'player1': matchData['player1'],
          'player2': matchData['player2'],
          'score1': matchData['scores']['player1'] ?? '-',
          'score2': matchData['scores']['player2'] ?? '-',
          'winer': matchData['winner'] ?? '',
          'loser': matchData['loser'] ?? '',
          'draw': matchData['draw'] ?? false,
          'date': matchData['date'] ?? '',
          'time': matchData['time'] ?? '',
        };
      }).toList();

      int matchdayNum = int.tryParse(doc.id.replaceAll('matchday', '')) ?? 0;

      String formattedMatchday = matchdayNum >= 1 && matchdayNum <= 9
          ? '0$matchdayNum'
          : '$matchdayNum';

      return {
        'matchday': formattedMatchday,
        'matches': matches,
      };
    }).toList();

    matchdays.sort((a, b) => a['matchday'].compareTo(b['matchday']));
    print(matchdays);

    setBusy(false);
  }
}
