import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/settingscreen.dart';
import 'tasbeeh_counter_screen.dart';

class TasbeehScreen extends StatefulWidget {
  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  List<Map<String, dynamic>> tasbeehItems = [
    {
      'tasbih_name': 'SubhanAllah',
      'total_set': 33,
      'current_count': 0,
      'total_count': 0,
      'set_completed': 0,
    },
    {
      'tasbih_name': 'Alhamdulillah',
      'total_set': 33,
      'current_count': 0,
      'total_count': 0,
      'set_completed': 0,
    },
    {
      'tasbih_name': 'Bismillah',
      'total_set': 33,
      'current_count': 0,
      'total_count': 0,
      'set_completed': 0,
    },
    {
      'tasbih_name': 'Ayate Karima',
      'total_set': 33,
      'current_count': 0,
      'total_count': 0,
      'set_completed': 0,
    },
    {
      'tasbih_name': 'AstaghfirAllah',
      'total_set': 33,
      'current_count': 0,
      'total_count': 0,
      'set_completed': 0,
    },
  ];

  bool cardClicked = false;

  Future<void> _showAddTasbihDialog() async {
    String tasbihName = '';
    int tasbihSet = 0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Tasbih'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: 'Enter Tasbih Name'),
                onChanged: (value) {
                  tasbihName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter Tasbih Set'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  tasbihSet = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasbeehItems.add({
                    'tasbih_name': tasbihName,
                    'total_set': tasbihSet,
                    'current_count': 0,
                    'total_count': 0,
                    'set_completed': 0,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Tasbeeh Counter',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/lb.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(40),
        child: ListView.builder(
          itemCount: tasbeehItems.length,
          itemBuilder: (context, index) {
            final item = tasbeehItems[index];
            return GestureDetector(
              onTap: () {
                if (!cardClicked) {
                  _navigateToTasbeehCounterScreen(item, index);
                }
                cardClicked = false;
              },
              child: Dismissible(
                key: Key(item['tasbih_name']),
                onDismissed: (direction) {
                  Map<String, dynamic> deletedItem = tasbeehItems[index];
                  setState(() {
                    tasbeehItems.removeAt(index);
                  });
                  _showUndoTasbihDialog(deletedItem, index);
                },
                child: Card(
                  color: Colors.grey[700],
                  margin: EdgeInsets.only(bottom: 30),
                  child: ListTile(
                    title: Text(
                      '${item['tasbih_name']}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    trailing: Text(
                      'Count: ${item['current_count']}/${item['total_set']} (${item['set_completed']})\nTotal: ${item['total_count']}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTasbihDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showUndoTasbihDialog(Map<String, dynamic> deletedItem, int index) {
    final snackBar = SnackBar(
      content: Text('Tasbeeh Deleted!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            tasbeehItems.insert(index, deletedItem);
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToTasbeehCounterScreen(
      Map<String, dynamic> tasbeehItem, int index) async {
    final updatedData = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TasbeehCounter(item: tasbeehItem, index: index),
      ),
    );

    if (updatedData != null) {
      setState(() {
        tasbeehItems[index]['current_count'] =
            updatedData['updatedItem']['current_count'];
        tasbeehItems[index]['total_count'] =
            updatedData['updatedItem']['total_count'];
        tasbeehItems[index]['set_completed'] =
            updatedData['updatedItem']['set_completed'];
      });
    }
  }
}
