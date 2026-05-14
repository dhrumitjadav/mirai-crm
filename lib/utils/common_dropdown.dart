import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class CommonDropdown extends StatefulWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CommonDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;
  final _layerLink = LayerLink();

  void _toggle() => _isOpen ? _close() : _open();

  void _open() {
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  void _select(String item) {
    widget.onChanged(item);
    _close();
  }

  OverlayEntry _buildOverlay() {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;

    return OverlayEntry(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _close,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 4),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CommonColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CommonColors.borderDefault),
                      boxShadow: [
                        BoxShadow(
                          color: CommonColors.blackColor.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.items.map((item) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _select(item),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.w(16),
                              vertical: context.h(14),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: context.s(14),
                                  color: CommonColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.value != null && widget.value!.isNotEmpty;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggle,
        child: Container(
          height: context.h(50),
          padding: EdgeInsets.symmetric(horizontal: context.w(14)),
          decoration: BoxDecoration(
            color: CommonColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isOpen
                  ? CommonColors.appRedColor
                  : CommonColors.borderDefault,
              width: _isOpen ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hasValue ? widget.value! : widget.hint,
                  style: TextStyle(
                    fontSize: context.s(14),
                    color: hasValue
                        ? CommonColors.textPrimary
                        : CommonColors.textTertiary,
                  ),
                ),
              ),
              Icon(
                _isOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: context.w(22),
                color: CommonColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
