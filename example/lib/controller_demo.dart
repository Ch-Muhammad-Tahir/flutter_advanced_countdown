import 'package:flutter/material.dart';
import 'package:flutter_advanced_countdown/flutter_advanced_countdown.dart';

void main() => runApp(const ControllerDemoApp());

class ControllerDemoApp extends StatelessWidget {
  const ControllerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controller & Localisation Demo',
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
      ],
      localizationsDelegates: const [
        CountdownLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: const CountdownDemoScreen(),
    );
  }
}

class CountdownDemoScreen extends StatefulWidget {
  const CountdownDemoScreen({super.key});

  @override
  State<CountdownDemoScreen> createState() => _CountdownDemoScreenState();
}

class _CountdownDemoScreenState extends State<CountdownDemoScreen> {
  final _controller = CountdownTimerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller & i18n Demo')),
      body: Center(
        child: AdvancedCountdownTimer(
          controller: _controller,
          duration: const Duration(minutes: 1),
          displayStyle: CountdownDisplayStyle.circular,
          enableHapticFeedback: true,
          enableSoundNotifications:
              false, // set true & provide customSoundPath to test
          enableVibrationFeedback: true,
          theme: CountdownTheme.professional(primaryColor: Colors.indigo),
          onFinish: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Timer Finished!')),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'start',
            onPressed: _controller.start,
            tooltip: 'Start',
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'pause',
            onPressed: _controller.pause,
            tooltip: 'Pause',
            child: const Icon(Icons.pause),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: _controller.reset,
            tooltip: 'Reset',
            child: const Icon(Icons.restart_alt),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'seek',
            onPressed: () => _controller.seek(const Duration(seconds: 30)),
            tooltip: 'Seek to 30s',
            child: const Icon(Icons.skip_next),
          ),
        ],
      ),
    );
  }
}
