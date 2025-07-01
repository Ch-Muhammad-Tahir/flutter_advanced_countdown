import 'package:flutter/material.dart';
import 'package:countdown_timer_package/countdown_timer_package.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CountdownTimerExampleApp());
}

class CountdownTimerExampleApp extends StatelessWidget {
  const CountdownTimerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer Package Example',
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
  State<CountdownTimerExamplePage> createState() => _CountdownTimerExamplePageState();
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
        title: const Text('Countdown Timer Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Responsive Examples'),
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
                onFinish: () => _showSnackBar('Responsive compact timer finished!'),
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
                onFinish: () => _showSnackBar('Responsive detailed timer finished!'),
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
                onFinish: () => _showSnackBar('Responsive circular timer finished!'),
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
                onFinish: () => _showSnackBar('Responsive card timer finished!'),
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
                  onFinish: () => _showSnackBar('Responsive gradient timer finished!'),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            _buildSectionTitle('Custom Responsive Theme'),
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
                ),
                onFinish: () => _showSnackBar('Custom responsive theme timer finished!'),
              ),
            ),
            
            const SizedBox(height: 24),
            _buildSectionTitle('Device Information'),
            const SizedBox(height: 16),
            
            _buildExampleCard(
              'Current Device & Screen Info',
              _buildDeviceInfoCard(),
            ),
            
            const SizedBox(height: 24),
            _buildSectionTitle('Basic Examples (Non-Responsive)'),
            const SizedBox(height: 16),
            
            // Non-responsive examples for comparison
            _buildExampleCard(
              'Non-Responsive Compact Style',
              AdvancedCountdownTimer(
                duration: const Duration(minutes: 1, seconds: 30),
                displayStyle: CountdownDisplayStyle.compact,
                showControls: true,
                useResponsiveSizing: false,
                onFinish: () => _showSnackBar('Non-responsive compact timer finished!'),
              ),
            ),
            
            const SizedBox(height: 24),
            _buildSectionTitle('Provider Example'),
            const SizedBox(height: 16),
            
            _buildExampleCard(
              'Provider-based Timer',
              ChangeNotifierProvider.value(
                value: _provider,
                child: Consumer<CountdownTimerProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        Text(
                          provider.formattedTime,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, base: 32.0),
                            fontWeight: FontWeight.bold,
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
                              child: Text(provider.isRunning ? 'Pause' : 'Resume'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: provider.resetTimer,
                              child: const Text('Reset'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            _buildSectionTitle('All Display Styles'),
            const SizedBox(height: 16),
            
            // All display styles in a grid
            _buildExampleCard(
              'All Styles Grid',
              _buildStylesGrid(),
            ),
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
        final screenDimensions = ResponsiveUtils.getScreenDimensions(context);
        final isLandscape = ResponsiveUtils.isLandscape(context);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Device Type', deviceType.name.toUpperCase()),
            _buildInfoRow('Screen Size', screenSize.name.toUpperCase()),
            _buildInfoRow('Screen Dimensions', '${screenDimensions.width.toInt()} x ${screenDimensions.height.toInt()}'),
            _buildInfoRow('Orientation', isLandscape ? 'Landscape' : 'Portrait'),
            _buildInfoRow('Responsive Font Size', '${ResponsiveUtils.getResponsiveFontSize(context, base: 16.0).toStringAsFixed(1)}'),
            _buildInfoRow('Responsive Icon Size', '${ResponsiveUtils.getResponsiveIconSize(context, base: 20.0).toStringAsFixed(1)}'),
            _buildInfoRow('Responsive Padding', ResponsiveUtils.getResponsivePadding(context).toString()),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildStylesGrid() {
    final styles = [
      CountdownDisplayStyle.compact,
      CountdownDisplayStyle.detailed,
      CountdownDisplayStyle.circular,
      CountdownDisplayStyle.minimal,
      CountdownDisplayStyle.card,
      CountdownDisplayStyle.gradient,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: styles.length,
      itemBuilder: (context, index) {
        final style = styles[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  style.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: AdvancedCountdownTimer(
                    duration: const Duration(seconds: 30),
                    displayStyle: style,
                    useResponsiveSizing: true,
                    onFinish: () => _showSnackBar('${style.name} timer finished!'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
} 