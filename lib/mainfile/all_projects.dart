import 'package:flutter/material.dart';
import 'package:mainlogin/mainfile/database.dart';

class AllProjects extends StatefulWidget {
  const AllProjects({Key? key}) : super(key: key);

  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  @override
  Widget build(BuildContext context) {
    int x = 0;

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<dynamic>>(
        future: DatabaseHelper.instance
            .projectsList(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                child: OutlinedButton(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text('ALL PROJECTS',
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      x = index + 1;
                      return Container(
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: ExpansionTile(
                          title: Text("$x. ${snapshot.data![index][2]}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22)),
                          children: <Widget>[
                            ListTile(
                              title: Text("  ${snapshot.data![index][3]}",
                                  style: TextStyle(
                                      color: Colors.yellow.shade800,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20)),
                            ),
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
