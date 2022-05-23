import 'package:flutter/material.dart';

const double _kProgressIndicatorHeightDefault = 12;

class QuizProgressIndicator extends ProgressIndicator {
  const QuizProgressIndicator({
    Key? key,
    double? value,
    Color? backgroundColor = Colors.white,
    Color? color,
    this.height = _kProgressIndicatorHeightDefault,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          color: color,
        );

  final double height;

  @override
  _QuizProgressIndicatorState createState() => _QuizProgressIndicatorState();
}

class _QuizProgressIndicatorState extends State<QuizProgressIndicator>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  late final progressRadius = const BorderRadius.all(const Radius.circular(10));
  late final progressShadow = const [
    const BoxShadow(
      color: const Color(0x29000000),
      offset: const Offset(0, 3),
      blurRadius: 6,
    ),
  ];

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newValue = widget.value ?? 0.0;

    if (controller.value > 0.0)
      controller.animateTo(newValue);
    else
      controller.value = newValue;

    // return _buildIndicator(context);
    return AnimatedBuilder(
      animation: controller.view,
      builder: (BuildContext context, Widget? child) {
        return _buildIndicator(context, controller.value);
      },
    );
  }

  Widget _buildIndicator(BuildContext context, double value) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: progressShadow,
        borderRadius: progressRadius,
        color: widget.backgroundColor,
      ),
      height: widget.height,
      width: double.infinity,
      child: FractionallySizedBox(
        // axis: Axis.horizontal,
        // sizeFactor: controller,
        // axisAlignment: -1.0,
        alignment: Alignment.centerLeft,
        widthFactor: value,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: progressRadius,
            color: widget.color ?? Theme.of(context).primaryColor,
            boxShadow: progressShadow,
          ),
        ),
      ),
    );
  }
}
