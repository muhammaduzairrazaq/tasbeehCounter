import 'package:flutter/material.dart';
import 'app_theme.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _vibration = false;
  bool _sound = false;
  bool _vignette = false;
  int _currentImageIndex = 0;

  List<Color> themeColors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.black,
    Colors.pink,
    Colors.tealAccent,
  ];

  void updateThemeColor(Color color) async {
    setState(() {
      AppTheme.updateThemeColor(color);
    });
  }

  List<String> imagePaths = [
    'assets/tbk1.png',
    'assets/tbk2.png',
    'assets/tbk3.png',
  ];

  void nextImage() {
    setState(() {
      if (_currentImageIndex < imagePaths.length - 1) {
        _currentImageIndex++;
        BackgroundImage.updateBackgroundImage(imagePaths[_currentImageIndex]);
      } else {
        _currentImageIndex = 0;
        BackgroundImage.updateBackgroundImage(imagePaths[_currentImageIndex]);
      }
    });
  }

  void previousImage() {
    setState(() {
      if (_currentImageIndex > 0) {
        _currentImageIndex--;
        BackgroundImage.updateBackgroundImage(imagePaths[_currentImageIndex]);
      } else {
        _currentImageIndex = imagePaths.length - 1;
        BackgroundImage.updateBackgroundImage(imagePaths[_currentImageIndex]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.textcolor,
          title: Text(
            'Tasbeeh Counter',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              imagePaths[_currentImageIndex],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: const Color.fromARGB(255, 87, 87, 87).withOpacity(0.8),
              width: double.infinity,
              height: double.infinity,
            ),
            ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 2.0)),
                  ),
                  child: SwitchListTile(
                    title: Text(
                      'Vibration',
                      style: TextStyle(color: AppTheme.textcolor, fontSize: 18),
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
                      style: TextStyle(color: AppTheme.textcolor, fontSize: 18),
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
                      style: TextStyle(color: AppTheme.textcolor, fontSize: 18),
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
                  height: 48.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: AppTheme.textcolor),
                            onPressed: () {
                              previousImage();
                            },
                          ),
                          Text(
                            'Image Background',
                            style: TextStyle(
                                color: AppTheme.textcolor, fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward,
                                color: AppTheme.textcolor),
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
                      style: TextStyle(color: AppTheme.textcolor, fontSize: 18),
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
                          AppTheme.textcolor = Colors.green;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.textcolor),
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
