import 'package:covid_19_app/screens/detail_screen.dart';
import 'package:covid_19_app/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode _focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                _focusNode.unfocus();
              },
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                    suffixIcon: searchController.text.isEmpty
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              searchController.clear();
                              setState(() {});
                            },
                            child: const Icon(Icons.clear)),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Search with country name",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statsServices.getCountryStats(),
                    builder: ((context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) {
                              String name = snapshot.data[index]['country'];

                              if (searchController.text.isEmpty) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    DetailScreen(
                                                        countryData: snapshot
                                                            .data[index]))));
                                      },
                                      child: ListTile(
                                        leading: Image(
                                            width: 50,
                                            height: 50,
                                            image: NetworkImage(
                                                snapshot.data[index]
                                                    ['countryInfo']['flag'])),
                                        title: Text(
                                            "${snapshot.data[index]['country']}"),
                                        subtitle: Text(
                                            "${snapshot.data[index]['cases']}"),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  DetailScreen(
                                                      countryData: snapshot
                                                          .data[index]))));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                          width: 50,
                                          height: 50,
                                          image: NetworkImage(
                                              snapshot.data[index]
                                                  ['countryInfo']['flag'])),
                                      title: Text(
                                          "${snapshot.data[index]['country']}"),
                                      subtitle: Text(
                                          "${snapshot.data[index]['cases']}"),
                                    ),
                                  ),
                                ]);
                              } else {
                                return Container();
                              }
                            }));
                      }
                    })))
          ],
        ),
      ),
    );
  }
}
