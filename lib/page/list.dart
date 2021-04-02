import 'package:flutter/material.dart';
import 'package:radio_app/page/screen.dart';
import 'package:radio_app/source/media_source.dart';

class RadioListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RadioPlayerScreen(
      playlist: mediasrc[0]['source'],
    );
  }
}
