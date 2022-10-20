import 'package:flutter/material.dart';

to(BuildContext context, Widget route) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => route), (r) => false);
}
