import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _date = TextEditingController();
    final TextEditingController prjname = TextEditingController();
    final TextEditingController company = TextEditingController();
    final TextEditingController website = TextEditingController();
    final TextEditingController location = TextEditingController();

    // List userData = [];

    // Future userlist() async {
    //   var baseUrl = "https://jsonplaceholder.typicode.com/users";

    //   http.Response response = await http.get(Uri.parse(baseUrl));

    //   if (response.statusCode == 200) {
    //     var jsonData = json.decode(response.body);
    //     setState(() {
    //       userData = jsonData;
    //     });
    //     debugPrint(userData.toString());
    //   } else {
    //     throw Exception('Failed to CREATE event: ${response.body}');
    //   }
    // }

    // @override
    // // ignore: unused_element
    // void initState() {
    //   super.initState();
    //   userlist();
    // }

    var dropdownvalue;

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Create Project"))),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: TextField(
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
                controller: _date,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.calendar_month_rounded,
                      color: Colors.cyanAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: "Date Of Birth",
                  labelStyle: const TextStyle(color: Colors.cyanAccent),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2050));

                  if (pickedDate != null) {
                    setState(() {
                      _date.text = DateFormat('YYYY-MM-dd').format(pickedDate);
                      //('dd-MM-yyy').format(pickedDate)
                    });
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
                      .collection("users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      const Text("Loading");
                    } else {
                      List<DropdownMenuItem> userData = [];

                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        userData.add(DropdownMenuItem(
                          // ignore: sort_child_properties_last
                          child: Text(snap.id),
                          // ignore: unnecessary_string_interpolations
                          value: "${snap.id}",
                        ));
                      }
                      return Row(
                        children: [
                          const Icon(Icons.person_outline_rounded),
                          const SizedBox(
                            width: 50.0,
                          ),
                          DropdownButton<dynamic>(
                            items: userData,
                            onChanged: (userValue) {
                              final snackBar = SnackBar(
                                content: Text('Selected User is $userValue'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                dropdownvalue = userValue;
                              });
                            },
                            value: dropdownvalue,
                            hint: const Text("Assign User"),
                          )
                        ],
                      );
                    }
                    return Container();
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
                    };
                    FirebaseFirestore.instance
                        .collection("projectlist")
                        .add(data);
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
    );
  }
}
