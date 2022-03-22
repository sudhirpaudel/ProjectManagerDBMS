// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Project {
  final int? id;
  final int userId;
  final String name;
  final String task;
  final String code;
  final String startDate;
  final String finalDate;

  Project({
    this.id,
    required this.userId,
    required this.name,
    required this.task,
    required this.code,
    required this.startDate,
    required this.finalDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'task': task,
      'code': code,
      'startDate': startDate,
      'finalDate': finalDate,
    };
  }

  @override
  String toString() {
    return 'Project{id: $id,userId:$userId, name: $name,task:$task,code:$code,startDate:$startDate,finalDate:$finalDate}';
  }
}

class RegisterAcc {
  final int? id;
  final String email;
  final String password;
  final String name;

  RegisterAcc({
    this.id,
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'RegesterAcc{id: $id,name:$name, email: $email,password:$password}';
  }
}

class Relation {
  final int idUser;
  final int idPro;

  Relation({
    required this.idUser,
    required this.idPro,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'idPro': idPro,
    };
  }

  @override
  String toString() {
    return '[$idUser,$idPro]';
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), 'main_one_database.db'),
        version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE projects(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER NOT NULL ,name TEXT NOT NULL,task TEXT NOT NULL,code TEXT NOT NULL,startDate TEXT NOT NULL,finalDate TEXT NOT NULL )');

    await db.execute(
        'CREATE TABLE registerAcc(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT NOT NULL ,password TEXT NOT NULL ,name TEXT NOT NULL)');
    await db.execute('CREATE TABLE relation( idUser  INTEGER,idPro INTEGER )');
  }

  Future<void> insertProject(Project project) async {
    final db = await database;

    await db.insert(
      'projects',
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertRelation(Relation relation) async {
    final db = await database;

    await db.insert(
      'relation',
      relation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List> projectsList() async {
    final db = await database;
    List allProjectList = [];
    List singleProject = [];
    final List<Map<String, dynamic>> maps = await db.query('projects');
    List.generate(maps.length, (i) {
      var proInfo = Project(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        name: maps[i]['name'],
        task: maps[i]['task'],
        code: maps[i]['code'],
        startDate: maps[i]['startDate'],
        finalDate: maps[i]['finalDate'],
      );
      singleProject = [
        proInfo.id,
        proInfo.userId,
        proInfo.name,
        proInfo.task,
        proInfo.code,
        proInfo.startDate,
        proInfo.finalDate
      ];
      allProjectList.insert(i, singleProject);
    });
    return allProjectList;
  }

  Future<List> relationshipList() async {
    final db = await database;
    List allRelationList = [];
    List singleRelation = [];
    final List<Map<String, dynamic>> maps = await db.query('relation');
    List.generate(maps.length, (i) {
      var relInfo = Relation(
        idUser: maps[i]['idUser'],
        idPro: maps[i]['idPro'],
      );

      singleRelation = [relInfo.idUser, relInfo.idPro];
      allRelationList.insert(i, singleRelation);
    });
    return allRelationList;
  }

  Future<void> updateProject(Project project) async {
    final db = await database;

    await db.update(
      'projects',
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }

  Future<List> queryAccount(RegisterAcc registerAcc) async {
    final db = await database;

    var regInfo = await db.query(
      'registerAcc',
      where: 'email = ?',
      whereArgs: [registerAcc.email],
    );
    List regInfoSend = [
      regInfo[0]['id'],
      regInfo[0]['password'],
      regInfo[0]['name']
    ];
    return (regInfoSend);
  }

  Future<List> queryAccountWithEmail(String e) async {
    final db = await database;
    var registerAcc = RegisterAcc(email: '', password: '', name: '');
    registerAcc = RegisterAcc(
        email: e, password: registerAcc.password, name: registerAcc.name);

    var regInfo = await db.query(
      'registerAcc',
      where: 'email = ?',
      whereArgs: [registerAcc.email],
    );

    if (regInfo.isNotEmpty) {
      List regInfoSend = [
        regInfo[0]['id'],
        regInfo[0]['password'],
        regInfo[0]['name']
      ];
      return (regInfoSend);
    } else {
      return [];
    }
  }

  Future<List> queryProject(Project project) async {
    final db = await database;

    var proInfo = await db.query(
      'projects',
      where: 'id=?',
      whereArgs: [project.id],
    );
    List proInfoSend = [
      proInfo[0]['id'].toString(),
      proInfo[0]['userId'].toString(),
      proInfo[0]['name'].toString(),
      proInfo[0]['task'].toString(),
      proInfo[0]['code'].toString(),
      proInfo[0]['startDate'].toString(),
      proInfo[0]['finalDate'].toString(),
    ];
    return proInfoSend;
  }

  Future<List> queryProjectId(Project project) async {
    final db = await database;

    var proInfo = await db.query(
      'projects',
      where: 'code=?',
      whereArgs: [project.code],
    );
    if (proInfo.isEmpty) {
      return [0, 0];
    } else {
      String proInfoSend = proInfo[0]['id'].toString();
      return [int.parse(proInfoSend), proInfo[0]['idUser'].toString()];
    }
  }

  Future<List> queryProjectForName(Project project) async {
    final db = await database;

    var proInfo = await db.query(
      'projects',
      where: 'code=?',
      whereArgs: [project.code],
    );

    if (proInfo.isEmpty) {
      return [];
    } else {
      String proInfoSend = proInfo[0]['name'].toString();

      return [proInfoSend];
    }
  }

  Future<List> queryRelation(Relation relation) async {
    final db = await database;
    List joindPro = [];
    var proInfo = await db.query(
      'relation',
      where: 'idUser=?',
      whereArgs: [relation.idUser],
    );

    for (var i = 0; i < proInfo.length; i++) {
      joindPro.insert(i, proInfo[i]['idPro'].toString());
    }
    return joindPro;
  }

  Future<void> deleteProject(int id) async {
    final db = await database;

    await db.delete(
      'projects',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteRelation(int idUser, int idPro) async {
    final db = await database;

    await db.delete(
      'relation',
      where: 'idUser = ? and idPro=?',
      whereArgs: [idUser, idPro],
    );
  }

  Future<void> insertRegisterAcc(RegisterAcc registerAcc) async {
    final db = await database;

    await db.insert(
      'registerAcc',
      registerAcc.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List> registerAccList() async {
    final db = await database;
    List allAccountsList = [];
    List singleAccount = [];
    final List<Map<String, dynamic>> maps = await db.query('registerAcc');
    List.generate(maps.length, (i) {
      var accInfo = RegisterAcc(
        id: maps[i]['id'],
        email: maps[i]['email'],
        password: maps[i]['password'],
        name: maps[i]['name'],
      );
      singleAccount = [
        accInfo.id,
        accInfo.name,
        accInfo.email,
      ];
      allAccountsList.insert(i, singleAccount);
    });
    return allAccountsList;
  }

  Future<List> joinedProjectsList(int idJoin) async {
    var joinRel = Relation(idUser: 0, idPro: 0);
    var proInfo = Project(
      id: 0,
      userId: 0,
      name: '',
      task: '',
      code: '',
      startDate: '',
      finalDate: '',
    );
    List allJoinedProjects = [];
    joinRel = Relation(idUser: idJoin, idPro: joinRel.idPro);
    List joinedProjects = await DatabaseHelper.instance.queryRelation(joinRel);
    for (var i = 0; i < joinedProjects.length; i++) {
      int x = int.parse(joinedProjects[i]);
      proInfo = Project(
        id: x,
        userId: proInfo.userId,
        name: proInfo.name,
        task: proInfo.task,
        code: proInfo.code,
        startDate: proInfo.startDate,
        finalDate: proInfo.finalDate,
      );
      List joinPro = await DatabaseHelper.instance.queryProject(proInfo);
      allJoinedProjects.insert(i, joinPro);
    }
    return allJoinedProjects;
  }

  Future<List> createdProjectsList(int idUser) async {
    final db = await database;

    var proInfo = Project(
      id: 0,
      userId: 0,
      name: '',
      task: '',
      code: '',
      startDate: '',
      finalDate: '',
    );
    proInfo = Project(
        userId: idUser,
        name: proInfo.name,
        task: proInfo.task,
        code: proInfo.code,
        startDate: proInfo.startDate,
        finalDate: proInfo.finalDate);

    var proInfo2 = await db.query(
      'projects',
      where: 'userId=?',
      whereArgs: [proInfo.userId],
    );

    List allCreatedProjects = [];
    if (proInfo2.isEmpty) {
      return [];
    } else {
      for (var i = 0; i < proInfo2.length; i++) {
        List proInfoSend = [
          proInfo2[i]['id'].toString(),
          proInfo2[i]['name'].toString(),
          proInfo2[i]['task'].toString(),
          proInfo2[i]['startDate'].toString(),
          proInfo2[i]['finalDate'].toString(),
        ];

        allCreatedProjects.insert(i, proInfoSend);
      }

      return allCreatedProjects;
    }
  }

  Future<List> mergedProjectsList(int idUser) async {
    List createdPro = await DatabaseHelper.instance.createdProjectsList(idUser);
    List joinedPro = await DatabaseHelper.instance.joinedProjectsList(idUser);
    return [createdPro, joinedPro];
  }

  Future<bool> joinProject(int idJoinUser, String codePro) async {
    var proInfo = Project(
      id: 0,
      userId: 0,
      name: '',
      task: '',
      code: '',
      startDate: '',
      finalDate: '',
    );
    proInfo = Project(
      id: proInfo.id,
      userId: proInfo.userId,
      name: proInfo.name,
      task: proInfo.task,
      code: codePro,
      startDate: proInfo.startDate,
      finalDate: proInfo.finalDate,
    );

    var idJoinPro = await DatabaseHelper.instance.queryProjectId(proInfo);
    var joinRel = Relation(idUser: idJoinUser, idPro: idJoinPro[0]);
    if (idJoinPro[1] == idJoinUser) {
      return false;
    } else {
      await DatabaseHelper.instance.deleteRelation(idJoinUser, idJoinPro[0]);
      await DatabaseHelper.instance.insertRelation(joinRel);
      return true;
    }
  }
}

// to print in debug
showAllProjects() async {
  print('==============================================');
  print(
      'projectID ,creater Id, projectName, projectTasks, projectCode, start,final');
  print('----------------------------------------------');
  List allProjectList = await DatabaseHelper.instance.projectsList();
  for (var i = 0; i < allProjectList.length; i++) {
    print(allProjectList[i]);
  }
  print('---------------------------------------------');
}

showAllRelations() async {
  print('==============================================');
  print('userID , projectID');
  print('----------------------------------------------');
  List allRelationList = await DatabaseHelper.instance.relationshipList();
  for (var i = 0; i < allRelationList.length; i++) {
    print(allRelationList[i]);
  }
  print('---------------------------------------------');
}

showAllAccounts() async {
  print('==============================================');
  print('userID , userName,userEmail');
  print('----------------------------------------------');
  List allAccountsList = await DatabaseHelper.instance.registerAccList();
  for (var i = 0; i < allAccountsList.length; i++) {
    print(allAccountsList[i]);
  }
  print('---------------------------------------------');
}

showAllJoinedProjects(int idJoin) async {
  print('==============================================');
  print('projectID , projectName, projectTasks,start,end');
  print('----------------------------------------------');
  List allJoinedProjectList =
      await DatabaseHelper.instance.joinedProjectsList(idJoin);
  for (var i = 0; i < allJoinedProjectList.length; i++) {
    print(allJoinedProjectList[i]);
  }
  print('---------------------------------------------');
}

//to join project
