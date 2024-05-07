import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String program;
  final int yearGraduated;
  const ProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.program,
    required this.yearGraduated,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final String firstName;
  late final String lastName;
  late final String program;
  late final int yearGraduated;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = widget.firstName;
    lastName = widget.lastName;
    program = widget.program;
    yearGraduated = widget.yearGraduated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminAppBar,
      drawer: adminDrawer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(firstName),
            Text(lastName),
            Text(program),
            Text('$yearGraduated'),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              ),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
