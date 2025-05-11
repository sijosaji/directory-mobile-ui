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
    if (!widget.controller.hasClients || widget.itemCount == 0) return;

    final double scrollOffset = widget.controller.offset;
    final double maxScrollExtent = widget.controller.position.maxScrollExtent;

    if (maxScrollExtent == 0) return;

    // Compute index based on scroll ratio
    double scrollRatio = scrollOffset / maxScrollExtent;
    int newIndex = (scrollRatio * (widget.itemCount - 1)).round().clamp(0, widget.itemCount - 1);

    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int totalDots = widget.itemCount;
    final bool showAll = totalDots <= 5;
    final int visibleDots = showAll ? totalDots : 5;

    // Shift the visible range if needed
    int start = 0;
    if (!showAll) {
      int half = (visibleDots / 2).floor();
      start = (_currentIndex - half).clamp(0, totalDots - visibleDots);
    }

    return SizedBox(
      height: 20, // Fixed height to prevent layout shift
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(visibleDots, (i) {
          final actualIndex = start + i;
          final bool isActive = actualIndex == _currentIndex;

          return Container(
            width: 16, // fixed space for dot (includes margin)
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isActive ? 12 : 8,
              height: isActive ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade400,
              ),
            ),
          );
        }),
      ),
    );
  }
}
