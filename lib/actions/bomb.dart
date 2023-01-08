import 'package:flutter/material.dart';

class Bomb extends StatelessWidget {
  // const NumberBox({
  //   Key? key,
  // }) : super(key: key);

  // final child;
  bool revealed;
  final function;

  Bomb({super.key, required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.grey : Colors.grey[100],
        ),
      ),
    );
  }
}
