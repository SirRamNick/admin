import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/components/admin_floatingbutton.dart';
import 'package:admin_app/components/page_transition.dart';
import 'package:admin_app/pages/profile_page.dart';
import 'package:admin_app/services/firebase.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirestoreService alumniBase = FirestoreService();
  late final TextEditingController searchController;
  late String nameQuery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
    nameQuery = '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final searchByPopupMenu = GlobalKey<PopupMenuButtonState>();
    final sortByPopupMenu = GlobalKey<PopupMenuButtonState>();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Search field
                Expanded(
                  child: TextField(
                    controller: searchController,
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
                    onChanged: (value) {
                      setState(() {
                        nameQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 15),
                // 'Search by' button
                PopupMenuButton(
                  key: searchByPopupMenu,
                  tooltip: "Search by",
                  color: Colors.white,
                  child: ElevatedButton(
                    onPressed: () {
                      searchByPopupMenu.currentState?.showButtonMenu();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4695),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: 25,
                      ),
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  itemBuilder: (context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      child: Text("Search by name"),
                    ),
                    const PopupMenuItem(
                      child: Text("Search by year graduated"),
                    ),
                    const PopupMenuItem(
                      child: Text("Search by program"),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 6,
                ),
                // Sort button
                PopupMenuButton(
                  key: sortByPopupMenu,
                  tooltip: "Sort by",
                  color: Colors.white,
                  child: ElevatedButton(
                    onPressed: () {
                      sortByPopupMenu.currentState?.showButtonMenu();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4695),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: 25,
                      ),
                    ),
                    child: const Icon(
                      Icons.sort,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  itemBuilder: (context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      child: Text("Sort by surname"),
                    ),
                    const PopupMenuItem(
                      child: Text("Sort by year graduated"),
                    ),
                    const PopupMenuItem(
                      child: Text("Sort by date added"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Alumni List
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder(
                stream: nameQuery != '' && nameQuery != null
                    ? alumniBase.alumni
                        .where('searchable_name', arrayContains: nameQuery)
                        .snapshots()
                    : alumniBase.alumni.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List alumniList = snapshot.data!.docs;

                    return Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: DataTable(
                        showCheckboxColumn: false,
                        headingRowHeight: 40,
                        columns: const [
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Name",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Sex",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Program",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Year Graduated",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Employment Status",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: alumniList
                            .map(
                              (doc) => DataRow(
                                onSelectChanged: (selected) {
                                  if (selected == true) {
                                    Navigator.pushReplacement(
                                      context,
                                      instantTransitionTo(
                                        ProfilePage(
                                          firstName: doc['first_name'],
                                          lastName: doc['last_name'],
                                          program: doc['program'],
                                          yearGraduated: doc['year_graduated'],
                                        ),
                                      )
                                    );
                                  }
                                },
                                cells: [
                                  DataCell(
                                    Text(
                                        '${doc['last_name'].toString().toUpperCase()}, ${doc['first_name']}',
                                        style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      doc['sex'],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      doc['program'],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '${doc['year_graduated']}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      doc['employment_status']
                                          ? 'Employed'
                                          : 'Unemployed',
                                        style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: adminFloatingActionButton(context),
    );
  }
}
