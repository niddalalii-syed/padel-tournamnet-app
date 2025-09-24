import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/service/userService.dart';

class TournamentOptionVM extends BaseViewModel {
  final userService = locator<Userservice>();
  final user = FirebaseAuth.instance.currentUser;

  void fetchParticipants(tournamentName) async {
    setBusy(true);
    await getParticipants(tournamentName);
    await getMatches(tournamentName);
    // log(userService.allParticipantsData.toString());
    notifyListeners();
    setBusy(false);
  }
  

  getParticipants(tournamentName) async {
    Map<String, dynamic> singleData = {};
    List dataList = [];
    userService.allParticipantsData = [];
    await FirebaseFirestore.instance
        .collection(user!.uid)
        .doc(tournamentName)
        .collection('Participant')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        singleData = value.docs[i].data();
        // log(singleData.toString());
        dataList.add(singleData);
        // log(dataList.toString());
        userService.allParticipantsData = dataList;
        notifyListeners();
      }
      log(userService.allParticipantsData.toString());
    });
  }

  getMatches(tournamentName) async {
    Map<String, dynamic> singleData = {};
    List dataList = [];
    userService.listOfMatches = [];
    await FirebaseFirestore.instance
        .collection(user!.uid)
        .doc(tournamentName)
        .collection('Matches')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        singleData = value.docs[i].data();
        // log(singleData.toString());
        dataList.add(singleData);
        // log(dataList.toString());
        userService.listOfMatches = dataList;
        notifyListeners();
      }
      log(userService.allParticipantsData.toString());
    }).onError(
      (error, stackTrace) {
        log('Error fetching matches: $error');
      },
    );
  }
}
