import 'package:flutter/material.dart';

class ScrollingDotsIndicator extends StatefulWidget {
  final ScrollController controller;
  final int itemCount;

  const ScrollingDotsIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
  }) : super(key: key);

  @override
  _ScrollingDotsIndicatorState createState() => _ScrollingDotsIndicatorState();
}

class _ScrollingDotsIndicatorState extends State<ScrollingDotsIndicator> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  void _onScroll() {
    // Calculate visible item index based on scroll position
    final itemWidth = widget.controller.position.maxScrollExtent / (widget.itemCount - 1);
    final index = (widget.controller.offset / itemWidth).round();
    
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index.clamp(0, widget.itemCount - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Show first 3 dots
        ...List.generate(3, (index) {
          final bool isActive = index == _currentIndex;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive 
                  ? Theme.of(context).primaryColor 
                  : Colors.grey.shade300,
            ),
          );
        }),
        // Show small dot if more items exist
        if (widget.itemCount > 3)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }
}