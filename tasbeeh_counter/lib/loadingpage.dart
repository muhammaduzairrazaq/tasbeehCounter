// import 'package:flutter/material.dart';

// class LoadingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//   body: Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           'assets/lodingbk.gif',
//           fit: BoxFit.cover,
//           width: 200,
//           height: 200,
//         ),
//         SizedBox(height: 20), 
//         Text(
//           'Tasbeeh Counter',
//           style: TextStyle(
//             fontSize: 25,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ),
//   ),
// );



//   }
// }

import 'package:flutter/material.dart';
import 'tasbeeh_list_screen.dart';
import 'dart:async';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => TasbeehScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/lodingbk.gif',
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20), 
            Text(
              'Tasbeeh Counter',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


