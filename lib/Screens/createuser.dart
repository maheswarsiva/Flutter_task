import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Screens/adminscreen.dart';
import 'package:my_app/Screens/loginscreen.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Create User")),
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.cyanAccent),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()));
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: avoid_unnecessary_containers
              TextField(
                autofocus: true,
                controller: _username,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline_rounded,
                      color: Colors.cyanAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'User Name',
                  labelStyle: const TextStyle(color: Colors.cyanAccent),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // ignore: avoid_unnecessary_containers
              TextField(
                controller: _password,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password_rounded,
                      color: Colors.cyanAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.cyanAccent),
                  suffixIcon: IconButton(
                    color: Colors.cyanAccent,
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
                      _date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                      //('dd-MM-yyy').format(pickedDate)
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    elevation: 3,
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.normal),
                    shape: const StadiumBorder(),
                    shadowColor: Colors.cyanAccent,
                  ),
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "name": _username.text,
                      "password": _password.text,
                      "DOB": _date.text
                    };
                    try {
                      FirebaseFirestore.instance
                          .collection("userlist")
                          .add(data);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('You have successfully added a user')));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Something Went Wrong While Adding Data')));
                    }
                    _username.clear();
                    _password.clear();
                    _date.clear();
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
