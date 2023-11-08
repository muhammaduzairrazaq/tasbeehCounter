import 'package:flutter/material.dart';
import 'settingscreen.dart';
import 'app_theme.dart';

class TasbeehCounter extends StatefulWidget {
  @override
  _TasbeehCounterState createState() => _TasbeehCounterState();
  final Map<String, dynamic> item;
  final int index;
  TasbeehCounter({required this.item, required this.index});
}

class _TasbeehCounterState extends State<TasbeehCounter> {
  String tasbeehName = 'Tasbeeh Name';
  int setCompleted = 0;
  int totalCount = 0;
  int progress = 0;
  int totalSet = 0;
  int currentCount = 0;

  void incrementProgress() {
    setState(() {
      if (progress <= totalSet - 1) {
        progress++;
        totalCount++;
      } else if (progress == totalSet) {
        progress = 1;
        totalCount++;
      }
    });
  }

  void incrementsetProgress() {
    setState(() {
      if (progress == totalSet) {
        setCompleted++;
      }
    });
  }

  void restartProgress() {
    setState(() {
      progress = 0;
      totalCount = 0;
      setCompleted = 0;
      currentCount = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.item.containsKey('tasbih_name')) {
      tasbeehName = widget.item['tasbih_name'];
    }
    if (widget.item.containsKey('set_completed')) {
      setCompleted = widget.item['set_completed'];
    }
    if (widget.item.containsKey('total_count')) {
      totalCount = widget.item['total_count'];
    }
    if (widget.item.containsKey('total_set')) {
      totalSet = widget.item['total_set'];
    }
    if (widget.item.containsKey('current_count')) {
      currentCount = widget.item['current_count'];
      progress = currentCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.textcolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop({
              'item': widget.item,
              'updatedItem': {
                'tasbih_name': widget.item['tasbih_name'],
                'total_set': widget.item['total_set'],
                'current_count': progress,
                'total_count': totalCount,
                'set_completed': setCompleted,
              },
            });
          },
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(BackgroundImage.imagepath),
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
              children: [
                Text(
                  '$tasbeehName',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
                SizedBox(height: 50.0),
                GestureDetector(
                  onTap: () {
                    incrementProgress();
                    incrementsetProgress();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: CircularProgressIndicator(
                          value: progress / 100,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppTheme.textcolor),
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
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Set Completed: $setCompleted',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
                Text(
                  'Cumulative: $totalCount',
                  style: TextStyle(
                    fontSize: 20,
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
