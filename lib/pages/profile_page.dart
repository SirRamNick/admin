import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/components/profile_helpbutton.dart';
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
    employmentStatus =
        doc['employment_status'] == true ? 'Employed' : 'Unemployed';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4695),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 10,
                        right: 15,
                        bottom: 10,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Implement Edit Button
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    label: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4695),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 10,
                        right: 18,
                        bottom: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "Alumni Profile",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("First Name: $firstName"),
      //       Text("Last Name: $lastName"),
      //       Text("Sex: $sex"),
      //       Text("Program: $program"),
      //       Text("Year Graduated: $yearGraduated"),
      //       Text("Employment Status: $employmentStatus"),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           TextButton(
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //             child: Text('Back'),
      //           ),
      //           TextButton(
      //             onPressed: () => showDialog(
      //                 context: context,
      //                 builder: (context) {
      //                   return AlertDialog(
      //                       title: Text("Confim Delete?"),
      //                       content: Text(
      //                           "Are you sure you wanted to delete '$firstName $lastName' from the database?"),
      //                       actions: [
      //                         TextButton(
      //                           child: Text("Cancel"),
      //                           onPressed: () {
      //                             Navigator.of(context).pop();
      //                           },
      //                         ),
      //                         TextButton(
      //                           child: Text("Yes"),
      //                           onPressed: () {
      //                             Navigator.of(context).pop();
      //                             alumniBase.deleteAlumnus(doc.id);
      //                             Navigator.of(context).pop();
      //                           },
      //                         ),
      //                       ]);
      //                 }),
      //             child: Text('Delete'),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: profileHelpActionButton(context),
    );
  }
}
