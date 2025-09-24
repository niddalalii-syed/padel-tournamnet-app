import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/service/userService.dart';

class TournamentVM extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser;
  final userService = locator<Userservice>();

  bool showMenu = false;

  onTap() {
    showMenu = !showMenu;
    notifyListeners();
  }

  loadData() async {
    userService.allTournamentsName = [];
    userService.allTournamentsData = [];
    await getTournamentName();
    await getTournamentData();
    notifyListeners();
  }

  fetchData() {
    setBusy(true);
    rebuildUi();
    loadData();
    Future.delayed(const Duration(seconds: 4), () {
      notifyListeners();
    });
    setBusy(false);
  }

  getTournamentName() async {
    Map<String, dynamic> singleData = {};
    List dataList = [];
    await FirebaseFirestore.instance.collection(user!.uid).get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        singleData = value.docs[i].data();
        log(singleData.toString());
        dataList.add(singleData);
        log(dataList.toString());
        userService.allTournamentsName = dataList;
        notifyListeners();
      }
    });
    log(userService.allTournamentsName.toString());
  }

  getTournamentData() async {
    Map<String, dynamic> singleData = {};
    List dataList = [];

    if (userService.allTournamentsName == null ||
        userService.allTournamentsName!.isEmpty) {
      log('No tournaments found');
      return;
    } else {
      for (int i = 0; i < userService.allTournamentsName!.length; i++) {
        print(userService.allTournamentsName![i]['tournamentName']);
        await FirebaseFirestore.instance
            .collection(user!.uid)
            .doc(userService.allTournamentsName![i]['tournamentName'])
            .collection('Tournament Details')
            .doc('Details')
            .get()
            .then((value) {
          log(value.data().toString());
          singleData = value.data()!;
          dataList.add(singleData);
          log(dataList.toString());
          userService.allTournamentsData = dataList;
          notifyListeners();
        });
      }
    }
  }

  String getElapsedFromTimestamp(Timestamp timestamp) {
    DateTime createdAt = timestamp.toDate();
    Duration difference = DateTime.now().difference(createdAt);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} second${difference.inSeconds == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }
}
