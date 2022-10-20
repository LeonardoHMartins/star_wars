// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starwars_w2o/src/models/people.dart';
import 'package:starwars_w2o/src/pages/splash_page.dart';
import 'package:starwars_w2o/src/repository/base_requests.dart';
import 'package:starwars_w2o/src/repository/people_requests.dart';

import 'package:starwars_w2o/src/pages/person_page.dart';
import 'package:starwars_w2o/src/utils/connectivity.dart';
import 'package:starwars_w2o/src/utils/navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.peoples});
  final dynamic peoples;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<People> listAllPersons = [];
  List<People> listPersons = [];
  bool loading = true;
  bool hasPrevious = false;
  bool hasNext = false;
  String? previous;
  String? next;
  Timer? timer;
  String msg = 'Aguarde...';

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Timer.run(() async => await onload());
  }

  onNext() async {
    loading = true;
    setState(() {});
    var resp = await BaseRequests().getSomething(next);
    listAllPersons = await PeopleRequests().trasformingPeoples(resp['results']);
    listPersons = listAllPersons;

    previous = resp['previous'];
    next = resp['next'];

    if (previous != null) {
      hasPrevious = true;
    } else {
      hasPrevious = false;
    }
    if (next != null) {
      hasNext = true;
    } else {
      hasNext = false;
    }

    loading = false;
    setState(() {});
  }

  onPrevious() async {
    loading = true;
    setState(() {});
    var resp = await BaseRequests().getSomething(previous);
    listAllPersons = await PeopleRequests().trasformingPeoples(resp['results']);
    listPersons = listAllPersons;

    previous = resp['previous'];
    next = resp['next'];

    if (previous != null) {
      hasPrevious = true;
    } else {
      hasPrevious = false;
    }
    if (next != null) {
      hasNext = true;
    } else {
      hasNext = false;
    }

    loading = false;
    setState(() {});
  }

  onload() async {
    if (await checkConnectivity() == false) {
      to(context, const SplashPage());
    } else {
      var resp;
      if (widget.peoples == null) {
        resp = await PeopleRequests().getAllPeoples();
      } else {
        resp = widget.peoples;
      }
      listAllPersons =
          await PeopleRequests().trasformingPeoples(resp['results']);
      listPersons = listAllPersons;

      previous = resp['previous'];
      next = resp['next'];

      if (previous != null) {
        hasPrevious = true;
      } else {
        hasPrevious = false;
      }
      if (next != null) {
        hasNext = true;
      } else {
        hasNext = false;
      }

      loading = false;
      setState(() {});
    }
  }

  search(value) async {
    if (timer != null) {
      timer?.cancel();
    }
    if (value == '') {
      listPersons = listAllPersons;
    } else {
      timer = Timer(
        const Duration(milliseconds: 150),
        () async {
          await searchPeoples(value);
        },
      );
    }
  }

  searchPeoples(value) async {
    loading = true;
    setState(() {});

    if (value == '') {
      listPersons = listAllPersons;
    } else {
      var peoples = await PeopleRequests().getPeople(value);
      listPersons =
          await PeopleRequests().trasformingPeoples(peoples['results']);

      previous = peoples['previous'];
      next = peoples['next'];

      if (previous != null) {
        hasPrevious = true;
      } else {
        hasPrevious = false;
      }
      if (next != null) {
        hasNext = true;
      } else {
        hasNext = false;
      }
    }
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'StarWars',
              style: TextStyle(fontSize: 25, color: Color(0xffbb86fc)),
            ),
            backgroundColor: const Color(0xff121212),
            elevation: 0,
            toolbarHeight: 50),
        body: Container(
          width: largura,
          height: altura,
          color: const Color(0xff212121),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    color: const Color(0xff121212),
                    width: largura,
                    height: 80,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                      child: TextField(
                        onChanged: (value) => search(value),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.search, color: Color(0xffbb86fc)),
                            prefixIconColor: Color(0xffbb86fc),
                            fillColor: Colors.black12,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffbb86fc))),
                            labelStyle: TextStyle(color: Color(0xffbb86fc)),
                            floatingLabelStyle:
                                TextStyle(color: Color(0xffbb86fc)),
                            labelText: 'Search'),
                      ),
                    )),
                Container(
                  width: largura,
                  height: 1,
                  color: Colors.black87,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: altura * 0.65,
                    child: loading
                        ? Center(
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(
                                color: Color(0xffbb86fc),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                msg,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
                        : ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listPersons.length,
                            itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: GestureDetector(
                                  onTap: () => to(context,
                                      PersonPage(people: listPersons[index])),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff373737),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 4,
                                              color: Colors.black54,
                                              offset: Offset(0, 0))
                                        ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              listPersons[index].name,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            const Icon(
                                              Icons.arrow_right,
                                              color: Color(0xffbb86fc),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                  ),
                ),
                loading
                    ? const SizedBox()
                    : ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          Visibility(
                            visible: hasPrevious,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Color(0xffbb86fc))),
                                onPressed: () => onPrevious(),
                                child: const Icon(Icons.arrow_left)),
                          ),
                          Visibility(
                            visible: hasNext,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Color(0xffbb86fc))),
                                onPressed: () => onNext(),
                                child: const Icon(Icons.arrow_right)),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ));
  }
}
