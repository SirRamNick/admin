import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

FloatingActionButton homeFloatingActionButton(BuildContext context) => FloatingActionButton.extended(
  backgroundColor: Color(0xFFFFD22F),
  foregroundColor: Colors.black,
  label: Text("Help"),
  icon: Icon(Icons.help),
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ListTile(
                title: Text("Title"),
                subtitle: Text("Subtitle"),
              )
            ],
          ),
        ),
      ),
    );
  },
);