import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _vibration = false;
  bool _sound = false;
  bool _vignette = false;
  MaterialColor _themeColor = Colors.blue;
  Color _textcolor = Colors.blue;
  int _currentImageIndex = 0;

  List<MaterialColor> themeColors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.green
  ];

  List<String> imagePaths = [
    'assets/tbk1.png',
    'assets/tbk2.png',
    'assets/tbk3.png',
  ];

  void updateThemeColor(MaterialColor color) {
    setState(() {
      _themeColor = color;

      if (color == Colors.red) {
        _textcolor = Colors.red;
      }

      if (color == Colors.blue) {
        _textcolor = Colors.blue;
      }

      if (color == Colors.orange) {
        _textcolor = Colors.orange;
      }

      if (color == Colors.green) {
        _textcolor = Colors.green;
      }
    });
  }

  void nextImage() {
    setState(() {
      if (_currentImageIndex < imagePaths.length - 1) {
        _currentImageIndex++;
      } else {
        _currentImageIndex = 0;
      }
    });
  }

  void previousImage() {
    setState(() {
      if (_currentImageIndex > 0) {
        _currentImageIndex--;
      } else {
        _currentImageIndex = imagePaths.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData customTheme = ThemeData(
      primarySwatch: _themeColor,
      textTheme: TextTheme(
        headline6: TextStyle(color: _themeColor),
      ),
    );

    return MaterialApp(
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tasbeeh Counter',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            Image.asset(
              imagePaths[_currentImageIndex],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: const Color.fromARGB(255, 87, 87, 87)
                  .withOpacity(0.8), // Transparent overlay
              width: double.infinity,
              height: double.infinity,
            ),
            ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 2.0)),
                  ),
                  child: SwitchListTile(
                    title: Text(
                      'Vibration',
                      style: TextStyle(color: _textcolor, fontSize: 18),
                    ),
                    value: _vibration,
                    onChanged: (bool value) {
                      setState(() {
                        _vibration = value;
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 2.0)),
                  ),
                  child: SwitchListTile(
                    title: Text(
                      'Sound',
                      style: TextStyle(color: _textcolor, fontSize: 18),
                    ),
                    value: _sound,
                    onChanged: (bool value) {
                      setState(() {
                        _sound = value;
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 2.0)),
                  ),
                  child: ListTile(
                    title: Text(
                      'Theme',
                      style: TextStyle(color: _textcolor, fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: themeColors
                          .map((color) => GestureDetector(
                                onTap: () => updateThemeColor(color),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  color: color,
                                  margin: EdgeInsets.all(5),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0, // Adjust the height as needed
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0), // Adjust the value as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: _textcolor),
                            onPressed: () {
                              previousImage();
                            },
                          ),
                          Text(
                            'Image Background',
                            style: TextStyle(color: _themeColor, fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward, color: _textcolor),
                            onPressed: () {
                              nextImage();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                  ),
                  child: SwitchListTile(
                    title: Text(
                      'Vignette',
                      style: TextStyle(color: _textcolor, fontSize: 18),
                    ),
                    value: _vignette,
                    onChanged: (bool value) {
                      setState(() {
                        _vignette = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _vibration = false;
                          _sound = false;
                          _vignette = false;
                          _themeColor = Colors.blue;
                          _textcolor = Colors.blue;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(_themeColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: const Text(
                          'RESET ALL SETTINGS',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
