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
    const Color.fromARGB(255, 37, 37, 37),
    Colors.pink,
    Colors.deepOrange,
  ];

  void updateThemeColor(Color color) async {
    setState(() {
      AppTheme.updateThemeColor(color);
    });
  }

  List<String> imagePaths = [
    'assets/nnldb.png',
    'assets/n1.png',
    'assets/mosn.png',
    'assets/mosn2.png',
    'assets/mosn3.png',
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
              color: const Color.fromARGB(255, 87, 87, 87).withOpacity(AppTheme.opacity),
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
                    activeColor: AppTheme.textcolor,
                    title: Text(
                      'Vibration',
                      style: TextStyle(color: AppTheme.textcolor, fontSize: 18),
                    ),
                    value: _vibration,
                    onChanged: (bool value) {
                      setState(() {
                        _vibration = value;
                        AppTheme.vibrate = value;
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
                    activeColor: AppTheme.textcolor,
                    title: Text(
                      'Sound',
                      style: TextStyle(color: AppTheme.textcolor, fontSize: 18),
                    ),
                    value: _sound,
                    onChanged: (bool value) {
                      setState(() {
                        _sound = value;
                        AppTheme.sound = value;
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
                    activeColor: AppTheme.textcolor,
                    title: Text(
                      'Vignette',
                      style: TextStyle(color: AppTheme.textcolor, fontSize: 18),
                    ),
                    value: _vignette,
                    onChanged: (bool value) {
                      setState(() {
                        _vignette = value;
                        if (_vignette==false) {
                          AppTheme.updateOpacity(0.8);
                        }
                        else {
                          AppTheme.updateOpacity(0.6);
                        }
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
                          AppTheme.textcolor = const Color.fromARGB(255, 37, 37, 37);
                          _currentImageIndex = 0;
                          AppTheme.updateOpacity(0.8);
                          AppTheme.sound=false;
                          AppTheme.vibrate=false;
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
