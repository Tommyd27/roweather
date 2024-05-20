import 'package:demo/pages/sections/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appstate.dart';
import 'package:intl/intl.dart';
import '../../helper/weather.dart';

class NextDaysCarousel extends StatefulWidget {
  const NextDaysCarousel({super.key});

  @override
  State<NextDaysCarousel> createState() => _NextDaysCarouselState();
}

/**
 * Widget for one element of the carousel
 */
class CarouselElement extends StatelessWidget {
  // Stores the index of appstate.daily of this carousel element
  final int index;
  // Copy of the current appstate, passed down from parent Carousel widget
  final AppState appstate;

  // Mapping from the FlagColour state to the icon displayed
  static const Map<FlagColour, Widget> flagIcons = {
    FlagColour.green: Icon(
      Icons.flag,
      color: Colors.green,
    ),
    FlagColour.yellow: Icon(Icons.flag, color: Colors.yellow),
    FlagColour.red: Icon(Icons.flag, color: Colors.red),
    FlagColour.unknown: Text(
      'No flag data',
      style: TextStyle(color: Colors.white, fontSize: 12),
    ),
  };

  // Mapping from the weather state to the image displayed
  static const Map<Weather, String> weatherToImage = {
    Weather.sunny: "sunny",
    Weather.partialCloudy: "partialCloudy",
    Weather.fullCloudy: "fullCloudy",
    Weather.rainy: "rainy",
  };

  CarouselElement(this.index, this.appstate, {super.key});

  @override
  Widget build(BuildContext context) {
    var outings = appstate.getOutingsForDay(appstate.daily![index].day);
    outings.sort((a, b) => a.start.hour.compareTo(b.start.hour));
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xff85B09A).withOpacity(0.30),
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              gradient: (appstate.daySelectedIndex == index)
                  ? RadialGradient(
                      colors: [const Color(0xff85B09A), Colors.grey.shade900],
                      center: Alignment.center,
                      radius: 0.99,
                    )
                  : null,
            ),
            child: ListTile(onTap: () {
              appstate.selectDay(index);
            }),
          ),
        ),
        Positioned(
          left: 20,
          top: 10,
          child: Text(
            DateFormat("E d").format(appstate.daily![index].day),
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: flagIcons[
                appstate.flagColour]! // TODO: Change to flag colour prediction
            ),
        Positioned(
          left: 10,
          top: 40,
          child: Align(
            alignment: Alignment.topCenter,
            child: outings.isNotEmpty
                ? Column(
                    children: outings.take(2).map((outing) {
                      return Container(
                        padding: EdgeInsets.all(1.0),
                        margin: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: Color(0xffEFD9CE),
                          border: Border.all(color: Color(0xffEFD9CE)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${outing.start.hour} - ${outing.end.hour} Outing',
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      );
                    }).toList(),
                  )
                : Container(),
          ),
        ),
        Positioned(
            right: -5,
            bottom: -5,
            child: Image(
                image: AssetImage(
                    'assets/icons/${weatherToImage[appstate.daily![index].weather]}.png'),
                width: 70))
      ],
    );
  }
}

/**
 * Widget for the entire carousel
 */
class _NextDaysCarouselState extends State<NextDaysCarousel> {
  @override
  Widget build(BuildContext context) => Consumer<AppState>(
      builder: (context, appstate, child) {
        if (appstate.daily == null) return const CircularProgressIndicator();
        return ListView.builder(
            itemExtent: 150.0,
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            itemCount: appstate.daily!.length,
            itemBuilder: (BuildContext context, int index) =>
                CarouselElement(index, appstate),
          );
      }
  );
}
