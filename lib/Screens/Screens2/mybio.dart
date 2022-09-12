import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Screens/Screens2/userselect.dart';
import 'package:my_app/Screens/adminscreen.dart';

class MyBio extends StatefulWidget {
  const MyBio({Key? key}) : super(key: key);

  @override
  State<MyBio> createState() => _MyBioState();
}

class _MyBioState extends State<MyBio> {
  late String name, email, dob;

  // void getData() async {
  //   var userData = await FirebaseFirestore.instance
  //       .collection("userlist")
  //       .doc("username")
  //       .get();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("My Bio"),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserSelect()));
              }),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text('no value');
              }
              return ListView(
                  children: snapshot.data!.docs.map((document) {
                return Text(
                  document['email'],
                );
              }).toList());
            })
        // SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         // ignore: avoid_unnecessary_containers
        //         TextField(
        //           decoration: InputDecoration(
        //             prefixIcon: const Icon(Icons.person_outline_rounded,
        //                 color: Colors.cyanAccent),
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //           ),
        //         ),

        //         const SizedBox(
        //           height: 20,
        //         ),

        //         //Text(DocumentSnapshot variable = await FirebaseFirestore.instance.collection('userlist').doc('username')),
        //         // ignore: avoid_unnecessary_containers
        //         TextField(
        //           decoration: InputDecoration(
        //             prefixIcon: const Icon(Icons.password_rounded,
        //                 color: Colors.cyanAccent),
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             labelText: 'Password',
        //             labelStyle: const TextStyle(color: Colors.cyanAccent),
        //           ),
        //         ),

        //         const SizedBox(
        //           height: 20,
        //         ),
        //         TextField(
        //           decoration: InputDecoration(
        //             prefixIcon: const Icon(Icons.calendar_month_rounded,
        //                 color: Colors.cyanAccent),
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             labelText: "Date Of Birth",
        //             labelStyle: const TextStyle(color: Colors.cyanAccent),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         SizedBox(
        //           width: 250,
        //           height: 50,
        //           child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               primary: Colors.cyan,
        //               elevation: 3,
        //               textStyle: const TextStyle(
        //                   color: Colors.black,
        //                   fontSize: 20,
        //                   fontStyle: FontStyle.normal),
        //               shape: const StadiumBorder(),
        //               shadowColor: Colors.cyanAccent,
        //             ),
        //             onPressed: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => const AdminScreen()));
        //             },
        //             child: const Text(
        //               'Get Data',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 20),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
