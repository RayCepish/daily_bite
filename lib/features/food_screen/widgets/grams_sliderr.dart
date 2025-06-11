import 'package:flutter/material.dart';

class GramSlider extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final void Function(int) onChanged;

  const GramSlider({
    super.key,
    this.initialValue = 100,
    this.minValue = 1,
    this.maxValue = 1000,
    required this.onChanged,
  });

  @override
  State<GramSlider> createState() => _GramSliderState();
}

class _GramSliderState extends State<GramSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 6.0,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      ),
      child: Slider(
        value: _currentValue,
        min: widget.minValue.toDouble(),
        max: widget.maxValue.toDouble(),
        divisions: widget.maxValue - widget.minValue,
        onChanged: (value) {
          setState(() => _currentValue = value);
          widget.onChanged(value.round());
        },
      ),
    );
  }
}
