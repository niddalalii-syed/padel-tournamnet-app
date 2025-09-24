// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/service/userService.dart';

class AddtoAllParticipantVM extends BaseViewModel {
  XFile? file;
  String? url = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController participantNameController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userService = locator<Userservice>();

  onSave() async {
    if (formKey.currentState!.validate()) {
      // print('Participant Name: ${participantNameController.text}');
      // print('Image URL: $url');
      await addParticipant();
      NavigationService().replaceWithAllParticipantView();
    } else {
      SnackbarService().showSnackbar(
        message: 'Please fill all fields and select an image',
        title: 'Error',
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> addParticipant() async {
    final user = FirebaseAuth.instance.currentUser;
    return firestore
        .collection(user!.uid)
        .doc('AllParticipants')
        .collection('Participants')
        .doc(participantNameController.text)
        .set(
      {
        'imageUrl': url,
        'name': participantNameController.text,
      },
    );
  }
}
