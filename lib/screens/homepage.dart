import 'package:covid_19_app/screens/search_screen.dart';
import 'package:covid_19_app/screens/splash_screen.dart';
import 'package:covid_19_app/services/stats_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> info = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: FutureBuilder(
            future: statsServices.getWorldStats(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text("Total Cases"),
                              trailing: Text('${snapshot.data['cases']}'),
                            ),
                            ListTile(
                              title: const Text("Deaths"),
                              trailing: Text('${snapshot.data['deaths']}'),
                            ),
                            ListTile(
                              title: const Text("Recovered"),
                              trailing: Text('${snapshot.data['recovered']}'),
                            ),
                            ListTile(
                              title: const Text("Active"),
                              trailing: Text('${snapshot.data['active']}'),
                            ),
                            ListTile(
                              title: const Text("Critical"),
                              trailing: Text('${snapshot.data['critical']}'),
                            ),
                            ListTile(
                              title: const Text("Today Deaths"),
                              trailing: Text('${snapshot.data['todayDeaths']}'),
                            ),
                            ListTile(
                              title: const Text("Today Recovered"),
                              trailing:
                                  Text('${snapshot.data['todayRecovered']}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const SearchScreen())));
                          },
                          child: const Text(
                            "Track Countries",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
