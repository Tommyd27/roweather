import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sections/sidebar.dart';
import 'appstate.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Sidebar(),
      body: Stack(children: <Widget>[
        Container(
          color: const Color(0xFF436855),
          width: double.infinity,
        ),
        Positioned(
            left: 10,
            top: 20,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
            )),
        Consumer<AppState>(
            builder: (context, appstate, child) => Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text('Settings',
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Center(
                      child: Text('Notifications',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    CheckboxListTile(
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
                      color: Color.fromARGB(255, 0, 0, 0),
                      height: 5,
                    ),
                    const Center(
                      child: Text('Localization Settings',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    IntrinsicHeight(
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
                          color: Color.fromARGB(255, 0, 0, 0),
                          thickness: 3,
                        ),
                        Expanded(
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
                      color: Color.fromARGB(255, 0, 0, 0),
                      height: 5,
                    ),
                    const Center(
                      child: Text('Account Settings',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AppState>(context, listen: false)
                            .deleteOutings();
                      },
                      child: const Text('Delete Outing Data'),
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
                      child: const Text('Delete Account Data',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                )))
      ]),
    );
  }
}
