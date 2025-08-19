import 'package:flutter_advanced_countdown/flutter_advanced_countdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CountdownTimerExampleApp());
}

class CountdownTimerExampleApp extends StatelessWidget {
  const CountdownTimerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Countdown Timer Package Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CountdownTimerExamplePage(),
    );
  }
}

class CountdownTimerExamplePage extends StatefulWidget {
  const CountdownTimerExamplePage({super.key});

  @override
  State<CountdownTimerExamplePage> createState() =>
      _CountdownTimerExamplePageState();
}

class _CountdownTimerExamplePageState extends State<CountdownTimerExamplePage> {
  final CountdownTimerProvider _provider = CountdownTimerProvider();

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Countdown Timer Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('🎨 Professional Themes'),
            const SizedBox(height: 16),

            // Professional theme
            _buildExampleCard(
              'Professional Theme',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 2, seconds: 30),
                displayStyle: CountdownDisplayStyle.detailed,
                showControls: true,
                showReset: true,
                theme: CountdownTheme.professional(
                  primaryColor: Colors.indigo,
                  enableAnimations: true,
                  enableShadows: true,
                  enableRoundedCorners: true,
                ),
                onFinish: () =>
                    _showSnackBar('Professional theme timer finished!'),
              ),
            ),

            // Glass morphism theme
            _buildExampleCard(
              'Glass Morphism Theme',
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: AdvancedCountdownTimer(
                  duration: const Duration(minutes: 1, seconds: 45),
                  displayStyle: CountdownDisplayStyle.circular,
                  showControls: true,
                  theme: CountdownTheme.glassMorphism(
                    primaryColor: Colors.white,
                    blurRadius: 15.0,
                  ),
                  onFinish: () =>
                      _showSnackBar('Glass morphism timer finished!'),
                ),
              ),
            ),

            // Minimal theme
            _buildExampleCard(
              'Minimal Theme',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1),
                displayStyle: CountdownDisplayStyle.minimal,
                theme: CountdownTheme.minimal(
                  primaryColor: Colors.teal,
                  enableBorders: true,
                ),
                onFinish: () => _showSnackBar('Minimal theme timer finished!'),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('🚀 New Display Styles'),
            const SizedBox(height: 16),

            // Digital display
            _buildExampleCard(
              'Digital Display',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1, seconds: 30),
                displayStyle: CountdownDisplayStyle.digital,
                showControls: true,
                showReset: true,
                theme: CountdownTheme.dark(primaryColor: Colors.cyan),
                onFinish: () => _showSnackBar('Digital timer finished!'),
              ),
            ),

            // Analog display
            _buildExampleCard(
              'Analog Display',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 2),
                displayStyle: CountdownDisplayStyle.analog,
                showControls: true,
                theme: CountdownTheme.light(primaryColor: Colors.orange),
                onFinish: () => _showSnackBar('Analog timer finished!'),
              ),
            ),

            // Progress bar display
            _buildExampleCard(
              'Progress Bar Display',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1, seconds: 45),
                displayStyle: CountdownDisplayStyle.progressBar,
                showControls: true,
                showLowTimeWarning: true,
                lowTimeWarningThreshold: 30,
                warningColor: Colors.red,
                theme: CountdownTheme.light(primaryColor: Colors.green),
                onFinish: () => _showSnackBar('Progress bar timer finished!'),
              ),
            ),

            // Floating display
            _buildExampleCard(
              'Floating Display',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1),
                displayStyle: CountdownDisplayStyle.floating,
                showControls: true,
                theme: CountdownTheme.gradient(
                  colors: [Colors.pink, Colors.purple],
                  textColor: Colors.white,
                ),
                onFinish: () => _showSnackBar('Floating timer finished!'),
              ),
            ),

            // Notification display
            _buildExampleCard(
              'Notification Display',
              AdvancedCountdownTimer(
                duration: const Duration(seconds: 45),
                displayStyle: CountdownDisplayStyle.notification,
                showControls: true,
                theme: CountdownTheme.light(primaryColor: Colors.red),
                onFinish: () => _showSnackBar('Notification timer finished!'),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('⚡ Advanced Animations'),
            const SizedBox(height: 16),

            // Custom animation config
            _buildExampleCard(
              'Custom Animations',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1, seconds: 30),
                displayStyle: CountdownDisplayStyle.circular,
                showControls: true,
                animationConfig: CountdownAnimationConfig(
                  enabled: true,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.bounceOut,
                  enablePulseAnimation: true,
                  pulseThreshold: 15,
                  enableShakeAnimation: true,
                  enableScaleAnimation: true,
                  enableFadeAnimation: true,
                ),
                theme: CountdownTheme.light(primaryColor: Colors.deepPurple),
                onFinish: () =>
                    _showSnackBar('Custom animations timer finished!'),
              ),
            ),

            // No animations
            _buildExampleCard(
              'No Animations',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1),
                displayStyle: CountdownDisplayStyle.compact,
                showControls: true,
                animationConfig: const CountdownAnimationConfig(
                  enabled: false,
                ),
                theme: CountdownTheme.light(primaryColor: Colors.grey),
                onFinish: () => _showSnackBar('No animations timer finished!'),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('🎯 Custom Builders'),
            const SizedBox(height: 16),

            // Custom builder example
            _buildExampleCard(
              'Custom Builder',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1, seconds: 30),
                displayStyle: CountdownDisplayStyle.custom,
                customBuilderConfig: CountdownCustomBuilderConfig(
                  timeBuilder: (context, remaining, isRunning, isPaused) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isRunning
                              ? [Colors.green, Colors.lightGreen]
                              : [Colors.orange, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            isRunning ? Icons.play_circle : Icons.pause_circle,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            remaining.formattedSmart,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            isRunning ? 'Running' : 'Paused',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                onFinish: () => _showSnackBar('Custom builder timer finished!'),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('🔧 Advanced Styling'),
            const SizedBox(height: 16),

            // Advanced styling example
            _buildExampleCard(
              'Advanced Styling',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1),
                displayStyle: CountdownDisplayStyle.card,
                showControls: true,
                theme: CountdownTheme.light(primaryColor: Colors.blue).copyWith(
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                advancedStyle: const CountdownAdvancedStyle(
                  alignment: Alignment.center,
                  semanticLabel: 'Advanced styled countdown timer',
                ),
                onFinish: () =>
                    _showSnackBar('Advanced styling timer finished!'),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('📱 Responsive Examples'),
            const SizedBox(height: 16),

            // Responsive compact style
            _buildExampleCard(
              'Responsive Compact Style',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 2, seconds: 30),
                displayStyle: CountdownDisplayStyle.compact,
                showControls: true,
                showReset: true,
                useResponsiveSizing: true,
                onFinish: () =>
                    _showSnackBar('Responsive compact timer finished!'),
              ),
            ),

            // Responsive detailed style
            _buildExampleCard(
              'Responsive Detailed Style',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1, seconds: 45),
                displayStyle: CountdownDisplayStyle.detailed,
                showControls: true,
                showReset: true,
                useResponsiveSizing: true,
                onFinish: () =>
                    _showSnackBar('Responsive detailed timer finished!'),
              ),
            ),

            // Responsive circular style
            _buildExampleCard(
              'Responsive Circular Style',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1),
                displayStyle: CountdownDisplayStyle.circular,
                showControls: true,
                showReset: true,
                useResponsiveSizing: true,
                onFinish: () =>
                    _showSnackBar('Responsive circular timer finished!'),
              ),
            ),

            // Responsive card style
            _buildExampleCard(
              'Responsive Card Style',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1, seconds: 30),
                displayStyle: CountdownDisplayStyle.card,
                showControls: true,
                showReset: true,
                useResponsiveSizing: true,
                onFinish: () =>
                    _showSnackBar('Responsive card timer finished!'),
              ),
            ),

            // Responsive gradient style
            _buildExampleCard(
              'Responsive Gradient Style',
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: AdvancedCountdownTimer(
                  duration: const Duration(minutes: 1),
                  displayStyle: CountdownDisplayStyle.minimal,
                  useResponsiveSizing: true,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  onFinish: () =>
                      _showSnackBar('Responsive gradient timer finished!'),
                ),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('🎨 Custom Responsive Theme'),
            const SizedBox(height: 16),

            // Custom responsive theme
            _buildExampleCard(
              'Custom Responsive Theme',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 2),
                displayStyle: CountdownDisplayStyle.detailed,
                showControls: true,
                useResponsiveSizing: true,
                theme: CountdownTheme.responsive(
                  primaryColor: Colors.deepPurple,
                  backgroundColor: Colors.deepPurple.shade50,
                  textColor: Colors.deepPurple.shade900,
                  fontConfig: const ResponsiveFontConfig(
                    xs: 14.0,
                    sm: 16.0,
                    md: 18.0,
                    lg: 20.0,
                    xl: 22.0,
                  ),
                  paddingConfig: const ResponsivePaddingConfig(
                    xs: EdgeInsets.all(8.0),
                    sm: EdgeInsets.all(12.0),
                    md: EdgeInsets.all(16.0),
                    lg: EdgeInsets.all(20.0),
                    xl: EdgeInsets.all(24.0),
                  ),
                  iconConfig: const ResponsiveIconConfig(
                    xs: 16.0,
                    sm: 18.0,
                    md: 20.0,
                    lg: 24.0,
                    xl: 28.0,
                  ),
                  animationConfig: CountdownAnimationConfig(
                    enabled: true,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    enablePulseAnimation: true,
                    enableShakeAnimation: true,
                    enableScaleAnimation: true,
                    enableFadeAnimation: true,
                  ),
                ),
                onFinish: () =>
                    _showSnackBar('Custom responsive theme timer finished!'),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('📊 Device Information'),
            const SizedBox(height: 16),

            _buildExampleCard(
              'Current Device & Screen Info',
              _buildDeviceInfoCard(),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('🔧 Basic Examples (Non-Responsive)'),
            const SizedBox(height: 16),

            // Non-responsive examples for comparison
            _buildExampleCard(
              'Non-Responsive Compact Style',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1, seconds: 30),
                displayStyle: CountdownDisplayStyle.compact,
                showControls: true,
                useResponsiveSizing: false,
                onFinish: () =>
                    _showSnackBar('Non-responsive compact timer finished!'),
              ),
            ),

            _buildExampleCard(
              'Non-Responsive Detailed Style',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1),
                displayStyle: CountdownDisplayStyle.detailed,
                showControls: true,
                useResponsiveSizing: false,
                onFinish: () =>
                    _showSnackBar('Non-responsive detailed timer finished!'),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('🎮 Provider Integration'),
            const SizedBox(height: 16),

            _buildExampleCard(
              'Provider-Based Timer',
              ChangeNotifierProvider.value(
                value: _provider,
                child: Consumer<CountdownTimerProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        Text(
                          provider.formattedTime,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                                context,
                                base: 32.0),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: provider.isRunning
                                  ? provider.pauseTimer
                                  : provider.resumeTimer,
                              child:
                                  Text(provider.isRunning ? 'Pause' : 'Resume'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: provider.resetTimer,
                              child: const Text('Reset'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            provider.startTimer(
                              duration: const Duration(minutes: 2),
                              onFinish: () =>
                                  _showSnackBar('Provider timer finished!'),
                            );
                          },
                          child: const Text('Start 2-Minute Timer'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 100), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfoCard() {
    return Builder(
      builder: (context) {
        final deviceType = ResponsiveUtils.getDeviceType(context);
        final screenSize = ResponsiveUtils.getScreenSize(context);
        final mediaQuery = MediaQuery.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Device Type', deviceType.name.toUpperCase()),
            _buildInfoRow('Screen Size', screenSize.name.toUpperCase()),
            _buildInfoRow('Screen Width',
                '${mediaQuery.size.width.toStringAsFixed(0)}px'),
            _buildInfoRow('Screen Height',
                '${mediaQuery.size.height.toStringAsFixed(0)}px'),
            _buildInfoRow(
                'Pixel Ratio', mediaQuery.devicePixelRatio.toStringAsFixed(2)),
            _buildInfoRow(
                'Platform', Theme.of(context).platform.name.toUpperCase()),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
