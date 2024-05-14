import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/components/home_floatingbutton.dart';
import 'package:admin_app/components/page_transition.dart';
import 'package:admin_app/pages/profile_page.dart';
import 'package:admin_app/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum SearchBy {
  name,
  yearGraduated,
  program,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirestoreService alumniBase = FirestoreService();
  late final TextEditingController searchController;
  late String nameQuery;
  bool sortByNameAscending = false;
  bool sortByYearGraduatedAscending = false;
  SearchBy searchParam = SearchBy.name;

  Stream getAlumniStream(SearchBy selected) {
    // nameQuery != ''
    // ? alumniBase.alumni
    //     .where('searchable_name', arrayContains: nameQuery)
    //     .snapshots()
    // : alumniBase.alumni.snapshots()
    if (selected == SearchBy.name) {
      if (nameQuery != '') {
        return alumniBase.alumni
          .where('searchable_name', arrayContains: nameQuery)
          .snapshots();
      }
    }
    else if (selected == SearchBy.yearGraduated) {
      return alumniBase.alumni
        .where('year_graduated', isEqualTo: nameQuery)
        .snapshots();
    }
    else if (selected == SearchBy.program) {
      return alumniBase.alumni
        .where('program', arrayContains: nameQuery)
        .snapshots();
    }
    return alumniBase.alumni.snapshots();
  }

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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final searchByPopupMenu = GlobalKey<PopupMenuButtonState>();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Search field
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: searchParam == SearchBy.name ? "Search alumni"
                        : searchParam == SearchBy.yearGraduated ? "Search by graduation year"
                        : searchParam == SearchBy.program ? "Search by program"
                        : "Search",
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
                  initialValue: searchParam,
                  tooltip: "Search by",
                  color: Colors.white,
                  onSelected: (selected) {
                    setState(() {
                      searchParam = selected;
                    });
                  },
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
                      value: SearchBy.name,
                      child: Text("Search by name"),
                    ),
                    const PopupMenuItem(
                      value: SearchBy.yearGraduated,
                      child: Text("Search by year graduated"),
                    ),
                    const PopupMenuItem(
                      value: SearchBy.program,
                      child: Text("Search by program"),
                    ),
                  ],
                ),
              ],
            ),
            // Alumni List
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder(
                stream: getAlumniStream(searchParam),
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
                        columns: [
                          DataColumn(
                            label: Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState((){
                                    sortByNameAscending = !sortByNameAscending;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      sortByNameAscending == true
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down
                                    ),
                                    const Text(
                                      "Name",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const DataColumn(
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
                          const DataColumn(
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
                              child: InkWell(
                                onTap: () {
                                  setState((){
                                    sortByYearGraduatedAscending = !sortByYearGraduatedAscending;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      sortByYearGraduatedAscending == true
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down
                                    ),
                                    const Text(
                                      "Year Graduated",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "Employment Status",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
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
                                        ProfilePage(document: doc),
                                      )
                                    );
                                  }
                                },
                                cells: [
                                  DataCell(
                                    Text(
                                        '${doc['last_name'].toString().toUpperCase()}, ${doc['first_name']}',
                                        style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      doc['sex'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      doc['program'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '${doc['year_graduated']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      doc['employment_status']
                                          ? 'Employed'
                                          : 'Unemployed',
                                        style: const TextStyle(fontSize: 16),
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
      floatingActionButton: homeFloatingActionButton(context),
    );
  }
}
