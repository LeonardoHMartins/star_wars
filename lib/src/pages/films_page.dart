// ignore_for_file: prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:starwars_w2o/src/models/films.dart';
import 'package:starwars_w2o/src/models/people.dart';
import 'package:starwars_w2o/src/pages/person_page.dart';
import 'package:starwars_w2o/src/utils/navigator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FilmsPage extends StatefulWidget {
  const FilmsPage({super.key, required this.films, required this.people});
  final Films films;
  final People people;

  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  bool loading = false;
  static const spinkit = SpinKitCircle(
    color: Color(0xffbb86fc),
    size: 50.0,
  );

  image(image) {
    if (widget.films.title == 'A New Hope') {
      return 'assets/images/a_new_hope.jpg';
    } else if (widget.films.title == 'The Empire Strikes Back') {
      return 'assets/images/the_empire.jpg';
    } else if (widget.films.title == 'Return of the Jedi') {
      return 'assets/images/return_of_the_jedi.jpg';
    } else if (widget.films.title == 'The Phantom Menace') {
      return 'assets/images/the_phantom_menace.jpg';
    } else if (widget.films.title == 'Attack of the Clones') {
      return 'assets/images/attack_of_the_clones.jpg';
    } else if (widget.films.title == 'Revenge of the Sith"') {
      return 'assets/images/revenge_of_the_sith.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  to(context, PersonPage(people: widget.people));
                },
                icon: const Icon(Icons.arrow_back)),
            title: Text(
              widget.people.name,
              style: const TextStyle(fontSize: 25, color: Color(0xffbb86fc)),
            ),
            backgroundColor: const Color(0xff121212),
            elevation: 0,
            toolbarHeight: 130),
        body: WillPopScope(
            onWillPop: () async {
              to(context, PersonPage(people: widget.people));
              return false;
            },
            child: loading
                ? Container(
                    color: const Color(0xff212121),
                    child: Center(
                        child: Column(
                      children: [
                        spinkit,
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Aguarde...',
                          style: TextStyle(
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
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: Image.asset(image(widget.films.title)),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
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
                                widget.films.title,
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
                                '- Diretor: ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.films.director,
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
                                '- Lançamento: ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.films.release_date,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '- Produtores: ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                child: Text(
                                  widget.films.producer,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))));
  }
}
