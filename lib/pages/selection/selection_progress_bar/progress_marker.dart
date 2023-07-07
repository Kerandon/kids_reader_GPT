import 'package:flutter/material.dart';

class ProgressMarker extends StatelessWidget {
  const ProgressMarker(
    this.index, this.isSelected, {
    super.key,
  });

  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.06,
      height: size.width * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: isSelected ? Colors.amber : Colors.grey,
      ),
      child: Center(child: Text(index.toString(), style: Theme.of(context).textTheme.displaySmall,)),
    );
  }
}
