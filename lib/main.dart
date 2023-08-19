import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:rewa/Model/CurrentCityDateModel.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<CurrentCityDateModel> currentweatherfuture;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentweatherfuture = sendrequstcurrentweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        elevation: 5,
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return {'setting', 'logout'}.map(
                (String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                },
              ).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<CurrentCityDateModel>(
        future: currentweatherfuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/sky.jpg'),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('find'),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                  hintText: "enter a city name",
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          snapshot.data?.country ?? "emty",
                          style: TextStyle(
                              color: Colors.blueGrey[900],
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: Text(
                          snapshot.data?.main ?? '',
                          style: TextStyle(
                              color: Colors.blueGrey[900],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.amber[900],
                          size: 90,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "${snapshot.data?.temp}" "\u00B0",
                          style: TextStyle(
                              color: Colors.blueGrey[900], fontSize: 80),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "MAX",
                                style: TextStyle(color: Colors.deepOrange[900]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${snapshot.data?.temp_max ?? 'emty'}"
                                  "\u00B0",
                                  style:
                                      TextStyle(color: Colors.deepOrange[900]),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 2,
                              height: 40,
                              color: Colors.blueGrey[900],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: [
                                Text(
                                  "MIN",
                                  style: TextStyle(color: Colors.cyan[900]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "${snapshot.data?.temp_min ?? 'empty'}"
                                    "\u00B0",
                                    style: TextStyle(color: Colors.cyan[900]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.blueGrey[900],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.cyan.withOpacity(0.2),
                        child: ListView.builder(
                          itemCount: 8,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext contxt, int pos) {
                            return SizedBox(
                              width: 70,
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      snapshot.data?.main ?? "empty",
                                      style: TextStyle(
                                          color: Colors.blueGrey[900]),
                                    ),
                                    Icon(
                                      Icons.cloudy_snowing,
                                      color: Colors.blueGrey[900],
                                      size: 30,
                                    ),
                                    Text(
                                      "${snapshot.data?.temp ?? "empty"}"
                                      "\u00B0",
                                      style: TextStyle(
                                          color: Colors.blueGrey[900],
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.blueGrey[900],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          color: Colors.yellow.withOpacity(0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'wind speed',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${snapshot.data?.windspeed ?? "empty"}',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 2,
                                  height: 40,
                                  color: Colors.blueGrey[900],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'sunrise',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${snapshot.data?.sunrise ?? "empty"}',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 2,
                                  height: 40,
                                  color: Colors.blueGrey[900],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'sunset',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${snapshot.data?.sunset ?? "empty"}',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 2,
                                  height: 40,
                                  color: Colors.blueGrey[900],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'himidity',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${snapshot.data?.humidity ?? "empty"}',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.blueGrey[900],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Weather - Local Climate° Weather.',
                          style: TextStyle(
                            color: Colors.blueGrey[900],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: JumpingDotsProgressIndicator(
                color: Colors.black,
                fontSize: 60,
                dotSpacing: 2,
              ),
            );
          }
        },
      ),
    );
  }
}

// class MyApp2 extends StatelessWidget {
//   const MyApp2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
Future<CurrentCityDateModel> sendrequstcurrentweather() async {
  late CurrentCityDateModel detamodel;
  try {
    var apikey = 'a9f319debe9a666a314af5c8c3904b2c';
    var cityname = "Tehran";
    var response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {'q': cityname, 'appid': apikey, 'units': 'metric'});

    detamodel = CurrentCityDateModel(
        'cityname',
        response.data["coord"]["lon"],
        response.data["coord"]["lat"],
        response.data['weather'][0]['main'],
        response.data['weather'][0]['description'],
        response.data['main']['temp'],
        response.data['main']['temp_min'],
        response.data['main']['temp_max'],
        response.data['main']['pressure'],
        response.data['main']['humidity'],
        response.data['wind']['speed'],
        response.data['dt'],
        response.data['sys']['country'],
        response.data['sys']['sunrise'],
        response.data['sys']['sunset']);
  } catch (e) {
    emptyTextSelectionControls;
  }

  return detamodel;
}
