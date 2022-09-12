// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Screens/Screens2/userselect.dart';
import 'package:my_app/Screens/adminscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: avoid_unnecessary_containers
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline_rounded,
                      color: Colors.amberAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amberAccent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'User Name',
                  labelStyle: const TextStyle(color: Colors.amberAccent),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // ignore: avoid_unnecessary_containers
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password_rounded,
                      color: Colors.amberAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amberAccent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.amberAccent),
                  suffixIcon: IconButton(
                    color: Colors.amberAccent,
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    String id = _idController.text.trim();
                    String password = _passwordController.text.trim();

                    QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection("users")
                        .where('email', isEqualTo: id)
                        .get();

                    // debugPrint(snap.docs[0]['password']);
                    if (id.isEmpty) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter your user name!!")));
                    } else if (password.isEmpty) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Password Field is Empty!!")));
                    } else {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("users")
                          .where('email', isEqualTo: id)
                          .get();
                      try {
                        if (password == snap.docs[0]['password']) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminScreen()));
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Password is not Correct")));
                        }
                      } catch (e) {
                        String error = "";
                        debugPrint(e.toString());
                        if (e.toString() ==
                            "RangeError (index): Invalid value: Valid value range is empty: 0") {
                          setState(() {
                            error = "Admin Id Does not Exist";
                          });
                        } else {
                          setState(() {
                            error = "Error Occurred!!!";
                          });
                        }
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(error)));
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    elevation: 3,
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.normal),
                    shape: const StadiumBorder(),
                    shadowColor: Colors.amberAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserSelect()));
                  },
                  child: const Text(
                    'Users',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
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
