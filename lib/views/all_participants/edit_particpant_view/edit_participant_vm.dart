import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class EditAllParticipantVM extends BaseViewModel {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get participant details from Firestore
  Future<Map<String, dynamic>> getParticipantDetails(
      String participantName) async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnapshot = await firestore
        .collection(user!.uid)
        .doc('AllParticipants')
        .collection('Participants')
        .doc(participantName)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception('Participant not found');
    }
  }

  // Delete the participant from Firestore
  Future<void> deleteParticipant(String participantName) async {
    final user = FirebaseAuth.instance.currentUser;
    await firestore
        .collection(user!.uid)
        .doc('AllParticipants')
        .collection('Participants')
        .doc(participantName)
        .delete();
  }
}
