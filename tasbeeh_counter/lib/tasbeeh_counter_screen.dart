import 'package:flutter/material.dart';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String tasbeehName = 'Tasbeeh Name';
  int setCompleted = 0;
  int cumulative = 0;
  double progress = 0;

  void incrementProgress() {
    setState(() {
      if (progress < 100) {
        progress++;
        cumulative++;

      } else {
        progress = 0;
        setCompleted ++;
      }
    });
  }

  void restartProgress() {
    setState(() {
      progress = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Tasbeeh Counter', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restart_alt, color: Colors.white),
            onPressed: restartProgress,
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Put your settings function here
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/tbk3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 80, 79, 79).withOpacity(0.8),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tasbeehName,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
                SizedBox(height: 50.0),
                GestureDetector(
                  onTap: incrementProgress,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: CircularProgressIndicator(
                          value: progress / 100,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          strokeWidth: 10,
                          backgroundColor: Color.fromARGB(255, 158, 158, 158),
                        ),
                      ),
                      Text(
                        '${progress.toInt()}',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color.fromARGB(255, 158, 158, 158),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  'Set Completed: $setCompleted',
                  style: TextStyle(fontSize: 20,
                  color: Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
                Text(
                  'Cumulative: $cumulative',
                  style: TextStyle(fontSize: 20,
                  color: Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
