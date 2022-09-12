import 'package:flutter/material.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/Screens/createproject.dart';
import 'package:my_app/Screens/createuser.dart';
import 'package:my_app/Screens/loginscreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          radioTheme: RadioThemeData(
              fillColor: MaterialStateColor.resolveWith(
                  (states) => Colors.pinkAccent))),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Admin Screen"),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

enum SelectedOne {
  user,
  project,
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SelectedOne? _selected = SelectedOne.user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const Text('Which One do you Prefer User (or) Project?'),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListTile(
                title: const Text('Create User'),
                leading: Radio<SelectedOne>(
                  value: SelectedOne.user,
                  groupValue: _selected,
                  onChanged: (SelectedOne? value) {
                    setState(() {
                      _selected = value;
                    });
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListTile(
                title: const Text('Create Project'),
                leading: Radio<SelectedOne>(
                  value: SelectedOne.project,
                  groupValue: _selected,
                  onChanged: (SelectedOne? value) {
                    setState(() {
                      _selected = value;
                    });
                  },
                )),
          ),
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
                if (_selected == SelectedOne.user) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateUser()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateProject()));
                }
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
    );
  }
}
