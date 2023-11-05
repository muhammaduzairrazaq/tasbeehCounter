import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TasbeehScreen extends StatefulWidget {
  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  // Initialize a list of Tasbeeh items
  List<Map<String, dynamic>> tasbeehItems = [
    {
      'tasbih_name': 'Tasbih 1',
      'total_set': 33,
      'current_count': 0,
      'set_completed': 0,
    },
    {
      'tasbih_name': 'Tasbih 2',
      'total_set': 33,
      'current_count': 0,
      'set_completed': 0,
    },
    // Add more items as needed
  ];

  // Function to show the add Tasbih dialog
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
                // Add a new Tasbih item to the list
                setState(() {
                  tasbeehItems.add({
                    'tasbih_name': tasbihName,
                    'total_set': tasbihSet,
                    'current_count': 0,
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

  // Function to show the undo Tasbih dialog
  void _showUndoTasbihDialog(Map<String, dynamic> deletedItem, int index) {
    final snackBar = SnackBar(
      content: Text('Tasbeeh Deleted!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Undo the delete
          setState(() {
            tasbeehItems.insert(index, deletedItem);
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              // Implement your settings logic here
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
            return Dismissible(
              key: Key(item['tasbih_name']),
              onDismissed: (direction) {
                // Keep a reference to the deleted item
                Map<String, dynamic> deletedItem = tasbeehItems[index];
                // Remove the item from the data source
                setState(() {
                  tasbeehItems.removeAt(index);
                });
                // Show the undo dialog
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
                    'Count: ${item['current_count']}/${item['total_set']} (${item['set_completed']})\nTotal: ${item['total_set'] * 100 + item['current_count']}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
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
}
