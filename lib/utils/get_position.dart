// Define an extension on GlobalKey
import 'package:flutter/material.dart';

extension GlobalKeyExtension on GlobalKey {
  // Define a method to get the widget rect
  Rect? getWidgetRect() {
    // Get the render box of the widget
    final RenderBox? renderBox = currentContext?.findRenderObject() as RenderBox?;
    // If the render box is not null, return a Rect object with the size and offset
    if (renderBox != null) {
      final Size size = renderBox.size;
      final Offset offset = renderBox.localToGlobal(Offset.zero);
      return Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
    }
    // Otherwise, return null
    return null;
  }
}
