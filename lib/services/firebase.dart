import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference alumni =
      FirebaseFirestore.instance.collection('alumni');

  Future addAlumnus(
      String firstName, String lastName, String program, int yearGraduated, String batch) {
    return alumni.add({
      'first_name': firstName,
      'last_name': lastName,
      'program': program,
      'year_graduated': yearGraduated,
      'batch': batch,
    });
  }

  Stream get displayAlumni => alumni.snapshots();
}
