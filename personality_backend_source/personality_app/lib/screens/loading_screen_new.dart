import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/theme.dart';
import '../widgets/animated_particles.dart';

class LoadingScreenNew extends StatefulWidget {
  const LoadingScreenNew({Key? key}) : super(key: key);

  @override
  State<LoadingScreenNew> createState() => _LoadingScreenNewState();
}

class _LoadingScreenNewState extends State<LoadingScreenNew>
    with SingleTickerProviderStateMixin {
  late AnimationController _textController;
  int _currentMessageIndex = 0;

  final List<String> _messages = [
    'Analyzing their birth blueprint...',
    'Decoding their soul essence...',
    'Revealing their true nature...',
  ];

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/result');
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            // Animated Particles Background
            Positioned.fill(
              child: AnimatedParticles(
                particleCount: 20,
                color: Colors.white,
                maxSize: 2.0,
              ),
            ),

            // Gradient Blobs
            Positioned(
              left: -50,
              top: 50,
              child: GradientBlob(
                color: const Color(0xFF9F7AEA).withOpacity(0.3),
                size: 200,
                position: const Offset(0, 0),
                duration: const Duration(seconds: 6),
              ),
            ),
            Positioned(
              right: -100,
              bottom: 100,
              child: GradientBlob(
                color: const Color(0xFFF472B6).withOpacity(0.2),
                size: 250,
                position: const Offset(0, 0),
                duration: const Duration(seconds: 8),
              ),
            ),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Loading Spinner
                  const SpinKitRipple(
                    color: Color(0xFF00D4FF),
                    size: 80,
                  ),
                  const SizedBox(height: 40),

                  // Title
                  Text(
                    'Revealing Your Soul',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Animated Message
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1)
                            .animate(_textController),
                        child: Text(
                          _messages[_currentMessageIndex],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w300,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Progress Indicator
                  Container(
                    width: 200,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _textController,
                          builder: (context, child) {
                            return Container(
                              width: 200 * _textController.value,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00D4FF),
                                    Color(0xFF0084FF),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
