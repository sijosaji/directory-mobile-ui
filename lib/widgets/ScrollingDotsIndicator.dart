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
    if (!widget.controller.hasClients) return;

    final double scrollOffset = widget.controller.offset;
    final double viewportWidth = widget.controller.position.viewportDimension;
    final double maxScrollExtent = widget.controller.position.maxScrollExtent;

    final double estimatedItemWidth = (maxScrollExtent + viewportWidth) / widget.itemCount;

    int newIndex = (scrollOffset / estimatedItemWidth).round().clamp(0, widget.itemCount - 1);

    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int maxVisibleDots = 4; // Show 3-4 dots at a time
    int shiftStartIndex = 2; // Start shifting after 3rd item

    // Dynamically adjust the visible range
    int start = (_currentIndex > shiftStartIndex)
        ? (_currentIndex - shiftStartIndex).clamp(0, widget.itemCount - maxVisibleDots)
        : 0;
    int end = (start + maxVisibleDots).clamp(0, widget.itemCount);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(end - start, (index) {
        final actualIndex = start + index;
        final bool isActive = actualIndex == _currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 12 : 8,
          height: isActive ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade400,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }
}
