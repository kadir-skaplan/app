import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../providers/app_provider.dart';
import '../widgets/accordion_card.dart';
import '../widgets/video_carousel.dart';
import '../widgets/premium_overlay.dart';
import 'chat_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    // Show fake loading animation for 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _showLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: _showLoading ? _buildLoadingScreen() : _buildResultContent(),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xFF6C5CE7),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: _buildLoadingStep('Analyzing personality...', 0),
          ),
          FadeInDown(
            delay: const Duration(milliseconds: 800),
            child: _buildLoadingStep('Matching behavior patterns...', 1),
          ),
          FadeInDown(
            delay: const Duration(milliseconds: 1400),
            child: _buildLoadingStep('Detecting attraction triggers...', 2),
          ),
          FadeInDown(
            delay: const Duration(milliseconds: 2000),
            child: Text(
              'Almost ready...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingStep(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 20,
            color: index < 2 ? const Color(0xFF6C5CE7) : Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: index < 2 ? Colors.white : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultContent() {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        final personality = provider.personality;
        
        if (personality == null) {
          return Center(
            child: Text(
              'No analysis found',
              style: TextStyle(color: Colors.grey[400]),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and chat button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF6C5CE7),
                            const Color(0xFF5B4BC7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.chat, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          const Text(
                            'Ask AI',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Personality Type Header
              FadeInUp(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6C5CE7).withOpacity(0.3),
                        const Color(0xFF5B4BC7).withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF6C5CE7).withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        personality.type,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C5CE7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${provider.userProfile?.gender} • ${_getMonthName(provider.userProfile?.month ?? 1)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Video Carousel
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Watch & Learn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'See All',
                            style: TextStyle(color: Color(0xFF6C5CE7)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    VideoCarousel(videos: provider.videos),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // FREE Sections
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: AccordionCard(
                  title: 'Their Turn Off',
                  icon: Icons.thumb_down_outlined,
                  content: personality.turnOff,
                  isPremium: false,
                ),
              ),
              const SizedBox(height: 12),

              FadeInUp(
                delay: const Duration(milliseconds: 350),
                child: AccordionCard(
                  title: 'Topics to Discuss',
                  icon: Icons.chat_bubble_outline,
                  content: personality.topics.join('\n• '),
                  isPremium: false,
                  prefix: '• ',
                ),
              ),
              const SizedBox(height: 12),

              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: AccordionCard(
                  title: 'Best Outfit',
                  icon: Icons.checkroom_outlined,
                  content: personality.outfit,
                  isPremium: false,
                ),
              ),
              const SizedBox(height: 12),

              FadeInUp(
                delay: const Duration(milliseconds: 450),
                child: AccordionCard(
                  title: 'Attractive Body Parts',
                  icon: Icons.favorite_outline,
                  content: personality.bodyParts,
                  isPremium: false,
                ),
              ),
              const SizedBox(height: 12),

              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: AccordionCard(
                  title: 'Case Study',
                  icon: Icons.menu_book_outlined,
                  content: personality.caseStudy,
                  isPremium: false,
                  isStorytelling: true,
                ),
              ),
              const SizedBox(height: 20),

              // PREMIUM Sections
              FadeInUp(
                delay: const Duration(milliseconds: 550),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lock, color: Colors.amber[400], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Premium Insights',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Unlock advanced strategies used by experts',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              PremiumOverlay(
                child: AccordionCard(
                  title: 'Dating Ideas',
                  icon: Icons.restaurant_menu,
                  content: personality.datingIdeas ?? '',
                  isPremium: true,
                ),
              ),
              const SizedBox(height: 12),

              PremiumOverlay(
                child: AccordionCard(
                  title: 'Perfect Presents',
                  icon: Icons.card_giftcard,
                  content: personality.presents ?? '',
                  isPremium: true,
                ),
              ),
              const SizedBox(height: 12),

              PremiumOverlay(
                child: AccordionCard(
                  title: 'Keep The Spark Alive',
                  icon: Icons.local_fire_department_outlined,
                  content: personality.keepSpark ?? '',
                  isPremium: true,
                ),
              ),
              const SizedBox(height: 12),

              PremiumOverlay(
                child: AccordionCard(
                  title: 'After Breakup Strategy',
                  icon: Icons.healing_outlined,
                  content: personality.afterBreakup ?? '',
                  isPremium: true,
                ),
              ),
              const SizedBox(height: 32),

              // CTA for Premium
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: _buildPremiumCTA(provider),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPremiumCTA(AppProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.withOpacity(0.2),
            Colors.orange.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            'Don\'t Make This Mistake...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.amber[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Most people lose interest because they don\'t understand the full picture. Get all premium insights now.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[300],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => provider.togglePremium(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber, Colors.orange],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Unlock Everything',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
