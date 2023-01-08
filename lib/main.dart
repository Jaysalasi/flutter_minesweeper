import 'package:minesweeper/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// 

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // onTap: gameOver ? (playAgain) : (gameHasStarted ? (midJump)),
//       child: Scaffold(
//         backgroundColor: Colors.grey,
//         body: Column(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 color: Colors.red,
//                 child: Center(
//                   child: Stack(children: []),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 color: Colors.blue,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
