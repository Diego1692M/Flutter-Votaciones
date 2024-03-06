import 'package:flutter/material.dart';
import 'package:votos_candidatos1/screen/votacionScreen.dart';

void main() {
  runApp(const TallerPresidencial());
}

class TallerPresidencial extends StatelessWidget {
  const TallerPresidencial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Votación',
            style: TextStyle(color: Color.fromARGB(255, 242, 239, 241)),
          ),
          backgroundColor: const Color.fromARGB(255, 133, 102, 24),
        ),
        body: const VotacionScreen(),
      ),
    );
  }
}
