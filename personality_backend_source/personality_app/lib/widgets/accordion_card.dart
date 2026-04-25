import 'package:flutter/material.dart';

class AccordionCard extends StatefulWidget {
  final String title;
  final String content;
  final bool isPremium;

  const AccordionCard({
    Key? key,
    required this.title,
    required this.content,
    this.isPremium = false,
  }) : super(key: key);

  @override
  State<AccordionCard> createState() => _AccordionCardState();
}

class _AccordionCardState extends State<AccordionCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          setState(() => _isExpanded = !_isExpanded);
          if (_isExpanded) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF0f3460),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isPremium
                  ? Color(0xFF00d4ff).withOpacity(0.3)
                  : Colors.grey[700]!,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (widget.isPremium)
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.lock,
                                color: Color(0xFF00d4ff),
                                size: 16,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5)
                          .animate(_animationController),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              if (_isExpanded)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF0a1f2e),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    widget.content,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
