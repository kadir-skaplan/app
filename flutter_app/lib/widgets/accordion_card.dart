import 'package:flutter/material.dart';

class AccordionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String content;
  final bool isPremium;
  final bool isStorytelling;
  final String prefix;

  const AccordionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
    this.isPremium = false,
    this.isStorytelling = false,
    this.prefix = '',
  });

  @override
  State<AccordionCard> createState() => _AccordionCardState();
}

class _AccordionCardState extends State<AccordionCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.isPremium
                          ? Colors.amber.withOpacity(0.2)
                          : const Color(0xFF6C5CE7).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.isPremium
                          ? Colors.amber[400]
                          : const Color(0xFF6C5CE7),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.white.withOpacity(0.1)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: widget.isStorytelling
                        ? _buildStorytellingContent()
                        : _buildRegularContent(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRegularContent() {
    return Text(
      widget.prefix + widget.content,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[300],
        height: 1.6,
      ),
    );
  }

  Widget _buildStorytellingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Real Example:',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.amber[400],
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.content,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
            height: 1.6,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF6C5CE7).withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: const Color(0xFF6C5CE7), size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'This is where most people fail...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
