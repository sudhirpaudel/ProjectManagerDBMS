import 'package:flutter/material.dart';

import 'database.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key, required this.idUser}) : super(key: key);
  final int idUser;
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    widget.idUser;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: OutlinedButton(
            child: Container(
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: Text('ALL PROJECTS',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              side: const BorderSide(width: 2),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: () async {
              showAllProjects();
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: OutlinedButton(
            child: Container(
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: Text('ALL Accounts',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              side: const BorderSide(width: 2),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: () async {
              showAllAccounts();
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: OutlinedButton(
            child: Container(
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: Text('Relations',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              side: const BorderSide(width: 2),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: () async {
              showAllRelations();
              
            },
          ),
        ),
      ],
    );
  }
}
