import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/pages/profile_page.dart';
import 'package:admin_app/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirestoreService alumniBase = FirestoreService();

  void openDialogBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      appBar: adminAppBar,
      drawer: adminDrawer,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search alumni",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1D4695),
                          width: 2,
                        ),
                      ),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  child: Icon(
                    Icons.search,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1D4695),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: 25,
                      )),
                )
              ],
            ),
            SizedBox(height: 15),
            // Add Alumni & Sorting Menus
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Add Alumni",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () => openDialogBox(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1D4695),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.fromLTRB(15, 15, 20, 15),
                  ),
                )
              ],
            ),
            SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: StreamBuilder(
                stream: alumniBase.displayAlumni,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List alumniList = snapshot.data.docs;

                    return DataTable(
                      columns: [
                        DataColumn(
                          label: Expanded(
                            child: Text("Name"),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text("Program"),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text("Year Graduated"),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text("Sex"),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text("Employment Status"),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Text("ALIMAN, Rovic Xavier")),
                            DataCell(Text("BSCS")),
                            DataCell(Text("2019-2023")),
                            DataCell(Text("M")),
                            DataCell(Text("Unemployed")),
                          ],
                        ),
                      ]
                    );
                  }
                  else {
                    return Center(
                      child: Text("Loading..."),
                    );
                  }
                },
              ),
            )

            // List of Alumni
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 15),
            //   child: Container(
            //     width: screenWidth,
            //     color: Colors.white,
            //     child: DataTable(
            //       columns: [
            //         DataColumn(
            //           label: Expanded(
            //             child: Text("Name"),
            //           ),
            //         ),
            //         DataColumn(
            //           label: Expanded(
            //             child: Text("Program"),
            //           ),
            //         ),
            //         DataColumn(
            //           label: Expanded(
            //             child: Text("Year Graduated"),
            //           ),
            //         ),
            //         DataColumn(
            //           label: Expanded(
            //             child: Text("Sex"),
            //           ),
            //         ),
            //         DataColumn(
            //           label: Expanded(
            //             child: Text("Employment Status"),
            //           ),
            //         ),
            //       ],
            //       rows: [
            //         DataRow(
            //           cells: [
            //             DataCell(Text("ALIMAN, Rovic Xavier")),
            //             DataCell(Text("BSCS")),
            //             DataCell(Text("2019-2023")),
            //             DataCell(Text("M")),
            //             DataCell(Text("Unemployed")),
            //           ]
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(Text("TIONGSON, Rame Nicholas")),
            //             DataCell(Text("BSCS")),
            //             DataCell(Text("2019-2024")),
            //             DataCell(Text("M")),
            //             DataCell(Text("Employed")),
            //           ]
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(Text("TIONGSON, Rame Nicholas")),
            //             DataCell(Text("BSCS")),
            //             DataCell(Text("2019-2024")),
            //             DataCell(Text("M")),
            //             DataCell(Text("Employed")),
            //           ]
            //         ),
            //         DataRow(
            //           cells: [
            //             DataCell(Text("TIONGSON, Rame Nicholas")),
            //             DataCell(Text("BSCS")),
            //             DataCell(Text("2019-2024")),
            //             DataCell(Text("M")),
            //             DataCell(Text("Employed")),
            //           ]
            //         ),
            //       ],
            //     ),
            //   ),
            // ),


            //   child: StreamBuilder(
            //   stream: alumniBase.displayAlumni,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       List alumniList = snapshot.data.docs;
            //       return ListView.builder(
            //         padding: EdgeInsets.symmetric(vertical: 15),
            //         itemCount: alumniList.length,
            //         itemBuilder: (context, index) {
            //           DocumentSnapshot doc = alumniList[index];
            //           return Card(
            //             child: InkWell(
            //               child: ListTile(
            //                 title: Row(
            //                   children: [
            //                     Text("${doc['last_name'].toUpperCase()}, ${doc['first_name']}"),
            //                     Text(doc['program']),
            //                     Text(doc['batch']),
            //                     Text(doc['sex']),
            //                     Text(doc['employment_status'] ? "Employed" : "Unemployed"),
            //                   ],
            //                 ),
            //                 tileColor: Colors.white,
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(10),
            //                 ),
            //               ),
            //               onTap: () {
            //                 Navigator.pushReplacement(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => ProfilePage(
            //                               firstName: doc['first_name'],
            //                               lastName: doc['last_name'],
            //                               program: doc['program'],
            //                               yearGraduated: doc['year_graduated'],
            //                             )));
            //               },
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //           );
            //         },
            //       );
            //     } else {
            //       return Center(
            //         child: Text("Loading.."),
            //       );
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
