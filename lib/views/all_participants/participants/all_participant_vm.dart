import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/service/userService.dart';

class AllParticipantVM extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser;
  final userService = locator<Userservice>();
  int participants = 0;

  void fetchParticipants() async {
    setBusy(true);
    await getParticipants();
    notifyListeners();
    setBusy(false);
  }

  getParticipants() async {
    Map<String, dynamic> singleData = {};
    List dataList = [];
    userService.allParticipantsData = [];
    notifyListeners();
    await FirebaseFirestore.instance
        .collection(user!.uid)
        .doc("AllParticipants")
        .collection('Participants')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        participants++;
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
}
