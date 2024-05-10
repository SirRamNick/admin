import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference alumni =
      FirebaseFirestore.instance.collection('alumni');

  // Create
  Future addAlumnus(String firstName, String lastName, String program,
      int yearGraduated, String batch, String sex, bool employmentStatus) {
    setSearchParam(String firstName, String lastName) {
      final String name = '$firstName $lastName';
      List<String> caseSearchList = [];
      String temp = '';

      for (int i = 0; i < name.length; i++) {
        temp += name[i];
        caseSearchList.add(temp.toLowerCase());
      }
      return caseSearchList;
    }

    return alumni.add({
      'first_name': firstName,
      'last_name': lastName,
      'sex': sex,
      'program': program,
      'year_graduated': yearGraduated,
      'batch': batch,
      'employment_status': employmentStatus,
      'searchable_name': setSearchParam(firstName, lastName),
    });
  }

  // Delete
  Future deleteAlumnus(String? docID) => alumni.doc(docID).delete();
}
