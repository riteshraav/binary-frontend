import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedSaveButton extends StatefulWidget {
  final VoidCallback onPressed;
  final FocusNode focusNode;

  const AnimatedSaveButton({Key? key, required this.onPressed,required this.focusNode}) : super(key: key);

  @override
  _AnimatedSaveButtonState createState() => _AnimatedSaveButtonState();
}

class _AnimatedSaveButtonState extends State<AnimatedSaveButton>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _clickController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _shadowAnimation;
  late Animation<Color?> _gradientAnimation;

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    // Hover animation controller
    _hoverController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    // Click animation controller
    _clickController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );

    // Scale animation for hover effect
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    // Elevation animation for hover
    _elevationAnimation = Tween<double>(
      begin: 4.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    // Shadow animation
    _shadowAnimation = Tween<double>(
      begin: 12.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    // Gradient color animation
    _gradientAnimation = ColorTween(
      begin: Color(0xFF2563EB),
      end: Color(0xFF1E40AF),
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _clickController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _clickController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _clickController.reverse();
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _clickController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _clickController]),
      builder: (context, child) {
        return MouseRegion(
          onEnter: (_) => _onHover(true),
          onExit: (_) => _onHover(false),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,

            child: Transform.scale(
              scale: _isPressed
                  ? _scaleAnimation.value * 0.95  // Slightly smaller when pressed
                  : _scaleAnimation.value,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _gradientAnimation.value ?? Color(0xFF2563EB),
                      _isHovered ? Color(0xFF1E40AF) : Color(0xFF1D4ED8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: (_gradientAnimation.value ?? Color(0xFF2563EB))
                          .withOpacity(_isHovered ? 0.4 : 0.25),
                      spreadRadius: 0,
                      blurRadius: _shadowAnimation.value,
                      offset: Offset(0, _elevationAnimation.value),
                    ),
                    // Additional glow effect on hover
                    if (_isHovered)
                      BoxShadow(
                        color: Color(0xFF2563EB).withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 25,
                        offset: Offset(0, 0),
                      ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusNode: widget.focusNode,
                    onTap: widget.onPressed,
                    borderRadius: BorderRadius.circular(12),
                    splashColor: Colors.white.withOpacity(0.1),
                    highlightColor: Colors.white.withOpacity(0.05),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            transform: Matrix4.identity()
                              ..rotateZ(_isPressed ? 0.1 : 0)  // Slight rotation on press
                              ..scale(_isHovered ? 1.1 : 1.0), // Scale icon on hover
                            child: Icon(
                              Icons.save_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: _isHovered ? 15.5 : 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: _isHovered ? 0.4 : 0.3,
                            ),
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

