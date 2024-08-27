import 'package:flutter/material.dart';

class AnimatedStarRatingBar extends StatefulWidget {
  final int starCount;
  final double rating;
  final void Function(double) onRatingChanged;

  const AnimatedStarRatingBar({
    super.key,
    required this.starCount,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  State<AnimatedStarRatingBar> createState() => _AnimatedStarRatingBarState();
}

class _AnimatedStarRatingBarState extends State<AnimatedStarRatingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late List<double> _individualRatings;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .animate(_controller..addStatusListener(_handleAnimationStatus));
    _individualRatings = List.generate(widget.starCount, (index) => 0.0);
  }

  @override
  void didUpdateWidget(covariant AnimatedStarRatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rating != oldWidget.rating) {
      _updateIndividualRatings(widget.rating);
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reset();
    }
  }

  void _updateIndividualRatings(double rating) {
    for (int i = 0; i < widget.starCount; i++) {
      _individualRatings[i] = i < rating ? 1.0 : 0.0;
      if (i == rating.floor()) {
        _individualRatings[i] = rating - i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.starCount, (index) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: Colors.amber,
            size: _individualRatings[index] *
                24.0, // Adjust size based on preference
          ),
          iconSize: 24.0,
          padding: EdgeInsets.zero,
          onPressed: () => _onStarTap(index + 1.0),
        );
      }),
    );
  }

  void _onStarTap(double rating) {
    _updateIndividualRatings(rating);
    widget.onRatingChanged(rating);
    _controller.forward();
  }
}
