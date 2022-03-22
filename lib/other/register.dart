import 'package:flutter/material.dart';
import 'package:mainlogin/main.dart';
import 'package:mainlogin/mainfile/database.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  var reg = RegisterAcc(email: 'a', password: 'b', name: 'a');

  double hei = 0;
  double wid = 0;
  Color col1 = Colors.black;
  Color col2 = Colors.black;

  @override
  Widget build(BuildContext context) {
    if (!_obscureText1) {
      col1 = Colors.yellow;
    } else {
      col1 = Colors.black;
    }
    if (!_obscureText2) {
      col2 = Colors.yellow;
    } else {
      col2 = Colors.black;
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
              const SizedBox(height: 20),
              const BackButton(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              nameForm(),
              emailForm(),
              passwordForm(),
              confirmPasswordForm(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  nameForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              ' Name',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              hintText: 'Enter Your Name',
              hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  emailForm() {
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
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              hintText: 'Enter Your E-mail',
              hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  passwordForm() {
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
            obscureText: _obscureText1,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  _obscureText1 = !_obscureText1;
                }),
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: col1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 3),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              hintText: 'Enter  Password',
              hintStyle: const TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  confirmPasswordForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Confirm Password',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          TextField(
            controller: _confirmPassword,
            obscureText: _obscureText2,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  _obscureText2 = !_obscureText2;
                }),
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: col2,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 3),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              hintText: 'Confirm Password',
              hintStyle: const TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  registerButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: OutlinedButton(
        child: Container(
          height: 40,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: const Center(
            child: Text('REGISTER',
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
          var _nameR = _name.text;
          var _emailR = _email.text;
          var _passwordR = _password.text;
          var _confirmPasswordR = _confirmPassword.text;
          if (_name.text.isNotEmpty &&
              _email.text.isNotEmpty &&
              _password.text.isNotEmpty &&
              _confirmPassword.text.isNotEmpty) {
            if (_passwordR != _confirmPasswordR) {
              const snackBar = SnackBar(
                content: Text(
                  "Passwords does't match",
                  style: TextStyle(color: Colors.yellow),
                ),
              );
              _confirmPassword.clear();
              _password.clear();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              var x =
                  await DatabaseHelper.instance.queryAccountWithEmail(_emailR);
              if (x.isEmpty) {
                reg = RegisterAcc(
                    email: _emailR, password: _passwordR, name: _nameR);

                DatabaseHelper.instance.insertRegisterAcc(reg);
                showAllAccounts();

                const snackBar = SnackBar(
                  content: Text(
                    'Account regestered',
                    style: TextStyle(color: Colors.yellow),
                  ),
                );
                _name.clear();
                _email.clear();
                _confirmPassword.clear();
                _password.clear();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              } else {
                const snackBar = SnackBar(
                  content: Text(
                    "Email Already in Use",
                    style: TextStyle(color: Colors.yellow),
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
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
    );
  }
}
