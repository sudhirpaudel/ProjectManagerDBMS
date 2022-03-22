// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mainlogin/other/login.dart';
import 'package:mainlogin/other/register.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: whichScreen(height: height, width: width),
    );
  }

  whichScreen({required double height, required double width}) {
    if (width < 550) {
      return Column(
        children: [
          SizedBox(
            height: height * 0.89,
            width: width,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.89,
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(
                          image: AssetImage('images/image.jpg'),
                          fit: BoxFit.fill)),
                ),
                PageView(
                  controller: _controller,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: height * 0.7,
                      width: width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PROJECT ',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              //color: Colors.white.withOpacity(0.8),
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'MANAGER',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: height * 7,
                      width: width * 8,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            ' Project & Work Management Software for Hybrid Teams',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.yellow),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: height * 7,
                      width: width * 8,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Accelerate Work and Collaborate in a Hybrid World',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.yellow),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                          dotColor: Colors.black,
                          activeDotColor: Colors.yellow,
                          spacing: 15),
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: height * 0.11,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: Container(
                    height: 40,
                    width: width * 0.3,
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
                    side: const BorderSide(width: 3),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogIn(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  child: Container(
                    height: 40,
                    width: width * 0.3,
                    margin: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text('REGISTER',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height * 0.89,
                ),
                ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      constraints: BoxConstraints(
                        minHeight: height * 0.7,
                      ),
                      width: width * 0.8,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          image: DecorationImage(
                              image: AssetImage('images/image.jpg'),
                              fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PROJECT ',
                            style: TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.w600,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'MANAGER',
                            style: TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.w600,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      constraints: BoxConstraints(
                        minHeight: height * 0.7,
                      ),
                      width: width * 0.8,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          image: DecorationImage(
                              image: AssetImage('images/image.jpg'),
                              fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Project & Work Management Software for Hybrid Teams',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                              'Plan and collaborate across teams and work styles for total visibility and greater productivity',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      constraints: BoxConstraints(
                        minHeight: height * 0.7,
                      ),
                      width: width * 0.8,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          image: DecorationImage(
                              image: AssetImage('images/image.jpg'),
                              fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Accelerate Work and Collaborate in a Hybrid World ',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.yellow),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                              'ProjectManager is an online project and work management software that offers five different work views for hybrid teams, along with robust reporting and collaboration capabilities, so your team can work together from anywhere—and track results.',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            child: Container(
                              height: 40,
                              width: width * 0.3,
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
                              side: const BorderSide(width: 3),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LogIn(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            child: Container(
                              height: 40,
                              width: width * 0.3,
                              margin: const EdgeInsets.all(10),
                              child: const Center(
                                child: Text('REGISTER',
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
