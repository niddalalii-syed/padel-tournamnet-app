// ignore_for_file: non_constant_identifier_names, unnecessary_type_check

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/service/userService.dart';

class ParticipantVM extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser;
  final userService = locator<Userservice>();
  int matches = 0;
  int participants = 0;
  List? allParticipants = [];
  List? participantNames = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  addParticipant(Participant) {
    participantNames!.add(Participant);
    log('Participant added: ${Participant['name']}');
    log('Current participants: $participantNames');
    log("Total participants: ${participantNames!.length}");
    allParticipants!.removeWhere((element) => element['name'] == Participant);
    userService.allParticipantsData!
        .removeWhere((element) => element['name'] == Participant['name']);
    notifyListeners();
  }

  removeParticipant(Participant, tournamentName) {
    participantNames!.remove(Participant);
    allParticipants!.add(Participant);
    // userService.allParticipantsData!.add(Participant);
    log('Participant removed: ${Participant['name']}');
    log('Remaining participants: $participantNames');
    log("Total participants: ${participantNames!.length}");
    List<Map<String, dynamic>> tempAvailableParticipants =
        List.from(userService.allParticipantsData ?? []);

    if (participantNames != null) {
      for (var tournamentParticipant in participantNames!) {
        // Ensure the element is a Map and has a 'name' key for comparison
        if (tournamentParticipant is Map<String, dynamic> &&
            tournamentParticipant.containsKey('name')) {
          tempAvailableParticipants.removeWhere((allP) =>
              allP is Map<String, dynamic> &&
              allP['name'] == tournamentParticipant['name']);
        }
      }
    }
    // Assign the filtered list to the ViewModel's allParticipants for UI display
    allParticipants = tempAvailableParticipants;

    log('Available participants (allParticipants - after filter): $allParticipants');

    userService.allParticipantsData = allParticipants;

    notifyListeners();
  }

  void init(tournamentName) {
    fetchParticipants(tournamentName);
    notifyListeners();
  }

  void fetchParticipants(tournamentName) async {
    setBusy(true);
    await getParticipants(tournamentName);
    await getTournamentParticipants(tournamentName);

    // log('Fetched participants: $participantNames');
    // log('All participants: ${userService.allParticipantsData}');

    // //check if a participant is already added remove it from allParticipantsData

    // log('Fetched participants (participantNames - in tournament): $participantNames');
    // log('All system participants (userService.allParticipantsData - before filter): ${userService.allParticipantsData}');

    // 3. Filter userService.allParticipantsData to remove participants already in 'participantNames'
    // Create a temporary list to hold the filtered data for allParticipants
    List<Map<String, dynamic>> tempAvailableParticipants =
        List.from(userService.allParticipantsData ?? []);

    if (participantNames != null) {
      for (var tournamentParticipant in participantNames!) {
        // Ensure the element is a Map and has a 'name' key for comparison
        if (tournamentParticipant is Map<String, dynamic> &&
            tournamentParticipant.containsKey('name')) {
          tempAvailableParticipants.removeWhere((allP) =>
              allP is Map<String, dynamic> &&
              allP['name'] == tournamentParticipant['name']);
        }
      }
    }
    // Assign the filtered list to the ViewModel's allParticipants for UI display
    allParticipants = tempAvailableParticipants;

    log('Available participants (allParticipants - after filter): $allParticipants');

    userService.allParticipantsData = allParticipants;

    // await getMatches(tournamentName);
    // log(userService.listOfMatches.toString());
    matches = userService.listOfMatches.length;
    // log('Matches count: $matches');
    // notifyListeners();
    // log(userService.allParticipantsData.toString());
    notifyListeners();

    setBusy(false);
  }

  getParticipants(tournamentName) async {
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
      // log(userService.allParticipantsData.toString());
    });
  }

  getTournamentParticipants(tournamentName) async {
    Map<String, dynamic> singleData = {};
    List dataList = [];
    notifyListeners();
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
        participantNames!.add(singleData);
        notifyListeners();
      }
      // log("Participant Names: $participantNames");
      // log(userService.allParticipantsData.toString());
    });
  }

  Future<void> addParticipantToDB(tournamentName) async {
    setBusy(true);
    SnackbarService().showSnackbar(
      title: 'Adding Participants',
      message: 'Please wait while participants are being added',
      duration: const Duration(seconds: 2),
    );

    await onDeleteParticipant(tournamentName);

    final user = FirebaseAuth.instance.currentUser;

    log('Adding participants to DB: $participantNames');

    for (int i = 0; i < participantNames!.length; i++) {
      final participantName = participantNames![i]['name'];
      final imageUrl = participantNames![i]['imageUrl'] ?? '';

      await firestore
          .collection(user!.uid)
          .doc(tournamentName)
          .collection('Participant')
          .doc(participantName)
          .set({
        'imageUrl': imageUrl,
        'name': participantName,
      });
    }
    SnackbarService().showSnackbar(
      title: 'Success',
      message: 'Participants added successfully!',
      duration: const Duration(seconds: 2),
    );
    setBusy(false);
    NavigationService().clearStackAndShow(Routes.tournamentView);
  }

  onDeleteParticipant(tournament) async {
    // await deleteTournament(tournament);
    await deleteSubsectionsInTournament(tournament);
    notifyListeners();
  }

  Future<void> deleteSubsectionsInTournament(String tournament) async {
    final user = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    final tournamentDoc = firestore.collection(user!.uid).doc(tournament);

    await _deleteSub(tournamentDoc, 'Participant');

    print('Matches and MatchRules subcollections deleted.');
  }

  Future<void> _deleteSub(
      DocumentReference parentDoc, String subcollectionName) async {
    final subcollection = parentDoc.collection(subcollectionName);
    final snapshots = await subcollection.get();

    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}

  // getMatches(tournamentName) async {
  //   await FirebaseFirestore.instance
  //       .collection(user!.uid)
  //       .doc(tournamentName)
  //       .collection('Matches')
  //       .get()
  //       .then((value) {
  //     matches = value.docs.length;
  //     log('Matches count: $matches');
  //     notifyListeners();
  //   });
  // }

