import 'package:flutter/material.dart';
import 'sections/sidebar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isChecked = false;
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Sidebar(),
      body: Stack(children: <Widget>[
        Container(
          color: Colors.green,
          width: double.infinity,
        ),
        Positioned(
            left: 10,
            top: 20,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text('Settings', style: TextStyle(fontSize: 30)),
                ),
                Center(
                  child: Text('Notifications', style: TextStyle(fontSize: 24)),
                ),
                CheckboxListTile(
                  title: Text("Flag Colour Changes"),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  title: Text("Severe Weather Events"),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  title: Text("Change in Weather during Planned Outing"),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Divider(
                  color: const Color.fromARGB(255, 174, 19, 19),
                  height: 5,
                ),
                Center(
                  child: Text('Localization Settings',
                      style: TextStyle(fontSize: 24)),
                ),
                IntrinsicHeight(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Choose an option',
                              alignLabelWithHint: true,
                            ),
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['One', 'Two', 'Three', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                          CheckboxListTile(
                            title: Text("Checkbox 2"),
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          // Add more checkboxes as needed
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: Color.fromARGB(255, 0, 0, 0),
                      thickness: 3,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          CheckboxListTile(
                            title: Text("Checkbox 3"),
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: Text("Checkbox 4"),
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: Text("Checkbox 5"),
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          // Add more checkboxes as needed
                        ],
                      ),
                    ),
                  ],
                )),
                Divider(
                  color: const Color.fromARGB(255, 174, 19, 19),
                  height: 5,
                ),
                Center(
                  child:
                      Text('Account Settings', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Put your code here that will be executed when the button is pressed
                  },
                  child: Text('Click me'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Put your code here that will be executed when the button is pressed
                  },
                  child: Text('Click me'),
                )
              ],
            ))
      ]),
    );
  }
}
