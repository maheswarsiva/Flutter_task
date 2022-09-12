import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/Screens/Screens2/mybio.dart';
import 'package:my_app/Screens/Screens2/myproject.dart';
import 'package:my_app/Screens/createuser.dart';
import 'package:my_app/Screens/loginscreen.dart';

import '../createproject.dart';

class UserSelect extends StatefulWidget {
  const UserSelect({Key? key}) : super(key: key);

  @override
  State<UserSelect> createState() => _UserSelectState();
}

class _UserSelectState extends State<UserSelect> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          radioTheme: RadioThemeData(
              fillColor: MaterialStateColor.resolveWith(
                  (states) => Colors.lightGreenAccent))),
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(50.0),
            child: Text("User Screen"),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: Colors.lightGreenAccent),
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
  bio,
  project,
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SelectedOne? _selected = SelectedOne.bio;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const Text('Which One do you Prefer Your Profile (or) Your Project?'),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListTile(
                title: const Text('My Bio'),
                leading: Radio<SelectedOne>(
                  value: SelectedOne.bio,
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
                title: const Text('My Project'),
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
                primary: Colors.lightGreenAccent,
                elevation: 3,
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.normal),
                shape: const StadiumBorder(),
                shadowColor: Colors.amberAccent,
              ),
              onPressed: () {
                if (_selected == SelectedOne.bio) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyBio()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyProject()));
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                    color: Colors.black45,
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
