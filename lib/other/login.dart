import 'package:flutter/material.dart';
import 'package:mainlogin/mainfile/colors.dart';
import 'package:mainlogin/mainfile/database.dart';
import 'package:mainlogin/mainfile/homepage.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _obscureText = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  double wid = 0;
  double hei = 0;
  Color col = one;
  var logInInfo = RegisterAcc(email: 'a', password: 'b', name: 'a');
  List regInfo = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (!_obscureText) {
      col = two;
    } else {
      col = one;
    }
    if (width >= 500) {
      hei = height * 0.7;
      wid = 400;
    }
    if (width < 500) {
      wid = width * 0.95;
      hei = height * 0.95;
    }
    return Scaffold(
      body: Center(
        child: Container(
          height: hei,
          width: wid,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Colors.white60,
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
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              const BackButton(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              emailLogin(),
              passwordLogin(),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  emailLogin() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              ' E-mail',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          TextField(
            controller: _email,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: one, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: two, width: 2),
              ),
              hintText: 'Enter Your E-mail',
              hintStyle: const TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  passwordLogin() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              ' Password',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          TextField(
            controller: _password,
            obscureText: _obscureText,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  _obscureText = !_obscureText;
                }),
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: col,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: one, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: two, width: 2),
              ),
              hintText: 'Enter  Password',
              hintStyle: const TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  loginButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: OutlinedButton(
        child: Container(
          height: 40,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: const Center(
            child: Text('LOG IN',
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
          var _emailLog = _email.text;
          var _passwordLog = _password.text;
          if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
            logInInfo = RegisterAcc(
                email: _emailLog,
                password: logInInfo.password,
                name: logInInfo.name);
            regInfo =
                await DatabaseHelper.instance.queryAccountWithEmail(_emailLog);
            if (regInfo.isNotEmpty) {
              if (regInfo[1] == _passwordLog) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainHomePage(
                      x: 0,
                      id: regInfo[0],
                      name: regInfo[2],
                    ),
                  ),
                );
              } else {
                _password.clear();
                const snackBar = SnackBar(
                  content: Text(
                    "Wrong Email or Password",
                    style: TextStyle(color: Colors.yellow),
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              const snackBar = SnackBar(
                content: Text(
                  "Wrong Email or Password",
                  style: TextStyle(color: Colors.yellow),
                ),
              );
              _password.clear();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
      ),
    );
  }
}
