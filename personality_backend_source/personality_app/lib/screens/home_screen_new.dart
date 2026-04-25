import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';
import '../utils/theme.dart';
import '../widgets/animated_particles.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew>
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),

                        // Logo/Icon
                        Container(
                          width: 80,
                          height: 80,
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
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Title
                        Text(
                          'SoulType',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.3,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),

                        // Subtitle
                        Text(
                          'Discover the blueprint of their soul',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w300,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Quote
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.05),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Text(
                            '✦ Most people get this person completely wrong. ✦',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.6),
                                  fontStyle: FontStyle.italic,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Live Indicator
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.05),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green[400],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green[400]!
                                          .withOpacity(0.5),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '🔥 2,925 people analyzing right now',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: 10,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Date Input Card
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'WHEN WERE THEY BORN?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Colors.white
                                              .withOpacity(0.5),
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Consumer<AppState>(
                                builder: (context, appState, _) {
                                  return GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.white
                                              .withOpacity(0.15),
                                          width: 1.5,
                                        ),
                                        color: Colors.white
                                            .withOpacity(0.03),
                                      ),
                                      child: Text(
                                        appState.selectedDate != null
                                            ? DateFormat('MM/dd/yyyy')
                                                .format(
                                                    appState.selectedDate!)
                                            : 'mm/dd/yyyy',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: appState.selectedDate !=
                                                      null
                                                  ? Colors.white
                                                  : Colors.white
                                                      .withOpacity(0.3),
                                            ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Gender Selection Card
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'THEIR ENERGY',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Colors.white
                                              .withOpacity(0.5),
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Consumer<AppState>(
                                builder: (context, appState, _) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: _genderButton(
                                          context,
                                          '♂',
                                          'Masculine',
                                          appState.selectedGender ==
                                              'Male',
                                          () => appState
                                              .setSelectedGender('Male'),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _genderButton(
                                          context,
                                          '♀',
                                          'Feminine',
                                          appState.selectedGender ==
                                              'Female',
                                          () => appState
                                              .setSelectedGender('Female'),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Reveal Button
                        Consumer<AppState>(
                          builder: (context, appState, _) {
                            final isEnabled = appState.selectedDate != null &&
                                appState.selectedGender != null;

                            return GestureDetector(
                              onTap: isEnabled
                                  ? () {
                                      appState.analyzePersonality();
                                      Navigator.pushNamed(
                                        context,
                                        '/loading',
                                      );
                                    }
                                  : null,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: isEnabled
                                      ? LinearGradient(
                                          colors: [
                                            const Color(0xFF00D4FF),
                                            const Color(0xFF0084FF),
                                          ],
                                        )
                                      : null,
                                  color: isEnabled
                                      ? null
                                      : Colors.white.withOpacity(0.08),
                                  border: Border.all(
                                    color: isEnabled
                                        ? Colors.transparent
                                        : Colors.white.withOpacity(0.15),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.auto_awesome,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Reveal Their Soul',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: isEnabled
                                                ? Colors.white
                                                : Colors.white
                                                    .withOpacity(0.3),
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 60),
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

  Widget _genderButton(
    BuildContext context,
    String symbol,
    String label,
    bool isSelected,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00D4FF)
                : Colors.white.withOpacity(0.15),
            width: 1.5,
          ),
          color: isSelected
              ? const Color(0xFF00D4FF).withOpacity(0.1)
              : Colors.white.withOpacity(0.03),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              symbol,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? const Color(0xFF00D4FF)
                        : Colors.white.withOpacity(0.5),
                    fontSize: 11,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00D4FF),
              surface: Color(0xFF1a1a2e),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      context.read<AppState>().setSelectedDate(picked);
    }
  }
}
