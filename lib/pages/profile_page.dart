import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/components/admin_floatingbutton.dart';
import 'package:admin_app/components/page_transition.dart';
import 'package:admin_app/pages/home_page.dart';
import 'package:admin_app/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final DocumentSnapshot document;

  const ProfilePage({
    super.key,
    required this.document,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirestoreService alumniBase = FirestoreService();

  late final DocumentSnapshot doc;
  late final String firstName;
  late final String lastName;
  late final String sex;
  late final String program;
  late final int yearGraduated;
  late final String employmentStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doc = widget.document;
    firstName = doc['first_name'];
    lastName = doc['last_name'];
    sex = doc['sex'];
    program = doc['program'];
    yearGraduated = doc['year_graduated'];
    employmentStatus = doc['employment_status'] == true ? 'Employed' : 'Unemployed';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("First Name: $firstName"),
            Text("Last Name: $lastName"),
            Text("Sex: $sex"),
            Text("Program: $program"),
            Text("Year Graduated: $yearGraduated"),
            Text("Employment Status: $employmentStatus"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    instantTransitionTo(HomePage())
                  ),
                  child: Text('Back'),
                ),
                TextButton(
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Confim Delete?"),
                        content: Text("Are you sure you wanted to delete '$firstName $lastName' from the database?"),
                        actions: [
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              alumniBase.deleteAlumnus(doc.id);
                              Navigator.pushReplacement(
                                context,
                                instantTransitionTo(HomePage())
                              );
                            },
                          ),
                        ]
                      );
                    }
                  ),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: adminFloatingActionButton(context),
    );
  }
}
