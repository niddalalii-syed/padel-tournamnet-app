import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tournament_manager/app/app.router.dart';

class ExistingTournamentVM extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController tournamentNameController = TextEditingController();
  TextEditingController tournamentIdController = TextEditingController();

  TextEditingController accessPasswordController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String tournamentName = '';

  void back() {
    _navigationService.back();
  }

  void createTournament(tId, accPass, tournamentName) async {
    if (formKey.currentState!.validate()) {
      tournamentToAnotherUser(
          tId: tId,
          accPass: accPass,
          tournamentName: tournamentNameController.text);
      notifyListeners();
    } else {
      // Handle validation errors
      notifyListeners();
    }
  }

  Future<void> tournamentToAnotherUser({tId, accPass, tournamentName}) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    if (tId == user!.uid) {
      print('You cannot copy a tournament to yourself.');
      return;
    }

    // Step 1: Get the source document (main tournament document)
    final sourceDoc = await firestore.collection(tId).doc(tournamentName).get();

    print(sourceDoc.data());
    var sourceDocData = sourceDoc.data();
    print(sourceDocData!['AccessPassword']);
    print(sourceDocData['TournamentId']);
    print(sourceDocData['tournamentName']);

    if (sourceDocData['AccessPassword'] != accPass &&
        sourceDocData['TournamentId'] != tId &&
        sourceDocData['tournamentName'] != tournamentName) {
      SnackbarService().showSnackbar(
        message: 'Incorrect credenstial.',
        duration: const Duration(seconds: 2),
      );
      print('Incorrect access password.');
      return;
    }

    if (!sourceDoc.exists) {
      SnackbarService().showSnackbar(
        message: 'Source tournament does not exist.',
        duration: const Duration(seconds: 2),
      );
      print('Source tournament does not exist.');
      return;
    }

    // Step 2: Copy the fields to the target user's collection
    final sourceData = sourceDoc.data()!;
    await firestore
        .collection(user.uid) // Target user's collection
        .doc(tournamentName)
        .set(sourceData);

    // Step 3: Copy subcollections
    final subcollections = [
      'Matches',
      'MatchRules',
      'Tournament Details',
    ]; // List all subcollections you want to copy

    for (String subCol in subcollections) {
      final subColSnapshot = await firestore
          .collection(tId)
          .doc(tournamentName)
          .collection(subCol)
          .get();

      for (var doc in subColSnapshot.docs) {
        await firestore
            .collection(user.uid)
            .doc(tournamentName)
            .collection(subCol)
            .doc(doc.id)
            .set(doc.data())
            .then((_) {});
      }
    }
    SnackbarService().showSnackbar(
      message: 'Tournament added successfully!',
      duration: const Duration(seconds: 2),
    );

    NavigationService().clearStackAndShow(Routes.tournamentView);
  }

  void removeAds() {}

  void installApp() {}
}
