import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:miro/miro.dart';
import 'package:flutter/widgets.dart';

/// A widget that displays a tooltip when the user long-presses or hovers over a child widget.
///
/// The tooltip appears above or below the child, depending on the available space.
/// The tooltip can be styled using a [TooltipDecoration].
class Tooltip extends StatefulWidget {
  /// The widget to show when the user long-presses or hovers over this widget.
  final Widget child;

  /// The text to display in the tooltip.
  final String message;

  /// The decoration of the tooltip.
  final TooltipDecoration decoration;

  Tooltip({
    super.key,
    required this.child,
    required this.message,
    TooltipDecoration? decoration,
  }) : decoration = decoration ?? TooltipDecoration.styleFrom();

  @override
  State<Tooltip> createState() => _TooltipState();
}

class _TooltipState extends State<Tooltip> {
  final OverlayPortalController controller = OverlayPortalController();
  Timer? timer;
  Timer? panDownTimer;

  @override
  void dispose() {
    timer?.cancel();
    panDownTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.message.isEmpty) {
      return widget.child;
    }

    return Semantics(
      container: true,
      button: true,
      enabled: true,
      tooltip: widget.message,
      child: GestureDetector(
        // onLongPress: () => controller.show(),
        onTapDown: (details) {
          // If the input kind is mouse or trackpad, do not show the tooltip
          if (details.kind == PointerDeviceKind.mouse ||
              details.kind == PointerDeviceKind.trackpad) {
            return;
          }

          panDownTimer = Timer(
            widget.decoration.pressDuration,
            () {
              toggleTooltip();
            },
          );
        },
        onTapUp: (details) {
          panDownTimer?.cancel();
        },
        child: MouseRegion(
          onEnter: (event) => controller.show(),
          onExit: (event) => controller.hide(),
          child: OverlayPortal(
            controller: controller,
            overlayChildBuilder: (context) {
              final OverlayState overlayState = Overlay.of(
                context,
                debugRequiredFor: widget,
              );
              final RenderBox box =
                  this.context.findRenderObject()! as RenderBox;
              final Offset target = box.localToGlobal(
                box.size.center(Offset.zero),
                ancestor: overlayState.context.findRenderObject(),
              );

              double halfOfWidth;
              TooltipPosition position;

              final textPainter = TextPainter(
                text: TextSpan(
                  text: widget.message,
                  style: widget.decoration.style,
                ),
                textDirection: MiroTheme.of(context).textDirection,
              )..layout(
                  maxWidth: widget.decoration.maxWidth -
                      widget.decoration.padding * 2,
                );

              final tooltipHeight =
                  textPainter.size.height + widget.decoration.padding * 2;

              if (textPainter.size.width + widget.decoration.padding * 2 <
                  widget.decoration.maxWidth) {
                halfOfWidth =
                    (textPainter.size.width + widget.decoration.padding * 2) /
                        2;
              } else {
                halfOfWidth = widget.decoration.maxWidth / 2;
              }

              if (widget.decoration.fixedPosition != null) {
                position = widget.decoration.fixedPosition!;
              } else {
                if (target.dy +
                        box.size.height / 2 +
                        widget.decoration.spacing +
                        tooltipHeight >
                    MediaQuery.of(context).size.height) {
                  position = TooltipPosition.top;
                } else {
                  position = TooltipPosition.bottom;
                }
              }

              return Positioned(
                top: position == TooltipPosition.top
                    ? target.dy -
                        box.size.height / 2 -
                        tooltipHeight -
                        widget.decoration.spacing
                    : target.dy +
                        box.size.height / 2 +
                        widget.decoration.spacing,
                left: target.dx - halfOfWidth,
                child: Container(
                  padding: EdgeInsets.all(widget.decoration.padding),
                  constraints: BoxConstraints(
                    maxWidth: widget.decoration.maxWidth,
                  ),
                  decoration: BoxDecoration(
                    color: widget.decoration.backgroundColor,
                    borderRadius: widget.decoration.borderRadius,
                  ),
                  child: Text(
                    widget.message,
                    style: widget.decoration.style,
                    textAlign: widget.decoration.textAlign,
                    textDirection: widget.decoration.textDirection,
                  ),
                ),
              );
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void toggleTooltip() {
    controller.show();

    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(
      widget.decoration.duration,
      () {
        controller.hide();
      },
    );
  }
}

/// Decoration of a tooltip
class TooltipDecoration {
  /// The style of the tooltip text
  final TextStyle style;

  /// How to align the text inside the tooltip
  final TextAlign textAlign;

  /// The direction of the text inside the tooltip
  final TextDirection textDirection;

  /// The background color of the tooltip
  final Color backgroundColor;

  /// The border radius of the tooltip
  final BorderRadius borderRadius;

  /// The spacing between the tooltip and the target element
  final double spacing;

  /// The padding of the tooltip
  final double padding;

  /// The maximum width of the tooltip
  final double maxWidth;

  /// A fixed position for the tooltip
  ///
  /// If not null, this position will be used instead of a computed one
  final TooltipPosition? fixedPosition;

  /// The duration the tooltip stays visible
  final Duration duration;

  /// The duration the user has to press to show the tooltip
  final Duration pressDuration;

  const TooltipDecoration({
    required this.style,
    required this.textAlign,
    required this.textDirection,
    required this.backgroundColor,
    required this.borderRadius,
    required this.spacing,
    required this.padding,
    required this.maxWidth,
    required this.duration,
    required this.pressDuration,
    this.fixedPosition,
  });

  /// Creates a [TooltipDecoration] with default values.
  /// Each parameter can be overridden. The default values are:
  /// - style: [TextStyle(color: Colors.white)]
  /// - textAlign: [TextAlign.center]
  /// - textDirection: [TextDirection.ltr]
  /// - backgroundColor: [Colors.black.withOpacity(0.45)]
  /// - borderRadius: [BorderRadius.circular(8)]
  /// - spacing: [8]
  /// - padding: [8]
  /// - maxWidth: [150]
  /// - fixedPosition: [null]
  /// - duration: [Duration(seconds: 2)]
  /// - pressDuration: [Duration(milliseconds: 1500)]
  TooltipDecoration.styleFrom({
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double? spacing,
    double? padding,
    double? maxWidth,
    TooltipPosition? fixedPosition,
    Duration? duration,
    Duration? pressDuration,
  }) : this(
          style: style ??
              const TextStyle(
                color: Colors.white,
              ),
          textAlign: textAlign ?? TextAlign.center,
          textDirection: textDirection ?? TextDirection.ltr,
          backgroundColor: backgroundColor ?? Colors.black.withOpacity(0.45),
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          spacing: spacing ?? 8,
          padding: padding ?? 8,
          maxWidth: maxWidth ?? 150,
          fixedPosition: fixedPosition,
          duration: duration ?? const Duration(seconds: 2),
          pressDuration: pressDuration ?? const Duration(milliseconds: 1500),
        );

  @override
  String toString() {
    return 'TooltipDecoration(style: $style, textAlign: $textAlign, textDirection: $textDirection, backgroundColor: $backgroundColor, borderRadius: $borderRadius, spacing: $spacing, padding: $padding, maxWidth: $maxWidth, fixedPosition: $fixedPosition, duration: $duration, pressDuration: $pressDuration)';
  }
}

/// Positions of the tooltip.
///
/// The tooltip can be displayed above or below the widget.
enum TooltipPosition {
  /// The tooltip is displayed above the widget.
  top,

  /// The tooltip is displayed below the widget.
  bottom,
}
