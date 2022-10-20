// ignore_for_file: use_build_context_synchronously

import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:starwars_w2o/src/pages/home_page.dart';
import 'package:starwars_w2o/src/repository/people_requests.dart';
import 'package:starwars_w2o/src/utils/connectivity.dart';
import 'package:starwars_w2o/src/utils/navigator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String msg = 'Aguardando conexão...';
  bool notConnect = true;
  static const spinkit = SpinKitPouringHourGlassRefined(
    color: Color(0xffbb86fc),
    size: 50.0,
  );

  @override
  void initState() {
    super.initState();
    Timer.run(() => onload());
  }

  onload() async {
    if (await checkConnectivity() == true) {
      var resp = await PeopleRequests().getAllPeoples();
      to(context, HomePage(peoples: resp));
    } else {
      notConnect = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Image.asset(
                  'assets/images/starwars_logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            spinkit,
            const SizedBox(height: 20),
            Visibility(
                visible: notConnect,
                child: Text(
                  msg,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 5),
            Visibility(
              visible: notConnect,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Color(0xffbb86fc)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  onPressed: () => {onload()},
                  child: const SizedBox(
                    width: 175,
                    height: 25,
                    child: Center(
                        child: Text('Tentar novamente',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  )),
            )
          ],
        ));
  }
}
