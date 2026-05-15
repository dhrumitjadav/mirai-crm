import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class AddNoteSheet extends StatefulWidget {
  final void Function(String text, bool isPinned) onSave;

  const AddNoteSheet({super.key, required this.onSave});

  @override
  State<AddNoteSheet> createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends State<AddNoteSheet> {
  final _noteCtrl = TextEditingController();
  bool _isPinned = false;

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: CommonColors.borderDefault),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CommonColors.blackColor.withValues(alpha: 0.08),
                    offset: Offset(0, 2),
                    blurRadius: 2,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: RS.VS(10)),
                      width: RS.HS(36),
                      height: RS.VS(4),
                      decoration: BoxDecoration(
                        color: CommonColors.grey300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      RS.HS(16),
                      RS.VS(16),
                      RS.HS(16),
                      RS.VS(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Note',
                          style: TextStyle(
                            fontSize: RS.FS(16),
                            fontWeight: FontWeight.w700,
                            color: CommonColors.textPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: RS.HS(32),
                            height: RS.HS(32),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CommonColors.grey75,
                            ),
                            child: Icon(
                              Icons.close,
                              size: RS.HS(16),
                              color: CommonColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: RS.VS(16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.HS(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Note',
                        style: TextStyle(
                          fontSize: RS.FS(14),
                          color: CommonColors.textPrimary,
                        ),
                      ),
                      Text(
                        ' *',
                        style: TextStyle(
                          fontSize: RS.FS(12),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: RS.VS(8)),
                  TextField(
                    controller: _noteCtrl,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(
                      fontSize: RS.FS(14),
                      color: CommonColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write a Note about this Lead...',
                      hintStyle: TextStyle(
                        fontSize: RS.FS(14),
                        color: CommonColors.textPlaceholder,
                      ),
                      filled: true,
                      fillColor: CommonColors.whiteColor,
                      contentPadding: EdgeInsets.all(RS.HS(12)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: CommonColors.borderDefault,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: CommonColors.borderDefault,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: CommonColors.borderFocus,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: RS.VS(12)),
                  GestureDetector(
                    onTap: () => setState(() => _isPinned = !_isPinned),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: RS.HS(18),
                          height: RS.HS(18),
                          decoration: BoxDecoration(
                            color: _isPinned
                                ? CommonColors.primaryColor
                                : CommonColors.whiteColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _isPinned
                                  ? CommonColors.primaryColor
                                  : CommonColors.borderDefault,
                            ),
                          ),
                          child: _isPinned
                              ? Icon(
                                  Icons.check,
                                  size: RS.HS(12),
                                  color: CommonColors.whiteColor,
                                )
                              : null,
                        ),
                        SizedBox(width: RS.HS(10)),
                        Text(
                          'Pin to top of Notes',
                          style: TextStyle(
                            fontSize: RS.FS(14),
                            color: CommonColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: RS.VS(20)),
                  SizedBox(
                    width: double.infinity,
                    height: RS.VS(52),
                    child: ElevatedButton(
                      onPressed: () {
                        final text = _noteCtrl.text.trim();
                        if (text.isEmpty) return;
                        widget.onSave(text, _isPinned);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CommonColors.primaryColor,
                        foregroundColor: CommonColors.whiteColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Save Note',
                        style: TextStyle(
                          fontSize: RS.FS(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: RS.VS(24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
