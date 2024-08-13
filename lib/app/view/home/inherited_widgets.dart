import 'package:flutter/material.dart';

/// An inherited widget that provides a special color to its descendants.
class SpecialColor extends InheritedWidget {
  /// Creates a [SpecialColor] widget.
  ///
  /// The [color] parameter must not be null.
  const SpecialColor({
    super.key,
    required this.color,
    required Widget child,
  }) : super(child: child);

  /// The color to be provided to the descendants.
  final Color color;

  /// Retrieves the nearest [SpecialColor] widget up the widget tree.
  ///
  /// This method must be called within a widget that is a descendant of
  /// a [SpecialColor] widget. If no [SpecialColor] widget is found in the
  /// widget tree, an assertion error is thrown.
  static SpecialColor of(BuildContext context) {
    final SpecialColor? result = context.dependOnInheritedWidgetOfExactType<SpecialColor>();
    assert(result != null, 'No SpecialColor found in context');
    return result!;
  }

  /// Determines whether the widget should notify its descendants about changes.
  ///
  /// Returns true if the color has changed, otherwise false.
  @override
  bool updateShouldNotify(SpecialColor oldWidget) {
    return oldWidget.color != color;
  }
}