import 'package:flutter/material.dart';
import 'package:kids_reader_gpt/configs/constants.dart';

class Popup extends StatelessWidget {
  const Popup(this.title, {this.subtitle, Key? key, required})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      content: subtitle == null ? null : Text(
        subtitle!,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
