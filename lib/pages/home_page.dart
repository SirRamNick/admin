import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/components/home_helpbutton.dart';
import 'package:admin_app/components/page_transition.dart';
import 'package:admin_app/pages/profile_page.dart';
import 'package:admin_app/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  late String searchStringQuery;
  late SearchBy searchParam;
  bool? sortByNameAscending;
  bool? sortByYearGraduatedAscending;

  PopupMenuItem degreePopupMenuItem(
          String degree, String searchStringForDegree) =>
      PopupMenuItem(
        child: Text(degree),
        onTap: () {
          setState(() {
            searchStringQuery = searchController.text = searchStringForDegree;
          });
        },
      );

  Query getAlumniQuery(SearchBy selected) {
    Query alumniQuery = alumniBase.alumni;

    Query firstSort(Query q) {
      if (sortByNameAscending == true) {
        return q.orderBy('last_name', descending: false);
      } else if (sortByNameAscending == false) {
        return q.orderBy('last_name', descending: true);
      }
      return q;
    }

    Query secondSort(Query q) {
      if (sortByYearGraduatedAscending == true) {
        return q.orderBy('year_graduated', descending: false);
      } else if (sortByYearGraduatedAscending == false) {
        return q.orderBy('year_graduated', descending: true);
      }
      return q;
    }

    Query applySort() {
      if (sortByNameAscending != null || sortByYearGraduatedAscending != null) {
        return secondSort(firstSort(alumniQuery));
      }
      return alumniQuery;
    }

    if (searchStringQuery != '') {
      if (selected == SearchBy.name) {
        return applySort()
            .where('searchable_name', arrayContains: searchStringQuery);
      } else if (selected == SearchBy.yearGraduated) {
        int? searchIntQuery = int.tryParse(searchStringQuery);
        if (searchIntQuery != null) {
          return applySort().where('year_graduated', isEqualTo: searchIntQuery);
        } else {
          return applySort().where('last_name', isEqualTo: '');
        }
      } else if (selected == SearchBy.program) {
        return applySort().where('program', isEqualTo: searchStringQuery);
      }
    } else if (sortByNameAscending == null &&
        sortByNameAscending == sortByYearGraduatedAscending) {
      return applySort().orderBy('time_stamp', descending: true);
    }
    return applySort();
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchStringQuery = '';
    searchParam = SearchBy.name;
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final searchByPopupMenu = GlobalKey<PopupMenuButtonState>();
    final degreePopupMenu = GlobalKey<PopupMenuButtonState>();

    return Scaffold(
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      body: ListView(
        children: [
          // Search Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Search field
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 17,
                    top: 17,
                    right: 8.5,
                    bottom: 8.5,
                  ),
                  child: TextField(
                    controller: searchController,
                    enabled: true,
                    decoration: InputDecoration(
                      suffixIcon: searchStringQuery != ''
                          ? Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchController.clear();
                                    searchStringQuery = '';
                                  });
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            )
                          : null,
                      hintText: searchParam == SearchBy.name
                          ? "Search alumni"
                          : searchParam == SearchBy.yearGraduated
                              ? "Search by graduation year"
                              : searchParam == SearchBy.program
                                  ? "Search by degree"
                                  : "Search",
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1D4695),
                          width: 2,
                        ),
                      ),
                      filled: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchStringQuery = value;
                      });
                    },
                    onTap: () {
                      setState(() {
                        sortByNameAscending = null;
                        sortByYearGraduatedAscending = null;
                      });
                    },
                  ),
                ),
              ),
              // 'Search by' button
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.5,
                  top: 17,
                  right: 17,
                  bottom: 8.5,
                ),
                child: PopupMenuButton(
                  key: searchByPopupMenu,
                  initialValue: searchParam,
                  tooltip: "Search by",
                  onSelected: (selected) {
                    setState(() {
                      searchController.clear();
                      searchStringQuery = '';
                      searchParam = selected;
                    });
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      searchByPopupMenu.currentState?.showButtonMenu();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(17),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 25,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium
                              ?.color,
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium
                              ?.color,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          searchParam == SearchBy.name
                              ? "Name"
                              : searchParam == SearchBy.yearGraduated
                                  ? "Year Graduated"
                                  : searchParam == SearchBy.program
                                      ? "Degree"
                                      : "Search",
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium
                                ?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: SearchBy.name,
                      child: Text("Search by name"),
                    ),
                    const PopupMenuItem(
                      value: SearchBy.yearGraduated,
                      child: Text("Search by year graduated"),
                    ),
                    PopupMenuItem(
                      value: SearchBy.program,
                      child: const Text("Search by degree"),
                      onTap: () {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(
                              double.infinity, double.infinity, 0, 0),
                          items: [
                            degreePopupMenuItem("BS Computer Science",
                                "BS in Computer Science"),
                            degreePopupMenuItem(
                                "Associate in Computer Technology",
                                "Associate in Computer Technology"),
                            degreePopupMenuItem(
                                "BEEd Major in General Education",
                                "Bachelor in Elementary Education Major in General Education"),
                            degreePopupMenuItem("BSEd Major in English",
                                "Bachelor Secondary Education Major in English "),
                            degreePopupMenuItem("BSEd Major in Mathematics",
                                "Bachelor Secondary Education Major in Mathematics "),
                            degreePopupMenuItem("Bachelor of Arts in English",
                                "Bachelor of Arts in English "),
                            degreePopupMenuItem(
                                "BSBA Major in Marketing Management",
                                "BS in Business Administration Major in Marketing Management "),
                            degreePopupMenuItem(
                                "BSBA Major in Human Resource Management",
                                "BS in Business Administration Major in Human Resource Management"),
                            degreePopupMenuItem("BS Entrepreneurship",
                                "BS in Entrepreneurship"),
                            degreePopupMenuItem(
                                "BS Hospitality Management/Hotel and Restaurant Management",
                                "BS in Hospitality Management / Hotel and Restaurant Management"),
                            degreePopupMenuItem("BS Tourism Management",
                                "BS in Tourism Management"),
                            degreePopupMenuItem("Teacher Certificate Program",
                                "Teacher Certificate Program"),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Alumni List
          Padding(
            padding: const EdgeInsets.only(
              left: 17,
              top: 8.5,
              right: 17,
              bottom: 17,
            ),
            child: StreamBuilder(
              stream: getAlumniQuery(searchParam).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  List alumniList = snapshot.data!.docs;
                  return SizedBox(
                    width: screenWidth,
                    child: Theme(
                      data: ThemeData(
                        dividerTheme:
                            const DividerThemeData(color: Colors.grey),
                      ),
                      child: DataTable(
                        showCheckboxColumn: false,
                        headingRowHeight: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.75,
                          ),
                          color: Colors.white,
                        ),
                        columns: [
                          DataColumn(
                            label: Expanded(
                              // Sort by name
                              child: searchStringQuery != ''
                                  ? const Text(
                                      "Name",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          sortByYearGraduatedAscending = null;
                                          if (sortByNameAscending == null) {
                                            sortByNameAscending = true;
                                          } else if (sortByNameAscending ==
                                              true) {
                                            sortByNameAscending = false;
                                          } else {
                                            sortByNameAscending = null;
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            sortByNameAscending == true
                                                ? Icons.arrow_drop_up
                                                : sortByNameAscending == false
                                                    ? Icons.arrow_drop_down
                                                    : Icons.sort,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "Name",
                                            style: TextStyle(fontSize: 12),
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
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: Text(
                                "Program",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              // Sort by year graduated
                              child: searchStringQuery != ''
                                  ? const Text(
                                      "Year Graduated",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          sortByNameAscending = null;
                                          if (sortByYearGraduatedAscending ==
                                              null) {
                                            sortByYearGraduatedAscending = true;
                                          } else if (sortByYearGraduatedAscending ==
                                              true) {
                                            sortByYearGraduatedAscending =
                                                false;
                                          } else {
                                            sortByYearGraduatedAscending = null;
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            sortByYearGraduatedAscending == true
                                                ? Icons.arrow_drop_up
                                                : sortByYearGraduatedAscending ==
                                                        false
                                                    ? Icons.arrow_drop_down
                                                    : Icons.sort,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "Year Graduated",
                                            style: TextStyle(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
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
                                    "Current Employment Status",
                                    style: TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
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
                                    Navigator.push(
                                        context,
                                        normalTransitionTo(
                                          ProfilePage(document: doc),
                                        ));
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
                                      doc['employment_status'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.black,
                    ),
                  );
                } else {
                  return const Center();
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: homeHelpActionButton(context),
    );
  }
}
