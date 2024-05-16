import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sections/sidebar.dart';
import 'appstate.dart';

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
  bool flagColourIsChecked = false;
  bool weatherEventsIsChecked = false;
  bool weatherChangeIsChecked = false;
  String languageDropdownValue = 'English';
  String timeZoneDropdownValue = 'BST';
  String speedDropDownValue = 'KM/H';
  String temperateDropDownValue = 'Celsius';
  String heightDropDownValue = 'Meters';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Sidebar(),
      body: Stack(children: <Widget>[
        Container(
          color: Color(0xFF436855),
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
                  child: Text('Settings',
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
                Center(
                  child: Text('Notifications',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
                CheckboxListTile(
                  title: Text("Flag Colour Changes",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  value: flagColourIsChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      flagColourIsChecked = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  title: Text("Severe Weather Events",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  value: weatherEventsIsChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      weatherEventsIsChecked = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  title: Text("Change in Weather during Planned Outing",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  value: weatherChangeIsChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      weatherChangeIsChecked = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Divider(
                  color: Color.fromARGB(255, 0, 0, 0),
                  height: 5,
                ),
                Center(
                  child: Text('Localization Settings',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
                IntrinsicHeight(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Container(
                                  color: Color(0xFF85B09A),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Language',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    dropdownColor: Color(0xFF85B09A),
                                    value: languageDropdownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    elevation: 16,
                                    alignment: Alignment.center,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        languageDropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'English',
                                      'American',
                                      'Canadian',
                                      'Australian'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ))),
                          Center(
                            child: Container(
                                color: Color(0xFF85B09A),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Timezone',
                                    alignLabelWithHint: true,
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  dropdownColor: Color(0xFF85B09A),
                                  value: timeZoneDropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  elevation: 16,
                                  alignment: Alignment.center,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      timeZoneDropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>['BST', 'UTC', 'GMT']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )),
                            // Add more checkboxes as needed
                          )
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
                          Center(
                              child: Container(
                                  color: Color(0xFF85B09A),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Speed',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    dropdownColor: Color(0xFF85B09A),
                                    value: speedDropDownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    elevation: 16,
                                    alignment: Alignment.center,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        speedDropDownValue = newValue!;
                                      });
                                    },
                                    items: <String>['KM/H', 'MPH']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ))),
                          Center(
                              child: Container(
                                  color: Color(0xFF85B09A),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Temperature',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    dropdownColor: Color(0xFF85B09A),
                                    value: temperateDropDownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    elevation: 16,
                                    alignment: Alignment.center,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        temperateDropDownValue = newValue!;
                                      });
                                    },
                                    items: <String>['Celsius', 'Fahrenheit']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ))),
                          Center(
                              child: Container(
                                  color: Color(0xFF85B09A),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Height',
                                      alignLabelWithHint: true,
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    dropdownColor: Color(0xFF85B09A),
                                    value: heightDropDownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    elevation: 16,
                                    alignment: Alignment.center,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        heightDropDownValue = newValue!;
                                      });
                                    },
                                    items: <String>['Meters', 'Feet']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ))),
                          // Add more checkboxes as needed
                        ],
                      ),
                    ),
                  ],
                )),
                Divider(
                  color: Color.fromARGB(255, 0, 0, 0),
                  height: 5,
                ),
                Center(
                  child: Text('Account Settings',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<AppState>(context, listen: false)
                        .deleteOutings();
                  },
                  child: Text('Delete Outing Data'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<AppState>(context, listen: false)
                        .deleteOutings();
                  },
                  child: Text('Delete Account Data'),
                )
              ],
            ))
      ]),
    );
  }
}
