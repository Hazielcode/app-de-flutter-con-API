import 'package:flutter/material.dart';

class GoogleColors {
  const GoogleColors._();

  static const blue = Color(0xFF1A73E8);     // Google Blue (Primary)
  static const red = Color(0xFFEA4335);      // Google Red (Danger/Delete)
  static const yellow = Color(0xFFFBBC05);   // Google Yellow (Warning/Low stock)
  static const green = Color(0xFF34A853);    // Google Green (Success/Add)
  static const grey100 = Color(0xFFF8F9FA);  // Light background
  static const grey200 = Color(0xFFE8EAED);  // Borders
  static const grey700 = Color(0xFF5F6368);  // Secondary text
  static const grey900 = Color(0xFF202124);  // Primary text
}

class GoogleTextField extends StatelessWidget {
  const GoogleTextField({
    required this.placeholder,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
    super.key,
  });

  final String placeholder;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      style: const TextStyle(
        color: GoogleColors.grey900,
        fontSize: 15,
        fontFamily: 'Roboto',
      ),
      decoration: InputDecoration(
        labelText: placeholder,
        labelStyle: const TextStyle(color: GoogleColors.grey700),
        prefixIcon: Icon(icon, color: GoogleColors.blue),
        filled: true,
        fillColor: Colors.white,
        floatingLabelStyle: const TextStyle(color: GoogleColors.blue),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: GoogleColors.grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: GoogleColors.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: GoogleColors.blue, width: 2),
        ),
      ),
    );
  }
}

class GoogleCard extends StatelessWidget {
  const GoogleCard({
    required this.child,
    this.margin = const EdgeInsets.only(bottom: 12),
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: GoogleColors.grey200, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class GoogleButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color color;
  final Color textColor;
  final bool outline;

  const GoogleButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.color = GoogleColors.blue,
    this.textColor = Colors.white,
    this.outline = false,
    super.key,
  });

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 80),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.outline ? Colors.transparent : widget.color,
            borderRadius: BorderRadius.circular(8),
            border: widget.outline ? Border.all(color: widget.color, width: 1.5) : null,
            boxShadow: widget.outline
                ? null
                : [
                    BoxShadow(
                      color: widget.color.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: widget.outline ? widget.color : widget.textColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.outline ? widget.color : widget.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
