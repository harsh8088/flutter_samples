import 'package:flutter/material.dart';

class CurvedCutRectangle extends StatelessWidget {
  final double width;
  final double height;
  final double curveRadius;
  final double cutWidth;
  final Color backgroundColor;
  final Widget child;

  const CurvedCutRectangle({
    super.key,
    required this.width,
    required this.height,
    required this.curveRadius,
    required this.cutWidth,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final path = Path();
    path.moveTo(0, curveRadius);
    path.arcToPoint(
      Offset(curveRadius, 0),
      radius: Radius.circular(curveRadius),
      clockwise: false,
    );
    path.lineTo(width - curveRadius, 0);
    path.arcToPoint(
      Offset(width, curveRadius),
      radius: Radius.circular(curveRadius),
      clockwise: false,
    );

    final cutStartX = width / 2 - cutWidth / 2;
    final cutEndX = width / 2 + cutWidth / 2;

    path.lineTo(cutEndX, curveRadius);
    // Define the curved cut path
    path.quadraticBezierTo(
      width / 2, height - curveRadius,
      cutStartX, curveRadius,
    );
    path.lineTo(cutStartX, height);
    path.arcToPoint(
      Offset(cutStartX - curveRadius, height - curveRadius),
      radius: Radius.circular(curveRadius),
      clockwise: false,
    );
    path.lineTo(curveRadius, height);
    path.arcToPoint(
      Offset(0, height - curveRadius),
      radius: Radius.circular(curveRadius),
      clockwise: false,
    );
    path.close();

    return ClipPath(
      // clipper: CustomClipper(path: path),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: child,
      ),
    );
  }
}

// class CustomClipper extends CustomClipper<Path> {
//   final Path path;
//
//   const CustomClipper({required this.path});
//
//   @override
//   Path getClip(Size size) => path;
//
//   @override
//   bool shouldReclip(CustomClipper oldClipper) => oldClipper.path != path;
// }