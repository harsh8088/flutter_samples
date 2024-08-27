import 'package:flutter/material.dart';

class CapsuleWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color topColor;
  final Color bottomColor;
  final Widget child;

  const CapsuleWidget({
    super.key,
    required this.height,
    required this.width,
    required this.topColor,
    required this.bottomColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Bottom capsule part
        // CustomPaint(
        //   size: Size(width, height),
        //   painter: CapsulePainter(color: bottomColor),
        // ),
        // Top capsule part with rounded rectangle clip
        ClipRRect(
          // borderRadius: BorderRadius.circular(width),
          child: CustomPaint(
            size: Size(width, height),
            painter: CapsulePainter(color: topColor, color2: bottomColor),
          ),
        ),
        // Child widget positioned inside the capsule
        // Positioned(
        //   top: height / 4,
        //   left: width / 4,
        //   child: child,
        // ),
        child
      ],
    );
  }
}

// Custom Painter for capsule shape
class CapsulePainter extends CustomPainter {
  final Color color;
  final Color color2;

  CapsulePainter({required this.color, required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    try {
      final paint = Paint()..color = color;
      final paint2 = Paint()..color = color2;

      // final path = Path()
      //   ..moveTo(0, 0)
      //   ..lineTo(size.width, 0)
      //   // ..quadraticBezierTo(size.width - size.height, 130, size.width - size.height, size.height)
      //   // ..conicTo(size.width - size.height, size.width, size.width - size.height, size.height,-1.5)
      //
      //   // ..quadraticBezierTo(
      //   //   size.height/2,
      //   //   size.height/2,
      //   //   size.width-size.height,
      //   //   size.height,
      //   // )
      //   ..relativeQuadraticBezierTo(
      //     size.width +40,
      //     size.height + 40,
      //     size.width,
      //     size.height,
      //   )
      //   // ..quadraticBezierTo(
      //   //     size.width / 4, size.height * 3 / 4, size.width / 2, size.height / 2)
      //   // ..quadraticBezierTo(size.width * 3 / 4, size.height / 4, size.width, 0)
      //   ..lineTo(0, size.height)
      //   // ..lineTo(0, 0)
      //   // ..lineTo(size.width, size.height)
      //   ..close();

      final width = size.width - 30;
      final height = size.height;
      final heightOffset = height * 0.2;
      Path path = Path();
      path.lineTo(
        0, // x value
        height, // y value
      );
      path.lineTo(
        width * 0.3, // x value
        height, // y value
      );
      path.quadraticBezierTo(
        width + width * 0.25, // x1 (Control Point)
        0, // y1 (Control Point)
        width, // x2 (End Point)
        -(width / 2), // y2 (End Point)
      );

      // path.quadraticBezierTo(
      //   width * 0.75, // P1(x1)
      //   height - (heightOffset * 2), // P1(y1)
      //   width, // P2(x2)
      //   height - heightOffset, // P2(y2)
      // );
      // path.lineTo(width, 0);
      // return path;

      canvas.drawPath(path, paint);

      Path path2 = Path();
      path2.moveTo(
        width + 10, // x value
        0, // y value
      );
      // path.quadraticBezierTo(
      //   width+ 20, // x1 (Control Point)
      //   height/2, // y1 (Control Point)
      //   width, // x2 (End Point)
      //   -(width/2)+10, // y2 (End Point)
      // );
      path2.lineTo(width + 20, 0);
      // path2.lineTo(width+20, height);
      path2.lineTo(width - 20, height);
      // path.lineTo(width+(width/2),height);

      // path.quadraticBezierTo(
      //   width+ 20, // x1 (Control Point)
      //   height/2, // y1 (Control Point)
      //   width, // x2 (End Point)
      //   -(width/2)+10, // y2 (End Point)
      // );

      canvas.drawPath(path2, paint2);
    } catch (_) {
      print(_.toString());
    }
  }

  // @override
  // bool shouldRepaint(CustomPainter oldDelegate) => color != oldDelegate.color;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
