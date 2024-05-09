import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/components/page_transition.dart';
import 'package:admin_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class AddAlumniPage extends StatefulWidget {
  const AddAlumniPage({super.key});

  @override
  State<AddAlumniPage> createState() => _AddAlumniPageState();
}

class _AddAlumniPageState extends State<AddAlumniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      backgroundColor: Color(0xFFE2E2E2),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Placeholder()),
          ],
        )
      ),
    );
  }
}