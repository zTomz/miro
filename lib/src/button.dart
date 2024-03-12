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

class _MiroButtonState extends State<MiroButton> {
  MiroButtonState buttonState = MiroButtonState.normal;

  @override
  void initState() {
    super.initState();

    if (!widget.enabled) {
      buttonState = MiroButtonState.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: true,
      enabled: widget.enabled,
      focusable: true,
      focused: buttonState == MiroButtonState.focused,
      tooltip: widget.tooltip,
      child: Focus(
        focusNode: widget.focusNode,
        onFocusChange: (value) {
          setState(() {
            buttonState =
                value ? MiroButtonState.focused : MiroButtonState.normal;
          });
        },
        onKeyEvent: (focusNode, event) {
          if (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.numpadEnter) {
            widget.onTap();

            return KeyEventResult.handled;
          }

          return KeyEventResult.ignored;
        },
        autofocus: widget.autofocus,
        child: Tooltip(
          message: widget.tooltip ?? "",
          decoration: widget.tooltipDecoration,
          child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: IgnorePointer(
              ignoring: !widget.enabled,
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
                  onTapDown: (_) {
                    setState(() {
                      buttonState = MiroButtonState.pressed;
                    });
                  },
                  onTapUp: (details) {
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
                    setState(() {
                      buttonState = MiroButtonState.normal;
                    });
                  },
                  child: Stack(
                    children: [
                      widget.child,
                      // The colored box that will be shown when the button is hovered or pressed
                      Positioned.fill(
                        child: ColoredBox(
                          color: buttonState == MiroButtonState.disabled ||
                                  buttonState == MiroButtonState.normal
                              ? Colors.transparent
                              : buttonState == MiroButtonState.pressed
                                  ? widget.tapColor
                                  : widget.hoverColor,
                        ),
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
