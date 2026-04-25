import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../utils/theme.dart';
import '../widgets/animated_particles.dart';
import '../widgets/video_carousel.dart';

class ResultScreenNew extends StatefulWidget {
  const ResultScreenNew({Key? key}) : super(key: key);

  @override
  State<ResultScreenNew> createState() => _ResultScreenNewState();
}

class _ResultScreenNewState extends State<ResultScreenNew>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
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
                particleCount: 25,
                color: Colors.white,
                maxSize: 2.5,
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
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withOpacity(0.08),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.15),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            Text(
                              'SoulType',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white.withOpacity(0.08),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                ),
                              ),
                              child: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Personality Type Title
                        Consumer<AppState>(
                          builder: (context, appState, _) {
                            final profile = appState.currentProfile;
                            return Column(
                              children: [
                                Text(
                                  profile?.type ?? 'Soul Analysis',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.2,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  profile?.description ??
                                      'Your personality has been analyzed',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.w300,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 32),

                        // Video Carousel
                        Consumer<AppState>(
                          builder: (context, appState, _) {
                            return VideoCarousel(
                              personalityType:
                                  appState.currentProfile?.type ?? '',
                            );
                          },
                        ),
                        const SizedBox(height: 32),

                        // Content Sections
                        Consumer<AppState>(
                          builder: (context, appState, _) {
                            final profile = appState.currentProfile;
                            if (profile == null) {
                              return const SizedBox.shrink();
                            }

                            return Column(
                              children: [
                                // Turn-off Factors
                                _AccordionCard(
                                  title: 'Turn-off Factors',
                                  content: profile.turnOff,
                                  isPremium: false,
                                ),
                                const SizedBox(height: 12),

                                // Discussion Topics
                                _AccordionCard(
                                  title: 'Discussion Topics',
                                  content: profile.topicsToDiscuss
                                      .join('\n'),
                                  isPremium: false,
                                ),
                                const SizedBox(height: 12),

                                // Clothing Suggestions (Premium)
                                _AccordionCard(
                                  title: 'Clothing Suggestions',
                                  content: profile.outfit,
                                  isPremium: !appState.isPremium,
                                ),
                                const SizedBox(height: 12),

                                // Body Features (Premium)
                                _AccordionCard(
                                  title: 'Body Features',
                                  content: profile.bodyParts,
                                  isPremium: !appState.isPremium,
                                ),
                                const SizedBox(height: 12),

                                // Case Study (Premium)
                                _AccordionCard(
                                  title: 'Case Study',
                                  content: profile.caseStudy,
                                  isPremium: !appState.isPremium,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 32),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/chat');
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF00D4FF),
                                        Color(0xFF0084FF),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.chat_bubble_outline,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Ask AI',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/premium');
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    color: Colors.white.withOpacity(0.08),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.workspace_premium,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Premium',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Local Accordion Card widget for result screen
class _AccordionCard extends StatefulWidget {
  final String title;
  final String content;
  final bool isPremium;

  const _AccordionCard({
    required this.title,
    required this.content,
    required this.isPremium,
  });

  @override
  State<_AccordionCard> createState() => _AccordionCardState();
}

class _AccordionCardState extends State<_AccordionCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (widget.isPremium) {
      Navigator.pushNamed(context, '/premium');
      return;
    }
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggle,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                  ),
                  widget.isPremium
                      ? const Icon(
                          Icons.lock,
                          color: Color(0xFFFBBF24),
                          size: 18,
                        )
                      : AnimatedRotation(
                          turns: _isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedBuilder(
              animation: _heightFactor,
              builder: (context, child) {
                return Align(
                  heightFactor: _heightFactor.value,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  widget.content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        height: 1.6,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
