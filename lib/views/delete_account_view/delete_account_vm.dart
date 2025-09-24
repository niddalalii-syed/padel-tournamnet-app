// ignore_for_file: annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';

class DeleteUserVM extends BaseViewModel {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final uidController = TextEditingController(text: 'ABC123XYZ');
  final reasonController = TextEditingController();

  init() {
    nameController.text = FirebaseAuth.instance.currentUser?.displayName ?? '';
    emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
    uidController.text = FirebaseAuth.instance.currentUser?.uid ?? '';
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    setBusy(true);
    final prefs = await SharedPreferences.getInstance();

    final idToken = await prefs.getString('idToken');
    final accessToken = await prefs.getString('accessToken');
    print('?idToken=$idToken&accessToken=$accessToken');
    await _signInWithGoogleTokens(idToken!, accessToken!);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No user is currently logged in.');
      }

      SnackbarService().showSnackbar(
        title: 'Deleting Account',
        message: 'Please wait while we delete your account.',
        duration: const Duration(seconds: 2),
      );

      await deleteAllParticipants(user.uid);
      await deleteParentCollection(user.uid);

      await user.delete();
      await FirebaseAuth.instance.signOut();
      prefs.remove('googleUserId');
      prefs.setBool("isloggedIn", false);
      prefs.remove('idToken');
      prefs.remove('accessToken');
      SnackbarService().showSnackbar(
        title: 'Success',
        message: 'Your account has been deleted successfully.',
        duration: const Duration(seconds: 2),
      );
      NavigationService().clearStackAndShow(Routes.loginView);
    } catch (e) {
      print('Error deleting account: $e');
    } finally {
      setBusy(false);

      // close WebView
    }
  }

  Future<void> deleteParentCollection(String parentCollectionName) async {
    final firestore = FirebaseFirestore.instance;
    final parentCollection = firestore.collection(parentCollectionName);

    print('🔴 Deleting all documents in $parentCollectionName...');

    try {
      final querySnapshot = await parentCollection.get();
      print('Found ${querySnapshot.docs} documents in $parentCollectionName');

      for (final doc in querySnapshot.docs) {
        final docId = doc.id;
        print('🗑️ Processing document: $docId');

        if (docId == 'AllParticipants') {
          // Special case: delete only Participant subcollection inside AllParticipants
          await _deleteSubcollection(doc.reference, 'Participants');
          print('✅ Deleted AllParticipants → Participant collection');

          // Delete AllParticipants document itself
          await doc.reference.delete();
          print('✅ Deleted document: $docId');
        } else {
          // Regular Tournament documents: delete their 4 subcollections
          final subcollections = [
            'Matches',
            'MatchRules',
            'Participant',
            'Tournament Details'
          ];

          for (final subcollectionName in subcollections) {
            await _deleteSubcollection(doc.reference, subcollectionName);
          }
          print('✅ Deleted all subcollections for $docId');

          // Delete the Tournament document itself
          await doc.reference.delete();
          print('✅ Deleted document: $docId');
        }
      }

      print('🎉 Entire $parentCollectionName cleaned successfully.');
    } catch (e) {
      print('❌ Error deleting parent collection: $e');
    }
  }

  Future<void> _deleteSubcollection(
      DocumentReference docRef, String subcollectionName) async {
    final subcollection = docRef.collection(subcollectionName);
    final snapshot = await subcollection.get();

    if (snapshot.docs.isEmpty) {
      print('⚠ No documents found in $subcollectionName');
      return;
    }

    for (final subDoc in snapshot.docs) {
      print('🗑️ Deleting ${subDoc.id} from $subcollectionName');
      await subDoc.reference.delete();
    }

    print('✅ Deleted all documents in $subcollectionName');
  }

  Future<void> deleteAllParticipants(String uid) async {
    final firestore = FirebaseFirestore.instance;
    final allParticipantsDoc = firestore.collection(uid).doc('AllParticipants');

    print('🔴 Deleting Participants subcollection...');
    await _deleteSubcollection(allParticipantsDoc, 'Participants');

    print('🗑️ Deleting AllParticipants document...');
    try {
      await allParticipantsDoc.delete();
      print('✅ Deleted AllParticipants document (placeholder or not)');
    } catch (e) {
      print('❌ Error deleting AllParticipants: $e');
    }
  }

  Future<void> _signInWithGoogleTokens(
      String idToken, String accessToken) async {
    try {
      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('✅ Firebase sign-in successful: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase sign-in failed: ${e.message}');
      SnackbarService().showSnackbar(
        title: 'Error',
        message: 'Failed to sign in with Google tokens: ${e.message}',
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('❌ Unexpected error during sign-in: $e');
      SnackbarService().showSnackbar(
        title: 'Error',
        message: 'Unexpected error during sign-in: $e',
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    uidController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}
