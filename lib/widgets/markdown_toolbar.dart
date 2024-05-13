import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'toolbar.dart';
import 'modal_input_url.dart';
import 'modal_select_emoji.dart';
import 'toolbar_item.dart';

class MarkdownToolbar extends StatelessWidget {
  /// Preview/Eye button
  final VoidCallback? onPreviewChanged;
  final TextEditingController controller;
  final VoidCallback? unfocus;
  final bool emojiConvert;
  final bool autoCloseAfterSelectEmoji;
  final Toolbar toolbar;
  final Color? expandableBackground;
  final bool showPreviewButton;
  final bool showEmojiSelection;
  final VoidCallback? onActionCompleted;
  final String? markdownSyntax;
  final BoxDecoration? decoration;
  final bool showLinkInput;
  final bool showImageInput;
  final bool showClearButton;
  final bool showResetButton;
  final bool showSelectSingleLine;

  const MarkdownToolbar({
    super.key,
    this.onPreviewChanged,
    this.markdownSyntax,
    required this.controller,
    this.emojiConvert = true,
    this.unfocus,
    required this.toolbar,
    this.autoCloseAfterSelectEmoji = true,
    this.expandableBackground,
    this.onActionCompleted,
    this.showPreviewButton = true,
    this.showEmojiSelection = true,
    this.decoration,
    this.showLinkInput = true,
    this.showImageInput = true,
    this.showClearButton = true,
    this.showResetButton = true,
    this.showSelectSingleLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 45,
      decoration: decoration ?? BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // preview
            if (showPreviewButton)
              ToolbarItem(
                key: const ValueKey<String>("toolbar_view_item"),
                icon: FontAwesomeIcons.eye,
                onPressedButton: onPreviewChanged,
                tooltip: 'Show/Hide markdown preview',
              ),
            // Clear the field
            if (showClearButton)
            ToolbarItem(
              key: const ValueKey<String>("toolbar_clear_action"),
              icon: FontAwesomeIcons.trashCan,
              onPressedButton: () {
                controller.clear();
                onActionCompleted?.call();
              },
              tooltip: 'Clear the text field',
            ),
            if (showResetButton)
            // Reset the text field
            ToolbarItem(
              key: const ValueKey<String>("toolbar_reset_action"),
              icon: FontAwesomeIcons.arrowRotateLeft,
              onPressedButton: () {
                if (markdownSyntax != null) {
                  controller.text = markdownSyntax!;
                  onActionCompleted?.call();
                }
              },
              tooltip: 'Reset the text field to specified format',
            ),
            if (showSelectSingleLine)
            // select single line
            ToolbarItem(
              key: const ValueKey<String>("toolbar_selection_action"),
              icon: FontAwesomeIcons.textWidth,
              onPressedButton: () {
                toolbar.selectSingleLine.call();
                onActionCompleted?.call();
              },
              tooltip: 'Select single line',
            ),
            // bold
            ToolbarItem(
              key: const ValueKey<String>("toolbar_bold_action"),
              icon: FontAwesomeIcons.bold,
              tooltip: 'Make text bold',
              onPressedButton: () {
                toolbar.action("**", "**");
                onActionCompleted?.call();
              },
            ),
            // italic
            ToolbarItem(
              key: const ValueKey<String>("toolbar_italic_action"),
              icon: FontAwesomeIcons.italic,
              tooltip: 'Make text italic',
              onPressedButton: () {
                toolbar.action("_", "_");
                onActionCompleted?.call();
              },
            ),
            // strikethrough
            ToolbarItem(
              key: const ValueKey<String>("toolbar_strikethrough_action"),
              icon: FontAwesomeIcons.strikethrough,
              tooltip: 'Strikethrough',
              onPressedButton: () {
                toolbar.action("~~", "~~");
                onActionCompleted?.call();
              },
            ),
            // heading
            ToolbarItem(
              key: const ValueKey<String>("toolbar_heading_action"),
              icon: FontAwesomeIcons.heading,
              isExpandable: true,
              tooltip: 'Insert Heading',
              expandableBackground: expandableBackground,
              items: [
                ToolbarItem(
                  key: const ValueKey<String>("h1"),
                  icon: "H1",
                  tooltip: 'Insert Heading 1',
                  onPressedButton: () {
                    toolbar.action("# ", "");
                    onActionCompleted?.call();
                  },
                ),
                ToolbarItem(
                  key: const ValueKey<String>("h2"),
                  icon: "H2",
                  tooltip: 'Insert Heading 2',
                  onPressedButton: () {
                    toolbar.action("## ", "");
                    onActionCompleted?.call();
                  },
                ),
                ToolbarItem(
                  key: const ValueKey<String>("h3"),
                  icon: "H3",
                  tooltip: 'Insert Heading 3',
                  onPressedButton: () {
                    toolbar.action("### ", "");
                    onActionCompleted?.call();
                  },
                ),
                ToolbarItem(
                  key: const ValueKey<String>("h4"),
                  icon: "H4",
                  tooltip: 'Insert Heading 4',
                  onPressedButton: () {
                    toolbar.action("#### ", "");
                    onActionCompleted?.call();
                  },
                ),
                // Heading 5 onwards has same font
              ],
            ),
            // unorder list
            ToolbarItem(
              key: const ValueKey<String>("toolbar_unorder_list_action"),
              icon: FontAwesomeIcons.listUl,
              tooltip: 'Unordered list',
              onPressedButton: () {
                toolbar.action("* ", "");
                onActionCompleted?.call();
              },
            ),
            // checkbox list
            ToolbarItem(
              key: const ValueKey<String>("toolbar_checkbox_list_action"),
              icon: FontAwesomeIcons.listCheck,
              isExpandable: true,
              expandableBackground: expandableBackground,
              items: [
                ToolbarItem(
                  key: const ValueKey<String>("checkbox"),
                  icon: FontAwesomeIcons.solidSquareCheck,
                  tooltip: 'Checked checkbox',
                  onPressedButton: () {
                    toolbar.action("- [x] ", "");
                    onActionCompleted?.call();
                  },
                ),
                ToolbarItem(
                  key: const ValueKey<String>("uncheckbox"),
                  icon: FontAwesomeIcons.square,
                  tooltip: 'Unchecked checkbox',
                  onPressedButton: () {
                    toolbar.action("- [ ] ", "");
                    onActionCompleted?.call();
                  },
                )
              ],
            ),
            // emoji
            if (showEmojiSelection)
              ToolbarItem(
                key: const ValueKey<String>("toolbar_emoji_action"),
                icon: FontAwesomeIcons.faceSmile,
                tooltip: 'Select emoji',
                onPressedButton: () async {
                  await _showModalSelectEmoji(context, controller.selection);
                },
              ),
            // link
            if (showLinkInput)
            ToolbarItem(
              key: const ValueKey<String>("toolbar_link_action"),
              icon: FontAwesomeIcons.link,
              tooltip: 'Add hyperlink',
              onPressedButton: () async {
                if (toolbar.hasSelection) {
                  toolbar.action("[enter link description here](", ")");
                } else {
                  await _showModalInputUrl(context, "[enter link description here](", controller.selection);
                }

                onActionCompleted?.call();
              },
            ),
            // image
            if (showImageInput)
            ToolbarItem(
              key: const ValueKey<String>("toolbar_image_action"),
              icon: FontAwesomeIcons.image,
              tooltip: 'Add image',
              onPressedButton: () async {
                if (toolbar.hasSelection) {
                  toolbar.action("![enter image description here](", ")");
                } else {
                  await _showModalInputUrl(
                    context,
                    "![enter image description here](",
                    controller.selection,
                  );
                }

                onActionCompleted?.call();
              },
            ),
            // blockquote
            ToolbarItem(
              key: const ValueKey<String>("toolbar_blockquote_action"),
              icon: FontAwesomeIcons.quoteLeft,
              tooltip: 'Blockquote',
              onPressedButton: () {
                toolbar.action("> ", "");
                onActionCompleted?.call();
              },
            ),
            // code
            ToolbarItem(
              key: const ValueKey<String>("toolbar_code_action"),
              icon: FontAwesomeIcons.code,
              tooltip: 'Code syntax/font',
              onPressedButton: () {
                toolbar.action("`", "`");
                onActionCompleted?.call();
              },
            ),
            // line
            ToolbarItem(
              key: const ValueKey<String>("toolbar_line_action"),
              icon: FontAwesomeIcons.rulerHorizontal,
              tooltip: 'Add line',
              onPressedButton: () {
                toolbar.action("\n___\n", "");
                onActionCompleted?.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Show modal to select emoji
  Future<dynamic> _showModalSelectEmoji(BuildContext context, TextSelection selection) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return ModalSelectEmoji(
          emojiConvert: emojiConvert,
          onChanged: (String emot) {
            if (autoCloseAfterSelectEmoji) Navigator.pop(context);
            final newSelection = toolbar.getSelection(selection);

            toolbar.action(emot, "", textSelection: newSelection);
            // change selection baseoffset if not auto close emoji
            if (!autoCloseAfterSelectEmoji) {
              selection = TextSelection.collapsed(
                offset: newSelection.baseOffset + emot.length,
              );
              unfocus?.call();
            }
            onActionCompleted?.call();
          },
        );
      },
    );
  }

  // show modal input
  Future<dynamic> _showModalInputUrl(
    BuildContext context,
    String leftText,
    TextSelection selection,
  ) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ModalInputUrl(
          toolbar: toolbar,
          leftText: leftText,
          selection: selection,
          onActionCompleted: onActionCompleted,
        );
      },
    );
  }
}
