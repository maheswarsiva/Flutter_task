import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Screens/Screens2/userselect.dart';
import 'package:http/http.dart' as http;

class MyProject extends StatefulWidget {
  const MyProject({Key? key}) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));

    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jsonData) {
      User user = User(
        u["name"],
        u["email"],
        u["username"],
        u["website"],
      );
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("My Project")),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserSelect()));
              }),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
            child: Card(
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  // ignore: avoid_unnecessary_containers
                  return Container(
                    child: const Center(
                      child: Text('Loading...'),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(snapshot.data[i].name),
                          subtitle: Text(snapshot.data[i].email),
                          trailing: Text(snapshot.data[i].website),
                        );
                      });
                }
              }),
        ))
        // SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           child: TextField(
        //             decoration: InputDecoration(
        //               prefixIcon: const Icon(Icons.person_outline_rounded,
        //                   color: Colors.amberAccent),
        //               border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //               ),
        //               // labelText: 'Project Name',
        //               // labelStyle: const TextStyle(color: Colors.amberAccent),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),

        //         SizedBox(
        //           child: TextField(
        //             decoration: InputDecoration(
        //               prefixIcon: const Icon(Icons.password_rounded,
        //                   color: Colors.amberAccent),
        //               border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //               ),
        //               labelText: 'Company Details (Name, Carch Phrase',
        //               labelStyle: const TextStyle(color: Colors.amberAccent),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         SizedBox(
        //           child: TextField(
        //             decoration: InputDecoration(
        //               prefixIcon: const Icon(Icons.password_rounded,
        //                   color: Colors.amberAccent),
        //               border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //               ),
        //               labelText: 'Website',
        //               labelStyle: const TextStyle(color: Colors.amberAccent),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         SizedBox(
        //           child: TextField(
        //             decoration: InputDecoration(
        //               prefixIcon: const Icon(Icons.password_rounded,
        //                   color: Colors.amberAccent),
        //               border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //               ),
        //               labelText: 'Location',
        //               labelStyle: const TextStyle(color: Colors.amberAccent),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         // SizedBox(
        //         //   width: 250,
        //         //   height: 50,
        //         //   child: ElevatedButton(
        //         //     style: ElevatedButton.styleFrom(
        //         //       primary: Colors.pinkAccent,
        //         //       elevation: 3,
        //         //       textStyle: const TextStyle(
        //         //           color: Colors.black,
        //         //           fontSize: 20,
        //         //           fontStyle: FontStyle.normal),
        //         //       shape: const StadiumBorder(),
        //         //       shadowColor: Colors.amberAccent,
        //         //     ),
        //         //     onPressed: () {
        //         //       Navigator.push(
        //         //           context,
        //         //           MaterialPageRoute(
        //         //               builder: (context) => const AdminScreen()));
        //         //     },
        //         //     child: const Text('Login'),
        //         //   ),
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

// ignore: empty_constructor_bodies
class User {
  final String name, email, userName, website;
  User(this.name, this.email, this.userName, this.website);
}
