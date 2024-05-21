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

  final bool selected;

  // double digit formatter
  NumberFormat ddf = NumberFormat("00");

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

  CarouselElement(this.index, this.appstate, {super.key}) : selected = index == appstate.daySelectedIndex;

  @override
  Widget build(BuildContext context) {
    var outings = appstate.getOutingsForDay(appstate.daily![index].day);
    outings.sort((a, b) => a.start.hour.compareTo(b.start.hour));
    return Stack(
      clipBehavior: Clip.none,
      children: [
        //Main list tile:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              boxShadow: selected ? null : const [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 6, spreadRadius: 1, blurStyle: BlurStyle.outer)
              ],
              gradient: selected
                  ? const RadialGradient(
                      colors: [
                        Color.fromRGBO(253, 253, 253, 0.24), 
                        Color.fromRGBO(245, 245, 245, 0.19), 
                        Color.fromRGBO(223, 223, 223, 0.04),
                      ],
                      stops: [
                        0,
                        0.8,
                        1
                      ],
                      center: Alignment.topLeft,
                      radius: 0.99,
                    )
                  : const RadialGradient(
                      colors: [
                        Color.fromRGBO(223, 223, 223, 0.04),
                        Color.fromRGBO(245, 245, 245, 0.19), 
                        Color.fromRGBO(253, 253, 253, 0.24), 
                      ],
                      stops: [
                        0,
                        0.5,
                        1
                      ],
                      center: Alignment.topLeft,
                      radius: 0.99,
                    ),
            ),
            child: ListTile(onTap: () {
              appstate.selectDay(index);
            }),
          ),
        ),
        // Displaying day of the week & month date:
        Positioned(
          left: 20,
          top: 10,
          child: Text(
            DateFormat("E d").format(appstate.daily![index].day),
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        // Displaying predicted flag in top right corner:
        Positioned(
            right: 10,
            top: 10,
            child: flagIcons[
                appstate.estimateFlagColour(index)]!
            ),
        // Displaying symbol for day weather overview 
        Positioned(
            right: -5,
            bottom: -5,
            child: Image(
              image: AssetImage(
                  'assets/icons/${weatherToImage[appstate.daily![index].weather]}.png'),
              width: 70
            ),
        ),
        // Displaying which outings have been booked:
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
                          '${ddf.format(outing.start.hour)}:${ddf.format(outing.start.minute)} - ${ddf.format(outing.end.hour)}:${ddf.format(outing.end.minute)} Outing',
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      );
                    }).toList(),
                  )
                : Container(),
          ),
        ),
        
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
