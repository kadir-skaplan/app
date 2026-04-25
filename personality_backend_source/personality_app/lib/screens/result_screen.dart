import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../widgets/accordion_card.dart';
import '../widgets/video_carousel.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
            ],
          ),
        ),
        child: Consumer<AppState>(
          builder: (context, appState, _) {
            final profile = appState.currentProfile;
            if (profile == null) {
              return Center(
                child: Text(
                  'No profile data',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Type',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                profile.type,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/home'),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xFF0f3460),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: Color(0xFF00d4ff),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Video Carousel
                      VideoCarousel(personalityType: profile.type),
                      SizedBox(height: 32),

                      // Accordion Sections - Free
                      Text(
                        'FREE INSIGHTS',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      AccordionCard(
                        title: 'What is their type',
                        content: profile.description,
                        isPremium: false,
                      ),
                      AccordionCard(
                        title: 'Their turn off',
                        content: profile.turnOff,
                        isPremium: false,
                      ),
                      AccordionCard(
                        title: 'Topics to discuss',
                        content: profile.topicsToDiscuss.join('\n• '),
                        isPremium: false,
                      ),
                      AccordionCard(
                        title: 'Outfit',
                        content: profile.outfit,
                        isPremium: false,
                      ),
                      AccordionCard(
                        title: 'Body parts',
                        content: profile.bodyParts,
                        isPremium: false,
                      ),
                      AccordionCard(
                        title: 'Case study',
                        content: profile.caseStudy,
                        isPremium: false,
                      ),
                      SizedBox(height: 32),

                      // Premium Section
                      if (!appState.isPremium)
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF00d4ff).withOpacity(0.2),
                                Color(0xFF0084ff).withOpacity(0.2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFF00d4ff),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Color(0xFF00d4ff),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'PREMIUM CONTENT',
                                    style: TextStyle(
                                      color: Color(0xFF00d4ff),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Unlock premium insights and advanced AI features',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/premium'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF00d4ff),
                                    foregroundColor: Color(0xFF1a1a2e),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: Text(
                                    'Unlock Premium',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: [
                            Text(
                              'PREMIUM INSIGHTS',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(height: 12),
                            AccordionCard(
                              title: 'Visual examples',
                              content: profile.visualExamples,
                              isPremium: true,
                            ),
                            AccordionCard(
                              title: 'Dating ideas',
                              content: profile.datingIdeas,
                              isPremium: true,
                            ),
                            AccordionCard(
                              title: 'Present ideas',
                              content: profile.presentIdeas,
                              isPremium: true,
                            ),
                            AccordionCard(
                              title: 'Keep the spark alive',
                              content: profile.keepSparkAlive,
                              isPremium: true,
                            ),
                            AccordionCard(
                              title: 'After breakup',
                              content: profile.afterBreakup,
                              isPremium: true,
                            ),
                          ],
                        ),
                      SizedBox(height: 32),

                      // Chat Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/chat'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF00d4ff),
                            foregroundColor: Color(0xFF1a1a2e),
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: Icon(Icons.chat_bubble_outline),
                          label: Text(
                            'Ask AI for Advice',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
