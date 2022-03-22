import 'package:flutter/material.dart';
import 'package:mainlogin/mainfile/database.dart';
import 'package:mainlogin/mainfile/homepage.dart';

class JoinProject extends StatefulWidget {
  const JoinProject({Key? key, required this.idJoin, required this.name})
      : super(key: key);
  final int idJoin;
  final String name;
  @override
  State<JoinProject> createState() => _JoinProjectState();
}

class _JoinProjectState extends State<JoinProject> {
  final TextEditingController _projectName = TextEditingController();
  final TextEditingController _projectCode = TextEditingController();
  var proInfo = Project(
    id: 0,
    userId: 0,
    name: '',
    task: '',
    code: '',
    startDate: '',
    finalDate: '',
  );

  @override
  Widget build(BuildContext context) {
    widget.idJoin;
    widget.name;

    return Container(
      padding: const EdgeInsets.all(20),
      height: 450,
      child: Stack(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(
                    2.0,
                    2.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: TextField(
                  maxLength: 10,
                  controller: _projectCode,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 3),
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
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: TextField(
                  controller: _projectName,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    hintText: 'ProjectName',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: OutlinedButton(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text('JOIN PROJECT',
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
                    if (_projectCode.text.isNotEmpty &&
                        _projectCode.text.isNotEmpty) {
                      proInfo = Project(
                        userId: proInfo.userId,
                        name: proInfo.name,
                        task: proInfo.task,
                        code: _projectCode.text,
                        startDate: proInfo.startDate,
                        finalDate: proInfo.finalDate,
                      );

                      var x = await DatabaseHelper.instance
                          .queryProjectForName(proInfo);

                      if (x.isNotEmpty) {
                        if (x[0] == _projectName.text) {
                          var x = await DatabaseHelper.instance
                              .joinProject(widget.idJoin, _projectCode.text);
                          if (x) {
                            const snackBar = SnackBar(
                              content: Text(
                                'ProjectJoined',
                                style: TextStyle(color: Colors.yellow),
                              ),
                            );
                            _projectCode.clear();
                            _projectName.clear();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyAppMain(
                                    x: 5, id: widget.idJoin, name: widget.name),
                              ),
                            );
                          } else {
                            const snackBar = SnackBar(
                              content: Text(
                                'ALready in Project!',
                                style: TextStyle(color: Colors.yellow),
                              ),
                            );
                            _projectCode.clear();
                            _projectName.clear();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          const snackBar = SnackBar(
                            content: Text(
                              "wrong Project code or name",
                              style: TextStyle(color: Colors.yellow),
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        const snackBar = SnackBar(
                          content: Text(
                            "wrong Project code or name",
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
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
