import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';
import 'package:muslim_werd_app/core/widgets/image_with_low_opacity_and_text.dart';
import 'package:muslim_werd_app/features/home/logic/home_grid_view_item_model.dart';

class HomeGridViewItem extends StatefulWidget {
  const HomeGridViewItem({super.key, required this.homeModel});

  final HomeGridViewItemModel homeModel;

  @override
  State<HomeGridViewItem> createState() => _HomeGridViewItemState();
}

class _HomeGridViewItemState extends State<HomeGridViewItem>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  double _elevation = 2.0;
  late final Animation _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapAnimated() {
    setState(() {
      _scale = 1.1;
      _elevation = 10.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTapAnimated();
      },

      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0x1AFFFEFF),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: _elevation,
                offset: Offset(0, _elevation / 2),
              ),
            ],
          ),
          child: BackgroundLowOpacityWithText(
            backgroundImage: widget.homeModel.image,
            child: Text(
              
              widget.homeModel.text,
              textAlign: TextAlign.center,
              style: TextStyles.amiri36Bold.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
