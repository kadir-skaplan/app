import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/premium_overlay.dart';
import 'result_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedDay;
  int? _selectedMonth;
  String? _selectedGender;
  final _formKey = GlobalKey<FormState>();

  // Month options
  final List<Map<String, dynamic>> _months = [
    {'value': 1, 'label': 'Jan'},
    {'value': 2, 'label': 'Feb'},
    {'value': 3, 'label': 'Mar'},
    {'value': 4, 'label': 'Apr'},
    {'value': 5, 'label': 'May'},
    {'value': 6, 'label': 'Jun'},
    {'value': 7, 'label': 'Jul'},
    {'value': 8, 'label': 'Aug'},
    {'value': 9, 'label': 'Sep'},
    {'value': 10, 'label': 'Oct'},
    {'value': 11, 'label': 'Nov'},
    {'value': 12, 'label': 'Dec'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Discover Their\nTrue Personality',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter their birth date to unlock powerful insights',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 40),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Month Selection
                    _buildSectionTitle('Birth Month'),
                    const SizedBox(height: 12),
                    _buildMonthSelector(),
                    const SizedBox(height: 24),

                    // Day Selection
                    _buildSectionTitle('Day'),
                    const SizedBox(height: 12),
                    _buildDaySelector(),
                    const SizedBox(height: 24),

                    // Gender Selection
                    _buildSectionTitle('Gender'),
                    const SizedBox(height: 12),
                    _buildGenderSelector(),
                    const SizedBox(height: 40),

                    // Analyze Button
                    _buildAnalyzeButton(),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Social Media Loop
              _buildSocialLoop(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
    );
  }

  Widget _buildMonthSelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _months.length,
        itemBuilder: (context, index) {
          final month = _months[index];
          final isSelected = _selectedMonth == month['value'];
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedMonth = month['value']),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? const Color(0xFF6C5CE7) 
                      : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? const Color(0xFF6C5CE7) 
                        : Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  month['label'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDaySelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 31,
        itemBuilder: (context, index) {
          final day = index + 1;
          final isSelected = _selectedDay == day;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedDay = day),
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? const Color(0xFF6C5CE7) 
                      : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? const Color(0xFF6C5CE7) 
                        : Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildGenderOption('Male', 'assets/images/male_icon.png'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildGenderOption('Female', 'assets/images/female_icon.png'),
        ),
      ],
    );
  }

  Widget _buildGenderOption(String gender, String iconPath) {
    final isSelected = _selectedGender == gender;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF6C5CE7) 
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF6C5CE7) 
                : Colors.white.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              gender == 'Male' ? Icons.male : Icons.female,
              color: isSelected ? Colors.white : Colors.white70,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              gender,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyzeButton() {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: provider.isLoading ? null : _validateAndAnalyze,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: provider.isLoading
                    ? [Colors.grey[700]!, Colors.grey[800]!]
                    : [
                        const Color(0xFF6C5CE7),
                        const Color(0xFF5B4BC7),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: provider.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Analyze Personality',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialLoop() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.camera_alt, color: Colors.pink[300], size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Watch more on Instagram',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'See full examples & case studies',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ],
      ),
    );
  }

  void _validateAndAnalyze() {
    if (_selectedDay == null || _selectedMonth == null || _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: Colors.red[700],
        ),
      );
      return;
    }

    final provider = Provider.of<AppProvider>(context, listen: false);
    provider.analyzePersonality(
      day: _selectedDay!,
      month: _selectedMonth!,
      gender: _selectedGender!,
    ).then((_) {
      if (!provider.isLoading && provider.personality != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ResultScreen()),
        );
      }
    });
  }
}
