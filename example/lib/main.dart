import 'package:circular_progress_pie/src/circular_progress_pie.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Progress Pie Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CircularProgressPieDemo(),
    );
  }
}

class CircularProgressPieDemo extends StatefulWidget {
  const CircularProgressPieDemo({super.key});

  @override
  State<CircularProgressPieDemo> createState() =>
      _CircularProgressPieDemoState();
}

class _CircularProgressPieDemoState extends State<CircularProgressPieDemo> {
  double _progressValue = 0.3;
  final List<Color> _gradientColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  void _incrementProgress() {
    setState(() {
      _progressValue = (_progressValue + 0.1).clamp(0.0, 1.0);
    });
  }

  void _decrementProgress() {
    setState(() {
      _progressValue = (_progressValue - 0.1).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pie Progress Indicator Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSectionTitle('Basic Filled Pie'),
            _buildBasicPie(),

            const SizedBox(height: 30),
            _buildSectionTitle('Circular Ring Progress'),
            _buildCircularProgress(),

            const SizedBox(height: 30),
            _buildSectionTitle('Percentage Indicator'),
            _buildPercentageIndicator(),

            const SizedBox(height: 30),
            _buildSectionTitle('Gradient Progress'),
            _buildGradientProgress(),

            const SizedBox(height: 30),
            _buildSectionTitle('Different Animation Types'),
            _buildAnimationTypes(),

            const SizedBox(height: 30),
            _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBasicPie() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularProgressPie(
          value: _progressValue,
          size: 80,
          progressColor: Colors.blue,
        ),
        CircularProgressPie(
          value: _progressValue,
          size: 80,
          progressColor: Colors.green,
          startAngle: 0, // Start from right
        ),
        CircularProgressPie(
          value: _progressValue,
          size: 80,
          progressColor: Colors.red,
          reverse: true,
        ),
      ],
    );
  }

  Widget _buildCircularProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularProgressPie.circular(
          value: _progressValue,
          size: 60,
          progressColor: Colors.blue,
        ),
        CircularProgressPie.circular(
          value: _progressValue,
          size: 80,
          progressColor: Colors.green,
          strokeWidth: 8,
        ),
        CircularProgressPie.circular(
          value: _progressValue,
          size: 100,
          progressColor: Colors.red,
          strokeWidth: 12,
        ),
      ],
    );
  }

  Widget _buildPercentageIndicator() {
    return CircularProgressPie.percentage(
      value: _progressValue,
      size: 120,
      progressColor: Colors.purple,
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildGradientProgress() {
    return CircularProgressPie.gradient(
      value: _progressValue,
      size: 100,
      gradient: LinearGradient(colors: _gradientColors),
      isFilled: false,
      strokeWidth: 8,
    );
  }

  Widget _buildAnimationTypes() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _buildAnimationTypeCard('Sweep', PieAnimationType.sweep),
        _buildAnimationTypeCard('Bounce', PieAnimationType.bounce),
        _buildAnimationTypeCard('Elastic', PieAnimationType.elastic),
        _buildAnimationTypeCard('Fill', PieAnimationType.fill),
      ],
    );
  }

  Widget _buildAnimationTypeCard(String title, PieAnimationType type) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 8),
        CircularProgressPie(
          value: _progressValue,
          size: 60,
          progressColor: Colors.orange,
          animationType: type,
          duration: const Duration(milliseconds: 1200),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Column(
      children: [
        Text(
          'Progress: ${(_progressValue * 100).round()}%',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Slider(
          value: _progressValue,
          onChanged: (value) => setState(() => _progressValue = value),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _decrementProgress,
              child: const Text('-10%'),
            ),
            ElevatedButton(
              onPressed: _incrementProgress,
              child: const Text('+10%'),
            ),
          ],
        ),
      ],
    );
  }
}
