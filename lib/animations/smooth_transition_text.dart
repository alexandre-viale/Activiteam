import 'package:flutter/material.dart';

class SmoothTransitionText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final IconData icon;

  const SmoothTransitionText({
    Key? key,
    required this.text,
    required this.style,
    required this.icon,
  }) : super(key: key);

  @override
  _SmoothTransitionTextState createState() => _SmoothTransitionTextState();
}

class _SmoothTransitionTextState extends State<SmoothTransitionText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  String _currentText = '';

  @override
  void initState() {
    super.initState();

    _currentText = widget.text;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(SmoothTransitionText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != _currentText) {
      _currentText = widget.text;
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: _animation.value,
              child: Icon(
                widget.icon,
                color: widget.style.color,
                size: 28,
              ),
            ),
            const SizedBox(width: 8),
            Opacity(
              opacity: _animation.value,
              child: Text(
                _currentText,
                style: widget.style,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
