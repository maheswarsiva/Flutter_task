import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Screens/adminscreen.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController prjname = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController location = TextEditingController();
  var dropdownvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Create Project")),
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.amberAccent),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()));
            }),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: TextField(
                    key: const ValueKey(1),
                    controller: prjname,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline_rounded,
                          color: Colors.amberAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Project Name',
                      labelStyle: const TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  key: const ValueKey(2),
                  obscureText: false,
                  controller: _date,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.calendar_month_rounded,
                        color: Colors.amberAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: "Project Date",
                    labelStyle: const TextStyle(color: Colors.amberAccent),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2050));

                    if (pickedDate != null) {
                      setState(() {
                        _date.text =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        //('dd-MM-yyy').format(pickedDate)
                      });
                    } else {
                      debugPrint("Date is not selected");
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextField(
                    controller: company,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_rounded,
                          color: Colors.amberAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Company Details (Name, Carch Phrase',
                      labelStyle: const TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextField(
                    controller: website,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_rounded,
                          color: Colors.amberAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Website',
                      labelStyle: const TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextField(
                    controller: location,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_rounded,
                          color: Colors.amberAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Location',
                      labelStyle: const TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("userlist")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        const CircularProgressIndicator();
                      } else {
                        List<DropdownMenuItem> userData = [];

                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          DocumentSnapshot snap = snapshot.data!.docs[i];
                          userData.add(DropdownMenuItem(
                            // ignore: sort_child_properties_last
                            child: Text(snap['name']),
                            // ignore: unnecessary_string_interpolations
                            value: "${snap['name']}",
                          ));
                        }
                        return Row(
                          children: [
                            const Icon(Icons.person_outline_rounded),
                            const SizedBox(
                              width: 50.0,
                            ),
                            DropdownButton<dynamic>(
                              value: dropdownvalue,
                              items: userData,
                              onChanged: (userValue) {
                                final snackBar = SnackBar(
                                  content: Text('Selected User is $userValue'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                setState(() {
                                  dropdownvalue = userValue;
                                  debugPrint(userValue);
                                });
                              },
                              hint: const Text("Assign User"),
                            )
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                      elevation: 3,
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.normal),
                      shape: const StadiumBorder(),
                      shadowColor: Colors.amberAccent,
                    ),
                    onPressed: () {
                      Map<String, dynamic> data = {
                        "prjname": prjname.text,
                        "prjdate": _date.text,
                        "company": company.text,
                        "website": website.text,
                        "location": location.text,
                        "user": dropdownvalue,
                      };
                      try {
                        FirebaseFirestore.instance
                            .collection("projectlist")
                            .add(data);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'You have successfully added project')));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Something Went Wrong While Adding Data')));
                      }
                      prjname.clear();
                      _date.clear();
                      company.clear();
                      website.clear();
                      location.clear();
                      setState(() {
                        dropdownvalue = null;
                      });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const AdminScreen()));
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
