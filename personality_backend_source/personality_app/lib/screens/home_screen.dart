import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/app_state.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Discover Your\nPersonality Type',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Unlock insights about yourself and your relationships',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[400],
                        ),
                  ),
                  SizedBox(height: 40),

                  // Date Picker Section
                  Text(
                    'Date of Birth',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Consumer<AppState>(
                    builder: (context, appState, _) {
                      return GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF0f3460),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: appState.selectedDate != null
                                  ? Color(0xFF00d4ff)
                                  : Colors.grey[700]!,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Color(0xFF00d4ff),
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  appState.selectedDate != null
                                      ? DateFormat('MMMM dd, yyyy')
                                          .format(appState.selectedDate!)
                                      : 'Select your date of birth',
                                  style: TextStyle(
                                    color: appState.selectedDate != null
                                        ? Colors.white
                                        : Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32),

                  // Gender Selection
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Consumer<AppState>(
                    builder: (context, appState, _) {
                      return Row(
                        children: [
                          Expanded(
                            child: _genderButton(
                              context,
                              'Male',
                              appState.selectedGender == 'Male',
                              () => appState.setSelectedGender('Male'),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _genderButton(
                              context,
                              'Female',
                              appState.selectedGender == 'Female',
                              () => appState.setSelectedGender('Female'),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 48),

                  // Analyze Button
                  Consumer<AppState>(
                    builder: (context, appState, _) {
                      final isEnabled = appState.selectedDate != null &&
                          appState.selectedGender != null;

                      return CustomButton(
                        label: 'Analyze Personality',
                        onPressed: isEnabled
                            ? () {
                                appState.analyzePersonality();
                                Navigator.pushNamed(context, '/loading');
                              }
                            : null,
                        isLoading: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _genderButton(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF00d4ff) : Color(0xFF0f3460),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFF00d4ff) : Colors.grey[700]!,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Color(0xFF1a1a2e) : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
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
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF00d4ff),
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
