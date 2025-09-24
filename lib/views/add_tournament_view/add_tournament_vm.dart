import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/service/userService.dart';

class NewTournamentVM extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController tournamentNameController = TextEditingController();
  Userservice userService = locator<Userservice>();
  // CollectionReference Tournaments =
  //     FirebaseFirestore.instance.collection('Tournaments');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String tournamentName = '';

  void back() {
    _navigationService.back();
  }

  String generatePassword() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();
    return List.generate(4, (index) => chars[rand.nextInt(chars.length)])
        .join();
  }

  int generateSixDigitId() {
    final random = Random();
    return 100000 +
        random.nextInt(900000); // ensures a number between 100000–999999
  }

  void createTournament(tId, accPass, admPass) async {
    if (formKey.currentState!.validate()) {
      // Logic to create a tournament
      tournamentName = tournamentNameController.text;
      await addTournament(tournamentNameController.text, tId, accPass, admPass);
      await createTournament_(
              tournamentNameController.text, tId, accPass, admPass)
          .then((_) {
        _navigationService.clearStackAndShow(Routes.tournamentView);
      });
      // log('Creating tournament: $tournamentName');
      notifyListeners();
    } else {
      // Handle validation errors
      notifyListeners();
    }
  }

  Future<void> addTournament(tournament, tId, accPass, admPass) async {
    final user = FirebaseAuth.instance.currentUser;
    return firestore.collection(user!.uid).doc(tournament).set({
      "tournamentName": tournamentName,
      'adminUid': user.uid,
      "TournamentId": user.uid,
      "AccessPassword": accPass,
      "AdministratorPassword": admPass,
    });
  }

  Future<void> createTournament_(tournament, tId, accPass, admPass) async {
    final user = FirebaseAuth.instance.currentUser;
    return firestore
        .collection(user!.uid)
        .doc(tournament)
        .collection('Tournament Details')
        .doc('Details')
        .set({
      'adminUid': user.uid,
      "tournamentName": tournamentName,
      "createdAt": DateTime.now(),
      "LastUpdated": DateTime.now(),
      "TournamentId": user.uid,
      "AccessPassword": accPass,
      "AdministratorPassword": admPass,
    });
  }

  void removeAds() {}

  void installApp() {}
}
