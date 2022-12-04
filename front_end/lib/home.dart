import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 0;
  void crementoPd() {
    counter++;
    setState(() {});
  }

  void decrementoPd() {
    counter--;
    setState(() {});
  }

  void restartPd() {
    counter = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
        elevation: 1.0,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Prueba de Widget',
            style: TextStyle(fontSize: 30),
          ),
          Text('$counter', style: const TextStyle(fontSize: 30))
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomNew(
        cremento: crementoPd,
        decremento: decrementoPd,
        restart: restartPd,
      ),
    );
  }
}

class CustomNew extends StatelessWidget {
  final Function cremento;
  final Function decremento;
  final Function restart;

  const CustomNew({
    super.key,
    required this.cremento,
    required this.decremento,
    required this.restart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.plus_one_outlined),
          onPressed: () => cremento(),
        ),
        const SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          child: const Icon(Icons.replay_outlined),
          onPressed: () => restart(),
        ),
        const SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          child: const Icon(Icons.exposure_minus_1_outlined),
          onPressed: () => decremento(),
        ),
      ],
    );
  }
}
