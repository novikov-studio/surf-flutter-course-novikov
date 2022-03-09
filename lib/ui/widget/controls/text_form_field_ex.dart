import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';

/// Виджет "Текстовое поле" с нестандартной логикой состояний.
///
///  - суффикс-иконка отображается только при наличии текста и фокуса;
///  - стиль обводки без фокуса зависит от наличия текста.
class TextFormFieldEx extends StatefulWidget {
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType keyboardType;
  final int? minLines;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String> onSaved;

  const TextFormFieldEx({
    Key? key,
    this.keyboardType = TextInputType.text,
    required this.focusNode,
    this.nextFocusNode,
    this.minLines,
    this.hintText,
    this.validator,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<TextFormFieldEx> createState() => TextFormFieldExState();
}

class TextFormFieldExState extends State<TextFormFieldEx> {
  final _controller = TextEditingController();
  late InputBorder? _filledUnselectedBorder;
  late Widget? _clearButton;

  @override
  void initState() {
    super.initState();

    // Кнопка "Очистить"
    _clearButton = IconButton(
      icon: const SvgIcon(AppIcons.clear),
      splashRadius: 20.0,
      onPressed: _controller.clear,
    );
  }

  // Перед первым показом и при смене темы
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Граница поля для состояния "заполнено, ошибок нет, не в фокусе"
    // (такая же, как "в фокусе", только тоньше)
    final theme = Theme.of(context);
    _filledUnselectedBorder =
        theme.inputDecorationTheme.focusedBorder?.copyWith(
      borderSide: theme.inputDecorationTheme.focusedBorder?.borderSide
          .copyWith(width: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.text400OnBackground;
    final labelStyle = theme.textTheme.text400;

    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[widget.focusNode, _controller]),
      builder: (_, __) {
        final isEmpty = _controller.text.isEmpty;
        final hasFocus = widget.focusNode.hasFocus;

        return TextFormField(
          controller: _controller,
          focusNode: widget.focusNode,
          textInputAction: widget.nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          keyboardType: widget.keyboardType,
          style: textStyle,
          minLines: widget.minLines,
          maxLines: widget.minLines != null ? null : 1,
          decoration: InputDecoration(
            suffixIcon: !isEmpty && hasFocus ? _clearButton : null,
            enabledBorder:
                !isEmpty && !hasFocus ? _filledUnselectedBorder : null,
            helperText: '',
            // чтобы поле не скакало при появлении ошибки
            hintText: widget.hintText,
            helperStyle: labelStyle,
          ),
          validator: widget.validator,
          onSaved: widget.onSaved,
          onFieldSubmitted: (_) {
            if (widget.nextFocusNode != null) {
              widget.nextFocusNode!.requestFocus();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
