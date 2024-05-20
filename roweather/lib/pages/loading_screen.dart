import 'package:flutter/material.dart'; //import packages
import 'homepage.dart';

//loading screen widget
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

//state for loading screen
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  //init state
  void initState() {
    super.initState();
    // Navigate to home page after 5 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Roweather')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //return page content
      body: Container(
        decoration: BoxDecoration(
          //background image
          image: DecorationImage(
            image: AssetImage('assets/loading_backdrop.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          //center the roweather text and icon
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Roweather',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30), //add spacing
              Image.asset('assets/roweather_logo.png'),
              SizedBox(height: 30),
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Positioned(
                  //add finding weather data text
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Finding weather data...',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
