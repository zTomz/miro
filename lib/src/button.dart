import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:miro/src/colors.dart';
import 'package:miro/src/tooltip.dart';

/// A button that provides a hover and pressed effect
class MiroButton extends StatefulWidget {
  /// Gets called when the button is tapped
  final void Function() onTap;

  /// The content of the button
  final Widget child;

  /// Gets called when the user hovers over the button
  final void Function(PointerEnterEvent event)? onEnter;

  /// Gets called when the user stops hovering over the button
  final void Function(PointerExitEvent event)? onExit;

  /// The cursor for mouse pointers when it enters or is hovering over the button
  final MouseCursor mouseCursor;

  /// Whether the button is enabled, default to true
  final bool enabled;

  /// The color when the button is hovered
  final Color hoverColor;

  /// The color when the button is pressed
  final Color tapColor;

  /// The border radius of the button
  final BorderRadius borderRadius;

  /// The focus node of the button
  final FocusNode? focusNode;

  /// Whether the button should be autofocused
  final bool autofocus;

  /// The tooltip of the button
  final String? tooltip;

  /// The decoration of the tooltip
  final TooltipDecoration? tooltipDecoration;

  /// Creates a MiroButton
  const MiroButton({
    super.key,
    required this.onTap,
    required this.child,
    this.onEnter,
    this.onExit,
    this.mouseCursor = SystemMouseCursors.click,
    this.enabled = true,
    this.hoverColor = Colors.transparent,
    this.tapColor = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
    this.tooltip,
    this.focusNode,
    this.autofocus = false,
    this.tooltipDecoration,
  });

  @override
  State<MiroButton> createState() => _MiroButtonState();
}

class _MiroButtonState extends State<MiroButton>
    with SingleTickerProviderStateMixin {
  MiroButtonState buttonState = MiroButtonState.normal;
  Offset panDownPosition = Offset.zero;

  late AnimationController popUpBubbleController;
  late Animation<double> popUpBubbleTween;

  GlobalKey bubbleKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (!widget.enabled) {
      buttonState = MiroButtonState.disabled;
    }

    popUpBubbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    popUpBubbleTween = Tween(begin: 0.0, end: pi / 2).animate(
      CurvedAnimation(
        parent: popUpBubbleController,
        curve: Curves.easeInCubic,
      ),
    );
  }

  @override
  void dispose() {
    popUpBubbleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: true,
      enabled: widget.enabled,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: IgnorePointer(
          ignoring: !widget.enabled,
          child: Tooltip(
            message: widget.tooltip ?? "",
            decoration: widget.tooltipDecoration,
            child: MouseRegion(
              onEnter: (event) {
                setState(() {
                  buttonState = MiroButtonState.hovered;
                });

                widget.onEnter?.call(event);
              },
              onExit: (event) {
                setState(() {
                  buttonState = MiroButtonState.normal;
                });

                widget.onExit?.call(event);
              },
              cursor: widget.enabled ? widget.mouseCursor : MouseCursor.defer,
              child: GestureDetector(
                onTap: widget.enabled ? widget.onTap : null,
                onTapDown: (details) {
                  popUpBubbleController.reset();
                  popUpBubbleController.forward();

                  setState(() {
                    buttonState = MiroButtonState.pressed;
                    panDownPosition = details.localPosition;
                  });
                },
                onTapUp: (details) {
                  popUpBubbleController.reset();

                  if (details.kind == PointerDeviceKind.touch) {
                    setState(() {
                      buttonState = MiroButtonState.normal;
                    });
                    return;
                  }

                  setState(() {
                    buttonState = MiroButtonState.hovered;
                  });
                },
                onTapCancel: () {
                  popUpBubbleController.reset();

                  setState(() {
                    buttonState = MiroButtonState.normal;
                  });
                },
                child: Stack(
                  children: [
                    SizedBox(
                      key: bubbleKey,
                      child: widget.child,
                    ),

                    // The colored box that will be shown when the button is hovered or pressed
                    if (buttonState == MiroButtonState.hovered ||
                        buttonState == MiroButtonState.pressed)
                      Positioned.fill(
                        child: ColoredBox(color: widget.hoverColor),
                      ),

                    if (buttonState == MiroButtonState.pressed)
                      AnimatedBuilder(
                        animation: popUpBubbleController,
                        builder: (context, _) {
                          final size = (bubbleKey.currentContext!
                                  .findRenderObject() as RenderBox)
                              .size;
                          final progress =
                              max(size.width * 1.3, size.height * 1.3) *
                                  popUpBubbleTween.value;

                          return Positioned(
                            left: panDownPosition.dx - progress / 2,
                            top: panDownPosition.dy - progress / 2,
                            child: Container(
                              width: progress,
                              height: progress,
                              decoration: BoxDecoration(
                                color: widget.tapColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The different states a button can have
enum MiroButtonState {
  /// The button is normal and not hovered or pressed
  normal,

  /// The button is focused
  hovered,

  /// The button is pressed
  pressed,

  /// The button is disabled
  disabled,

  /// The button is focused
  focused,
}
