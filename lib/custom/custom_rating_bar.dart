import 'package:flutter/material.dart';

class CustomRatingBar extends StatefulWidget {
  final double rating;
  final int starCount;
  final Function onRatingChanged;
  final Color filledColor;
  final Color unfilledColor;

  const CustomRatingBar({
    super.key,
    required this.rating,
    required this.starCount,
    required this.onRatingChanged,
    required this.unfilledColor,
    required this.filledColor,
  });

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  double _currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.starCount,
        (index) => GestureDetector(
          onTap: () => _onStarTap(index.toDouble()),
          child: Icon(
            Icons.star,
            size: 30.0,
            color: _getColor(index),
          ),
        ),
      ),
    );
  }

  Color _getColor(int index) {
    if (index <= _currentRating) {
      return widget.filledColor;
    } else {
      return widget.unfilledColor;
    }
  }

  void _onStarTap(double newRating) {
    if (_currentRating == newRating) {
      newRating--;
    }
    setState(() {
      _currentRating = newRating;
      // widget.onRatingChanged(newRating);
    });
  }
}
