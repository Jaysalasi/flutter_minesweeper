// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:minesweeper/actions/bomb.dart';
import 'package:flutter/material.dart';

import '../actions/number_box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variables
  int numOfSqr = 9 * 9;
  int numInEachRow = 9;

  var squareStatus = []; // num of bombs around , reveraled = true or false;

  // bomb locations

  final list = List.generate(10, (_) => Random().nextInt(60));

  late final List<int> bombLocation = list;
  // 1,
  // 4,
  // 6,
  // 12,
  // 20,
  // 32,
  // 40,
  // 48,
  // 50,
  // 55,
  // 61,
  // 70,
  // 79,

  bool bombsRevealed = false;

  @override
  void initState() {
    super.initState();
    // list;
    //initially each square has 0 bombs around, and is not revealed
    for (int i = 0; i < numOfSqr; i++) {
      squareStatus.add([0, false]);
    }
    scanBombs();
  }

// restart game
  void restartGame() {
    setState(() {
      bombsRevealed = false;
      for (int i = 0; i < numOfSqr; i++) {
        squareStatus[i][1] = false;
      }
      list;
    });
  }

//player won
  void playerWon() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: Center(
                child: Text(
              'You Win',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            )),
            actions: [
              MaterialButton(
                  child: Text(
                    'Restart Game',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    restartGame();
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  // check win
  void checkWin() {
    //check how many boxes yet to be revealed
    int unRevealedBoxes = 0;
    for (int i = 0; i < numOfSqr; i++) {
      if (squareStatus[i][1] == false) {
        unRevealedBoxes++;
      }
    }
    if (unRevealedBoxes == bombLocation.length) {
      playerWon();
    }
  }

  //show box numbers on tap
  void revealBoxNumbers(int index) {
    //reveal current box if it is a number: 1, 2, 3 etc...
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    }

    // if current box is 0
    else if (squareStatus[index][0] == 0) {
      // reveal current box, and the 8 surrounding boxes, unless you're on a wall;
      setState(() {
        squareStatus[index][1] = true;

        // reveal left box unless currently on the left wall;
        if (index % numInEachRow != 0) {
          // if next box is not revealed yet and it is a 0, then recurse;
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1);
          }

          // reveal left box
          squareStatus[index - 1][1] = true;
        }

        // reveal top left box unless currently on the left wall;
        if (index % numInEachRow != 0 && index >= numInEachRow) {
          // if next box is not revealed yet and it is a 0, then recurse;
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1 - numInEachRow);
          }

          squareStatus[index - 1 - numInEachRow][1] = true;
        }

        // reveal top box right unless currently on the left wall;
        if (index >= numInEachRow) {
          // if next box is not revealed yet and it is a 0, then recurse;
          if (squareStatus[index - numInEachRow][0] == 0 &&
              squareStatus[index - numInEachRow][1] == false) {
            revealBoxNumbers(index - numInEachRow);
          }

          squareStatus[index - numInEachRow][1] = true;
        }

        // reveal top right right unless currently on the left wall;
        if (index >= numInEachRow && index % numInEachRow != numInEachRow - 1) {
          // if next box is not revealed yet and it is a 0, then recurse;
          if (squareStatus[index + 1 - numInEachRow][0] == 0 &&
              squareStatus[index + 1 - numInEachRow][1] == false) {
            revealBoxNumbers(index + 1 - numInEachRow);
          }

          squareStatus[index + 1 - numInEachRow][1] = true;
        }

        // reveal right unless currently on the left wall;
        if (index % numInEachRow != numInEachRow - 1) {
          // if next box is not revealed yet and it is a 0, then recurse;
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumbers(index + 1);
          }

          squareStatus[index + 1][1] = true;
        }

        // reveal bottom right unless currently on the left wall;
        if (index < numOfSqr - numInEachRow &&
            index % numInEachRow != numInEachRow - 1) {
          // if next box is not revealed yet and it is a 0, then recurse;
          if (squareStatus[index + 1 + numInEachRow][0] == 0 &&
              squareStatus[index + 1 + numInEachRow][1] == false) {
            revealBoxNumbers(index + 1 + numInEachRow);
          }

          squareStatus[index + 1 + numInEachRow][1] = true;
        }

        // reveal bottom  unless currently on the left wall;
        if (index < numOfSqr - numInEachRow) {
          // if next box is not revealed yet and it is a 0, then recurse;
          if (squareStatus[index + numInEachRow][0] == 0 &&
              squareStatus[index + numInEachRow][1] == false) {
            revealBoxNumbers(index + numInEachRow);
          }

          squareStatus[index + numInEachRow][1] = true;
        }

        // reveal bottom left unless currently on the left wall;
        if (index < numOfSqr - numInEachRow && index % numInEachRow != 0) {
          // if next box is not revealed yet and it is a 0, then recurse;
          if (squareStatus[index - 1 + numInEachRow][0] == 0 &&
              squareStatus[index - 1 + numInEachRow][1] == false) {
            revealBoxNumbers(index - 1 + numInEachRow);
          }

          squareStatus[index - 1 + numInEachRow][1] = true;
        }
      });
    }
  }

  // scan bombs
  void scanBombs() {
    for (int i = 0; i < numOfSqr; i++) {
      // there are no bombs initially
      int numberOfBombsAround = 0;

      /*
      check each square to see if it has bombs surrounding it,
      there are 8 surrounding boxes to check
      except for boxes on the edges
      */

      // check bombs to the left , unless in the first column
      if (bombLocation.contains(i - 1) && i % numInEachRow != 0) {
        numberOfBombsAround++;
      }

      // check bombs to the left , unless in first row or first column
      if (bombLocation.contains(i - 1 - numInEachRow) &&
          i % numInEachRow != 0 &&
          i >= numInEachRow) {
        numberOfBombsAround++;
      }

      // check bombs to the top , unless in the first row
      if (bombLocation.contains(i - numInEachRow) && i >= numInEachRow) {
        numberOfBombsAround++;
      }

      // check bombs to the top right , unless in first row or last column
      if (bombLocation.contains(i + 1 - numInEachRow) &&
          i >= numInEachRow &&
          i % numInEachRow != numInEachRow - 1) {
        numberOfBombsAround++;
      }

      // check bombs to the right , unless in the last column
      if (bombLocation.contains(i + 1) &&
          i % numInEachRow != numInEachRow - 1) {
        numberOfBombsAround++;
      }

      // check bombs to the bottom right , unless in last column or last row
      if (bombLocation.contains(i + 1 + numInEachRow) &&
          i % numInEachRow != numInEachRow - 1 &&
          i < numOfSqr - numInEachRow) {
        numberOfBombsAround++;
      }

      // check bombs to the bottom , unless in last row
      if (bombLocation.contains(i + numInEachRow) &&
          i < numOfSqr - numInEachRow) {
        numberOfBombsAround++;
      }

      // check bombs to the bottom left , unless in last row or first column;
      if (bombLocation.contains(i - 1 + numInEachRow) &&
          i < numOfSqr - numInEachRow &&
          i % numInEachRow != 0) {
        numberOfBombsAround++;
      }

      // add total number of bombs around to square status
      setState(() {
        squareStatus[i][0] = numberOfBombsAround;
      });
    }
  }

  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: Center(
                child: Text(
              'You Lost',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            )),
            actions: [
              MaterialButton(
                  child: Text(
                    'Restart Game',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    restartGame();
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          SizedBox(
            height: 150,
            // color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bombLocation.length.toString(),
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'BOMB',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: restartGame,
                  child: Card(
                    color: Colors.grey[700],
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'TIME',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numOfSqr,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numInEachRow),
                itemBuilder: (context, index) {
                  if (bombLocation.contains(index)) {
                    return Bomb(
                      // child: 'x',
                      revealed: bombsRevealed,
                      function: () {
                        setState(() {
                          bombsRevealed = true;
                          playerLost();
                        });
                        // plater taps on bomb, playter loses
                      },
                    );
                  } else {
                    return NumberBox(
                      child: squareStatus[index][0],
                      revealed: squareStatus[index][1],
                      function: () {
                        //reveal current box;
                        revealBoxNumbers(index);
                        checkWin();
                      },
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'My Game',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
