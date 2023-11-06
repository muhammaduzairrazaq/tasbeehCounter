import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _vibration = false;
  bool _sound = false;
  bool _vignette = false;
  MaterialColor _themeColor = Colors.orange;

  void _updateThemeColor(MaterialColor color) {
    setState(() {
      _themeColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
              // primarySwatch: Colors.orange,
                            primarySwatch: _themeColor,
                            // primaryColor: _themeColor,

      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tasbeeh Counter'),
        ),
        body: ListView(
          children: <Widget>[
            SwitchListTile(
              title: const Text('Vibration'),
              value: _vibration,
              onChanged: (bool value) {
                setState(() {
                  _vibration = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Sound'),
              value: _sound,
              onChanged: (bool value) {
                setState(() {
                  _sound = value;
                });
              },
            ),
            ListTile(
              title: const Text('Theme'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ColorButton(Colors.red, () => _updateThemeColor(Colors.red)),
                  ColorButton(Colors.purple, () => _updateThemeColor(Colors.purple)),
                  ColorButton(Colors.green, () => _updateThemeColor(Colors.green)),
                  ColorButton(Colors.orange, () => _updateThemeColor(Colors.orange)),
                  ColorButton(Colors.blue, () => _updateThemeColor(Colors.blue)),
                  ColorButton(Colors.lightGreen, () => _updateThemeColor(Colors.lightGreen)),
                  ColorButton(Colors.brown, () => _updateThemeColor(Colors.brown)),
                ],
              ),
            ),
            SwitchListTile(
              title: const Text('Vignette'),
              value: _vignette,
              onChanged: (bool value) {
                setState(() {
                  _vignette = value;
                });
              },
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _vibration = false;
                  _sound = false;
                  _vignette = false;
                  _themeColor = Colors.orange;
                });
              },
              child: const Text('RESET ALL SETTINGS', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final Function onPressed;

  ColorButton(this.color, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.circle, color: color),
      onPressed: (){},
    );
  }
}
