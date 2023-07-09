import 'package:flutter/material.dart';
import 'package:kids_reader_gpt/components/popup.dart';

void showPopup(BuildContext context, String message, {String? subtitle}) async {
  showDialog(context: context, builder: (context) => Popup(message, subtitle: subtitle,));
}
