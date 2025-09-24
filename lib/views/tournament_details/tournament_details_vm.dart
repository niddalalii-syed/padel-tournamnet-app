import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/service/userService.dart';
import 'package:url_launcher/url_launcher.dart';

class TournamentDetailsVM extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> singleData = {};
  final tournamentFormKey = GlobalKey<FormState>();
  TextEditingController tournamentNameController = TextEditingController();
  late String formattedCreatedDate = '';
  late String formattedUpdateDate = '';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isMatches = false;

  Userservice userService = locator<Userservice>();

  init(tournamentName) {
    get(tournamentName);
    getTournament(tournamentName);
    notifyListeners();
  }

  get(tournamentName) async {
    await getTournamentData(tournamentName);
    tournamentNameController.text = singleData['tournamentName'] ?? '';
    DateTime dateTimeCreated = singleData['createdAt'].toDate();
    DateTime dateTimeUpdated = singleData['LastUpdated'].toDate();

// Format the DateTime
    formattedCreatedDate =
        DateFormat('MMM d, yyyy h:mm a').format(dateTimeCreated);
    formattedUpdateDate =
        DateFormat('MMM d, yyyy h:mm a').format(dateTimeUpdated);

    log(singleData.toString());
  }

  getTournamentData(tournamentName) async {
    await FirebaseFirestore.instance
        .collection(user!.uid)
        .doc(tournamentName)
        .collection('Tournament Details')
        .doc('Details')
        .get()
        .then((value) {
      singleData = value.data()!;
      notifyListeners();
    });
  }

  getTournament(tournamentName) async {
    await FirebaseFirestore.instance
        .collection(user!.uid)
        .doc(tournamentName)
        .collection('Matches')
        .get()
        .then((value) {
      // singleData = value.data()!;
      if (value.docs.isNotEmpty) {
        isMatches = true;
        notifyListeners();
        log("Matches found: ${value.docs.length}");
      } else {
        isMatches = false;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  onSave(tournamentName, index) async {
    SnackbarService().showSnackbar(
      message: "Saving Data",
      duration: const Duration(seconds: 2),
    );
    log(userService.allTournamentsData![index].toString());
    userService.allTournamentsData![index]['tournamentName'] =
        tournamentNameController.text;
    userService.allTournamentsData![index]['LastUpdated'] = Timestamp.now();
    notifyListeners();
    log(userService.allTournamentsData![index].toString());

    await updateTournament(tournamentName);
    // NavigationService().replaceWithTournamentDetailsView(
    //     tournamentName: tournamentName, index: index);

    NavigationService().clearStackAndShow(Routes.tournamentView);
  }

  Future<void> updateTournament(tournament) async {
    final user = FirebaseAuth.instance.currentUser;
    return firestore
        .collection(user!.uid)
        .doc(tournament)
        .collection('Tournament Details')
        .doc('Details')
        .update({
      "tournamentName": tournamentNameController.text,
      "LastUpdated": DateTime.now(),
    });
  }

  onDelete(tournament) async {
    SnackbarService().showSnackbar(
      message: "Deleting Tournament",
      duration: const Duration(seconds: 2),
    );
    // await deleteTournament(tournament);
    await deleteTournamentMatches(tournament);
    userService.allTournamentsData!
        .removeWhere((element) => element['tournamentName'] == tournament);
    notifyListeners();
    NavigationService().clearStackAndShow(Routes.tournamentView);
  }

  Future<void> deleteTournamentMatches(String tournament) async {
    final user = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    final tournamentDoc = firestore.collection(user!.uid).doc(tournament);

    // Delete subcollections manually
    await _deleteSubcollection(tournamentDoc, 'Matches');
    await _deleteSubcollection(tournamentDoc, 'MatchRules');
    await _deleteSubcollection(tournamentDoc, 'Participant');
    await _deleteSubcollection(tournamentDoc, 'Tournament Details');

    // Then delete the tournament document
    await tournamentDoc.delete();
    print('Tournament and all subcollections deleted.');
  }

  Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode
          .platformDefault, // Opens in default browser or in-app if available
      // mode: LaunchMode.inAppWebView, // Force opening in an in-app WebView
      // mode: LaunchMode.externalApplication, // Force opening in an external browser app
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _deleteSubcollection(
      DocumentReference parentDoc, String subcollectionName) async {
    final subcollection = parentDoc.collection(subcollectionName);
    final snapshots = await subcollection.get();

    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  onDeleteMatchesandMatchRules(tournament) async {
    SnackbarService().showSnackbar(
      message: "Deleting Tournament",
      duration: const Duration(seconds: 2),
    );
    // await deleteTournament(tournament);
    await deleteSubsectionsInTournament(tournament);
    userService.allTournamentsData!
        .removeWhere((element) => element['tournamentName'] == tournament);
    notifyListeners();
    NavigationService().clearStackAndShow(Routes.tournamentView);
  }

  Future<void> deleteSubsectionsInTournament(String tournament) async {
    final user = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    final tournamentDoc = firestore.collection(user!.uid).doc(tournament);

    await _deleteSub(tournamentDoc, 'Matches');
    await _deleteSub(tournamentDoc, 'MatchRules');

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
