import 'package:flutter/material.dart';
import 'package:mainlogin/mainfile/database.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({Key? key, required this.idJoin}) : super(key: key);
  final int idJoin;

  @override
  _MyProjectsState createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int x = 0;
    widget.idJoin;
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<dynamic>>(
        future: DatabaseHelper.instance.mergedProjectsList(
            widget.idJoin), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: OutlinedButton(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text('MY PROJECTS',
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
                  onPressed: () async {},
                ),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: snapshot.data![0].length,
                    itemBuilder: (BuildContext context, int index) {
                      x = index + 1;
                      return Container(
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: ExpansionTile(
                          title: Text("$x. ${snapshot.data![0][index][1]}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22)),
                          children: <Widget>[
                            ListTile(
                              title: Text("  ${snapshot.data![0][index][2]}",
                                  style:  TextStyle(
                                      color: Colors.yellow.shade900,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20)),
                              subtitle: Text(
                                  " Start: ${snapshot.data![0][index][3]}, Deadline: ${snapshot.data![0][index][4]}",
                                  style: const TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: width / 2.4,
                                  margin:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                  child: OutlinedButton(
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        child: const Center(
                                          child: Text('EditProject',
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                      ),
                                      onPressed: () async {
                                        int z = int.parse(
                                            snapshot.data![0][index][0]);
                                        String z1 = snapshot.data![0][index][2];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateProject(
                                                idPro: z, task: z1),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  height: 40,
                                  width: width / 2.4,
                                  margin:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                  child: OutlinedButton(
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: const Center(
                                        child: Text('DeleteProject',
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    onPressed: () async {
                                      int z = int.parse(
                                          snapshot.data![0][index][0]);
                                      await DatabaseHelper.instance
                                          .deleteProject(z);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('No Projects...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

class UpdateProject extends StatefulWidget {
  const UpdateProject({Key? key, required this.idPro, required this.task})
      : super(key: key);
  final int idPro;
  final String task;

  @override
  State<UpdateProject> createState() => _UpdateProjectState();
}

class _UpdateProjectState extends State<UpdateProject> {
  late TextEditingController _tasks;
  var deadline;
  String taskAdd = '';

  @override
  void initState() {
    
    _tasks = TextEditingController()
      ..text = widget.task ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // ignore: prefer_typing_uninitialized_variables

    widget.idPro;
    widget.task;

    return AlertDialog(
      title: const Text('Update Project'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: SizedBox(
              height: height / 6,
              width: double.infinity,
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
                  hintText: 'Add Tasks',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.calendar_today_rounded,
              color: Colors.yellow,
            ),
            label: Container(
              height: 30,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: Text('New Deadline',
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
                  deadline = date;
                 
                });
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        OutlinedButton(
          child: Container(
            height: 30,
            width: width / 2,
            margin: const EdgeInsets.fromLTRB(50, 10, 30, 10),
            child: const Center(
              child: Text('UPDATE PROJECT',
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
                id: widget.idPro,
                userId: proInfo.userId,
                name: proInfo.name,
                task: proInfo.task,
                code: proInfo.code,
                startDate: proInfo.startDate,
                finalDate: proInfo.finalDate);
            List proInfo2 = await DatabaseHelper.instance.queryProject(proInfo);
            List x = [
              deadline.year.toString() +
                  '-' +
                  deadline.month.toString() +
                  '-' +
                  deadline.day.toString()
            ];
            if (x.isEmpty) {
              x[0] = proInfo2[6];
            }
           
            proInfo = Project(
                id: widget.idPro,
                userId: int.parse(proInfo2[1]),
                name: proInfo2[2],
                task: _tasks.text,
                code: proInfo2[4],
                startDate: proInfo2[5],
                finalDate: x[0]);
            Navigator.of(context).pop();
            await DatabaseHelper.instance.updateProject(proInfo);
          },
        ),
        Center(
          child: OutlinedButton(
            child: Container(
              height: 10,
              width: width / 4,
              margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: const Center(
                child: Text('Close',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 10)),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.yellow,
              side: const BorderSide(width: 2),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
