import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.forecast});
  final forecast;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int tempTypeInt;
  int condition;
  String city;
  String icon;
  String message;

  @override
  void initState() {
    super.initState();
    updateUI(widget.forecast);
  }

  void updateUI(dynamic forecast) {
    setState(() {

      if(forecast == null) {
        tempTypeInt = null;
        condition = null;
        city = null;
        message = null;
        icon = null;
        return;
      }

      double tempTypeDouble = forecast['main']['temp'];
      tempTypeInt = tempTypeDouble.toInt();
      condition = forecast['weather'][0]['id'];
      city = forecast['name'];

      message =  weather.getMessage(tempTypeInt);
      icon = weather.getWeatherIcon(condition);
    });
    print('Finished updating');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var currentForecast = await weather.getForecast();
                      updateUI(currentForecast);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempTypeInt°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '️$icon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
