import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
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
  late final String middleName;
  late final String email;
  late final String sex;
  late final String program;
  late final int yearGraduated;
  late final String employmentStatus;
  late final String occupation;
  late final String dateOfBirth;
  late final String question1;
  late final String question2;
  late final String question3;
  late final String question4;
  late final String question5;
  late final String question6;

  @override
  void initState() {
    super.initState();
    doc = widget.document;
    firstName = doc['first_name'];
    lastName = doc['last_name'];
    middleName = doc['middle_name'];
    email = doc['email'];
    sex = doc['sex'];
    program = doc['program'];
    yearGraduated = doc['year_graduated'];
    employmentStatus = doc['employment_status'];
    occupation = doc['occupation'];
    dateOfBirth = doc['date_of_birth'];
    question1 = doc['question_1'];
    question2 = doc['question_2'];
    question3 = doc['question_3'];
    question4 = doc['question_4'];
    question5 = doc['question_5'];
    question6 = doc['question_6'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
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
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Alumni Profile",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "First Name",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        firstName,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Middle Name",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        middleName,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Last Name",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        lastName,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Sex",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        sex,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Date of Birth",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        dateOfBirth,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Email",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        email,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Year Graduated",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "$yearGraduated",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Program",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        program,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Employment",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "$employmentStatus",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Are you satisfied with your current status?",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        question1,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Were you employed within the year of your graduation?",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        question2,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "How relevant was the program to your job post-graduation?",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        question3,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Did the program help in applying for your current occupation?",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        question4,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Did the program provide the necessary skills needed for your current job?",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        question5,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "What were the necessary skills you acquired from the program needed for your current job?",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        question6,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: profileHelpActionButton(context),
    );
  }
}
