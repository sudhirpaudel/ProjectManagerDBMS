import 'package:flutter/material.dart';
import 'package:mainlogin/mainfile/database.dart';

import 'homepage.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key, required this.idJoin, required this.name})
      : super(key: key);
  final int idJoin;
  final String name;
  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final TextEditingController _projectName = TextEditingController();
  final TextEditingController _projectCode = TextEditingController();
  final TextEditingController _tasks = TextEditingController();

  var projectOne = Project(
    id: 0,
    userId: 0,
    name: '...',
    task: '...',
    code: '...',
    startDate: '.',
    finalDate: '.',
  );
  DateTime start = DateTime(2022, 2, 27);
  DateTime deadline = DateTime(2022, 2, 27);

  @override
  Widget build(BuildContext context) {
    widget.idJoin;
    widget.name;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white60,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextField(
              controller: _projectName,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                hintText: 'ProjectName',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextField(
              maxLength: 7,
              controller: _projectCode,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                hintText: 'ProjectCode',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: SizedBox(
              height: height / 6,
              child: TextField(
                expands: true,
                maxLines: null,
                controller: _tasks,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  hintText: 'Tasks',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 5, 10),
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.yellow,
                  ),
                  label: Container(
                    height: 30,
                    width: width / 4.2,
                    margin: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text('StartDate',
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
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                      builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.yellow,
                            onPrimary: Colors.black,
                            onSurface: Colors.green,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.red, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                    ).then((date) {
                      setState(() {
                        start = date ?? DateTime.now();
                      });
                    });
                  },
                ),
              ),
              OutlinedButton.icon(
                icon: const Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.yellow,
                ),
                label: Container(
                  height: 30,
                  width: width / 4.2,
                  margin: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text('Deadline',
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
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2222),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.yellow,
                            onPrimary: Colors.black,
                            onSurface: Colors.green,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.red, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((date) {
                    setState(() {
                      deadline = date ?? DateTime.now();
                    });
                  });
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: OutlinedButton(
              child: Container(
                height: 40,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: const Center(
                  child: Text('CREATE  PROJECT',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.yellow,
                side: const BorderSide(width: 2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () async {
                var _project = _projectName.text;
                var _code = _projectCode.text;
                var _task = _tasks.text;
                String x = start.year.toString() +
                    '-' +
                    start.month.toString() +
                    '-' +
                    start.day.toString();
                String y = deadline.year.toString() +
                    '-' +
                    deadline.month.toString() +
                    '-' +
                    deadline.day.toString();

                if (start.isBefore(deadline) ||
                    start.isAtSameMomentAs(deadline)) {
                  if (_projectName.text.isNotEmpty &&
                      _projectCode.text.isNotEmpty &&
                      _tasks.text.isNotEmpty) {
                    projectOne = Project(
                      userId: widget.idJoin,
                      name: _project,
                      task: _task,
                      code: _code,
                      startDate: x,
                      finalDate: y,
                    );
                    var z = await DatabaseHelper.instance
                        .queryProjectId(projectOne);
                    if (z[0] == 0) {
                      await DatabaseHelper.instance.insertProject(projectOne);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyAppMain(
                              x: 0, id: widget.idJoin, name: widget.name),
                        ),
                      );
                    } else {
                      const snackBar = SnackBar(
                        content: Text(
                          "Code Already in Use",
                          style: TextStyle(color: Colors.yellow),
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    const snackBar = SnackBar(
                      content: Text(
                        "Empty Field not accepted",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  const snackBar = SnackBar(
                    content: Text(
                      "Date format not valid",
                      style: TextStyle(color: Colors.yellow),
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
