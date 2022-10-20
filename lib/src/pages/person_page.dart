// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:starwars_w2o/src/models/films.dart';
import 'package:starwars_w2o/src/models/people.dart';
import 'package:starwars_w2o/src/models/planets.dart';
import 'package:starwars_w2o/src/models/starships.dart';
import 'package:starwars_w2o/src/pages/films_page.dart';
import 'package:starwars_w2o/src/pages/home_page.dart';
import 'package:starwars_w2o/src/pages/splash_page.dart';
import 'package:starwars_w2o/src/repository/films_requests.dart';
import 'package:starwars_w2o/src/repository/planets_requests.dart';
import 'package:starwars_w2o/src/repository/starship_requests.dart';
import 'package:starwars_w2o/src/utils/connectivity.dart';
import 'package:starwars_w2o/src/utils/navigator.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key, required this.people});
  final People people;

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  Starships? personStarship;
  Planets? personPlanet;
  bool loading = false;
  List<Films> personFilms = [];
  String msg = 'Aguarde...';
  static const spinkit = SpinKitCircle(
    color: Color(0xffbb86fc),
    size: 50.0,
  );

  @override
  void initState() {
    super.initState();
    Timer.run(() async => await onload());
  }

  onload() async {
    if (await checkConnectivity() == false) {
      to(context, const SplashPage());
    } else {
      loading = true;
      setState(() {});
      await starship();
      await planet();
      await films();
      loading = false;
      setState(() {});
    }
  }

  starship() async {
    if (widget.people.starships.isNotEmpty) {
      var resp =
          await StarshipsRequests().getSomething(widget.people.starships.first);
      if (resp.isNotEmpty) {
        personStarship =
            await StarshipsRequests().trasformingStarships([resp]).first;
      }

      setState(() {});
    }
  }

  planet() async {
    if (widget.people.homeworld.isNotEmpty) {
      var resp = await PlanetsRequests().getSomething(widget.people.homeworld);
      if (resp.isNotEmpty) {
        personPlanet = await PlanetsRequests().trasformingPlanets([resp]).first;
      }
      setState(() {});
    }
  }

  films() async {
    for (var filme in widget.people.films) {
      var resp = await FilmsRequests().getSomething(filme);
      personFilms.add(FilmsRequests().trasformingFilms([resp]).first);
    }
    loading = false;
    setState(() {});
  }

  gender(String genero) {
    if (genero == 'male') {
      return 'Masculino';
    } else if (genero == 'female') {
      return 'Feminino';
    } else {
      return 'Desconhecido';
    }
  }

  planets(String planeta) {
    if (planeta == 'unknown') {
      return 'Desconhecido';
    } else {
      return planeta;
    }
  }

  terrain(String terreno) {
    if (terreno == 'unknown') {
      return 'Desconhecido';
    } else {
      return terreno;
    }
  }

  birth(String aniver) {
    if (aniver == 'unknown') {
      return 'Desconhecido';
    } else {
      return aniver;
    }
  }

  starshipname(String name) {
    if (name == 'unknown') {
      return 'Desconhecido';
    } else {
      return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                to(context, const HomePage());
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            'Personagem',
            style: TextStyle(fontSize: 25, color: Color(0xffbb86fc)),
          ),
          backgroundColor: const Color(0xff121212),
          elevation: 0,
          toolbarHeight: 130),
      body: WillPopScope(
        onWillPop: () async {
          to(context, const HomePage());
          return false;
        },
        child: loading
            ? Container(
                color: const Color(0xff212121),
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    spinkit,
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
                )))
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color(0xff212121),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Row(
                        children: [
                          const Text(
                            '- Nome: ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.people.name,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            '- Gênero: ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            gender(widget.people.gender),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            '- Ano de aniversário: ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            birth(widget.people.birth_year),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            '- Nome do planeta: ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            personPlanet != null
                                ? planets(personPlanet!.name)
                                : '',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '- Terreno do planeta: ',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Text(
                                personPlanet != null
                                    ? terrain(personPlanet!.terrain)
                                    : '',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            '- Nome da nave: ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            personStarship != null
                                ? starshipname(personStarship!.name)
                                : 'Desconhecido',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: const Center(
                              child: Text('Filmes',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xffbb86fc),
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: personFilms.length,
                            itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                    onTap: () => {
                                          to(
                                              context,
                                              FilmsPage(
                                                films: personFilms[index],
                                                people: widget.people,
                                              ))
                                        },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff373737),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 4,
                                                color: Colors.black54,
                                                offset: Offset(0, 0))
                                          ]),
                                      child: Text(
                                        personFilms[index].title,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    )))),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
