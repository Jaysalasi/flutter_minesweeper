import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NumberBox extends StatelessWidget {
  // const NumberBox({
  //   Key? key,
  // }) : super(key: key);

  final child;
  bool revealed;
  // ignore: prefer_typing_uninitialized_variables
  final function;

  NumberBox({super.key, this.child, required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.grey[300] : Colors.grey[100],
          child: Center(
            child: Text(
              revealed ? (child == 0 ? '' : child.toString()) : '',
              style: TextStyle(
                color: child == 1
                    ? Colors.blue
                    : (child == 2 ? Colors.green : Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
