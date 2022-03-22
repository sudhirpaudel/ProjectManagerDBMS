// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mainlogin/main.dart';
import 'package:mainlogin/mainfile/all_projects.dart';
import 'package:mainlogin/mainfile/create_project.dart';
import 'package:mainlogin/mainfile/database.dart';
import 'package:mainlogin/mainfile/join_project.dart';
import 'package:mainlogin/mainfile/joined_projects.dart';
import 'package:mainlogin/mainfile/my_projects.dart';
import 'package:sqflite/sqflite.dart';

import 'admin.dart';

class MyAppMain extends StatelessWidget {
  const MyAppMain(
      {Key? key, required this.x, required this.id, required this.name})
      : super(key: key);
  final int x;
  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'MainPageHome',
      home: MainHomePage(x: x, id: id, name: name),
    );
  }
}

class MainHomePage extends StatelessWidget {
  const MainHomePage(
      {Key? key, required this.x, required this.id, required this.name})
      : super(key: key);
  final int x;
  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    var joinId = id;
    var screens = [
      MyProjects(
        idJoin: joinId,
      ),
       
      const AllProjects(),
      CreateProject(idJoin: joinId,name: name,),
      JoinProject(idJoin: joinId,name: name,),
       Admin(idUser: joinId),
       JoinedProjects(
        idJoin: joinId,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'PROJECT MANAGER ',
          style: TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
      ),
      body: screens[x],
      drawer: FrontDrawer(
        name: name,
        id: id,
      ),
    );
  }
}

class FrontDrawer extends StatelessWidget {
  const FrontDrawer({Key? key, required this.name, required this.id})
      : super(key: key);
  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      backgroundColor: Colors.yellow,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                child:  Center(
                  child: Text(name[0],
                      style:const TextStyle(
                        color: Colors.yellow,
                        fontSize: 80,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                color: Colors.black,
                height: 50,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyAppMain(x: 0, id: id, name: name),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.portrait,
                        color: Colors.yellow,
                      ),
                      label: const Text(
                        'My Projects',
                        style: TextStyle(color: Colors.yellow, fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
             
             
             
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                color: Colors.black,
                height: 50,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyAppMain(x: 2, id: id, name: name),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.create,
                        color: Colors.yellow,
                      ),
                      label: const Text(
                        'Create Projects',
                        style: TextStyle(color: Colors.yellow, fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.93),
            height: height * 0.05,
            width: double.infinity,
            color: Colors.black,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.yellow,
              ),
              label: const Text(
                'LOG OUT',
                style: TextStyle(color: Colors.yellow, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
