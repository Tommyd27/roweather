import 'package:demo/pages/homepage.dart';
import 'package:flutter/material.dart'; //imports
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sections/sidebar.dart';
import 'appstate.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

//settings page
class _SettingsPageState extends State<SettingsPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(children: <Widget>[
        Container(
          color: const Color(0xFF436855), //background color
          width: double.infinity,
        ),
        Positioned(
            left: 10,
            top: 20, //nav menu
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Roweather'))),
            )),
        Consumer<AppState>(
            builder: (context, appstate, child) => Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Center(
                      //centered settings text
                      child: Text('Settings',
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Center(
                      //notifaction settings
                      child: Text('Notifications',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    CheckboxListTile(
                      //checkbox for flag colour
                      title: const Text("Flag Colour Changes",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      value: appstate.settings.notifyFlagColour,
                      onChanged: (bool? value) {
                        appstate.settings.notifyFlagColour = value!;
                        appstate.notifyListeners();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      //checkbox for weather events
                      title: const Text("Severe Weather Events",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      value: appstate.settings.notifyWeatherEvents,
                      onChanged: (bool? value) {
                        appstate.settings.notifyWeatherEvents = value!;
                        appstate.notifyListeners();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      //checkbox for weather changes
                      title: const Text(
                          "Change in Weather during Planned Outing",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      value: appstate.settings.notifyWeatherChange,
                      onChanged: (bool? value) {
                        appstate.settings.notifyWeatherChange = value!;
                        appstate.notifyListeners();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const Divider(
                      //divider
                      color: Color.fromARGB(255, 0, 0, 0),
                      height: 5,
                    ),
                    const Center(
                      //centered localization settings
                      child: Text('Localization Settings',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    IntrinsicHeight(
                        //drop down menu for language, timezone, speed, temperature, and height
                        child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Center(
                                  child: Container(
                                      color: const Color(0xFF85B09A),
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          labelText: 'Language',
                                          alignLabelWithHint: true,
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        dropdownColor: const Color(0xFF85B09A),
                                        value: appstate.settings.language,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        elevation: 16,
                                        alignment: Alignment.center,
                                        onChanged: (String? newValue) {
                                          appstate.settings.language =
                                              newValue!;
                                          appstate.notifyListeners();
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
                                //centered timezone
                                child: Container(
                                    color: const Color(0xFF85B09A),
                                    child: DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(
                                        labelText: 'Timezone',
                                        alignLabelWithHint: true,
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      dropdownColor: const Color(0xFF85B09A),
                                      value: appstate.settings.timeZone,
                                      icon: const Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      elevation: 16,
                                      alignment: Alignment.center,
                                      onChanged: (String? newValue) {
                                        appstate.settings.timeZone = newValue!;
                                        appstate.notifyListeners();
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
                              )
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          //vertical divider
                          color: Color.fromARGB(255, 0, 0, 0),
                          thickness: 3,
                        ),
                        Expanded(
                          //expanded column
                          child: Column(
                            children: <Widget>[
                              Center(
                                  child: Container(
                                      color: const Color(0xFF85B09A),
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          labelText: 'Speed',
                                          alignLabelWithHint: true,
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        dropdownColor: const Color(0xFF85B09A),
                                        value: appstate.settings.unitSpeed,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        elevation: 16,
                                        alignment: Alignment.center,
                                        onChanged: (String? newValue) {
                                          appstate.settings.unitSpeed =
                                              newValue!;
                                          appstate.notifyListeners();
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
                                      color: const Color(0xFF85B09A),
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          labelText: 'Temperature',
                                          alignLabelWithHint: true,
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        dropdownColor: const Color(0xFF85B09A),
                                        value:
                                            appstate.settings.unitTemperature,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        elevation: 16,
                                        alignment: Alignment.center,
                                        onChanged: (String? newValue) {
                                          appstate.settings.unitTemperature =
                                              newValue!;
                                          appstate.notifyListeners();
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
                                      color: const Color(0xFF85B09A),
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          labelText: 'Height',
                                          alignLabelWithHint: true,
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        dropdownColor: const Color(0xFF85B09A),
                                        value: appstate.settings.unitHeight,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        elevation: 16,
                                        alignment: Alignment.center,
                                        onChanged: (String? newValue) {
                                          appstate.settings.unitHeight =
                                              newValue!;
                                          appstate.notifyListeners();
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
                            ],
                          ),
                        ),
                      ],
                    )),
                    const Divider(
                      //divider
                      color: Color.fromARGB(255, 0, 0, 0),
                      height: 5,
                    ),
                    const Center(
                      //centered account settings
                      child: Text('Account Settings',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                      //delete outing data button
                      onPressed: () {
                        Provider.of<AppState>(context, listen: false)
                            .deleteOutings();
                      },
                      child: const Text('Delete Outing Data'),
                    ),
                    ElevatedButton(
                      //delete account data button
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Provider.of<AppState>(context, listen: false)
                            .deleteOutings();
                      },
                      child: const Text('Delete Account Data',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                )))
      ]),
    );
  }
}
