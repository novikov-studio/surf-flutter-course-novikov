import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen_widget_model.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/add_sight_photos.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/controls/svg_text_button.dart';
import 'package:places/ui/widget/controls/text_form_field_ex.dart';

/// Экран "Новое место".
class AddSightScreen extends ElementaryWidget<IAddSightScreenWidgetModel> {
  const AddSightScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultAddSightScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAddSightScreenWidgetModel wm) {
    return ValueListenableBuilder<bool>(
      valueListenable: wm.dataIsSending,
      builder: (context, isSending, _) {
        return AbsorbPointer(
          absorbing: isSending,
          child: Scaffold(
            appBar: SimpleAppBar(
              title: AppStrings.newSightTitle,
              leadingText: AppStrings.cancel,
              leadingOnTap: wm.back,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: wm.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: wm.onFormChanged,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            spacerH24,
                            FormField<List<String>>(
                              key: wm.urlsKey,
                              builder: (field) => AddSightPhotos(
                                initialValue: field.value,
                                onChange: wm.onUrlsChanged,
                              ),
                              initialValue: wm.data.urls,
                              validator: Validators.checkListNotEmpty,
                              onSaved: (value) =>
                                  wm.data.urls = value ?? <String>[],
                            ),
                            spacerH24,
                            _LabeledField(
                              label: AppStrings.category,
                              usePadding: false,
                              child: FormField<Category>(
                                key: wm.categoryKey,
                                builder: (field) => ListTile(
                                  title: Text(
                                    field.value?.title ?? AppStrings.notChosen,
                                    style: field.isValid
                                        ? wm.theme.textTheme.text400
                                        : wm.theme.text400Secondary2,
                                  ),
                                  trailing: const SvgIcon(AppIcons.view),
                                  contentPadding: EdgeInsets.zero,
                                  onTap: wm.showCategoryPicker,
                                ),
                                initialValue: wm.data.type,
                                validator: Validators.checkNotNull,
                                onSaved: (value) => wm.data.type = value,
                              ),
                            ),
                            spacerH12,
                            _LabeledField(
                              label: AppStrings.name,
                              child: TextFormFieldEx(
                                hintText: AppStrings.enterString,
                                validator: Validators.checkNotEmpty,
                                onSaved: (value) => wm.data.name = value,
                                focusNode: wm.focusNode(0),
                                nextFocusNode: wm.focusNode(1),
                              ),
                            ),
                            spacerH12,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _LabeledField(
                                    label: AppStrings.latitude,
                                    child: TextFormFieldEx(
                                      hintText: AppStrings.enterNumber,
                                      validator: Validators.checkLatitude,
                                      onSaved: (value) => wm.data.latitude =
                                          double.parse(value!),
                                      focusNode: wm.focusNode(1),
                                      nextFocusNode: wm.focusNode(2),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        signed: true,
                                        decimal: true,
                                      ),
                                    ),
                                  ),
                                ),
                                spacerW16,
                                Expanded(
                                  child: _LabeledField(
                                    label: AppStrings.longitude,
                                    child: TextFormFieldEx(
                                      hintText: AppStrings.enterNumber,
                                      validator: Validators.checkLongitude,
                                      onSaved: (value) => wm.data.longitude =
                                          double.parse(value!),
                                      focusNode: wm.focusNode(2),
                                      nextFocusNode: wm.focusNode(3),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        signed: true,
                                        decimal: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Transform.translate(
                                offset: const Offset(-8.0, 0),
                                child: SvgTextButton.link(
                                  label: AppStrings.pointOnMap,
                                  color: wm.theme.colorScheme.green,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  onPressed: wm.pointOnMap,
                                ),
                              ),
                            ),
                            spacerH12,
                            _LabeledField(
                              label: AppStrings.description,
                              child: TextFormFieldEx(
                                hintText: AppStrings.enterText,
                                onSaved: (value) => wm.data.details =
                                    (value?.isNotEmpty ?? false) ? value : null,
                                focusNode: wm.focusNode(3),
                                minLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    spacerH12,
                    ValueListenableBuilder<bool>(
                      valueListenable: wm.dataIsValid,
                      builder: (_, isValid, child) => ElevatedButton(
                        onPressed: isValid ? wm.addNewSight : null,
                        child: child,
                      ),
                      child: isSending
                          ? Loader(size: wm.loaderSize)
                          : const Text(AppStrings.create),
                    ),
                    spacerH8,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Виджет добавляет текстовый заголовок [label] над [child].
class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  final bool usePadding;

  const _LabeledField({
    Key? key,
    required this.label,
    required this.child,
    this.usePadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).superSmallInactiveBlack,
        ),
        if (usePadding) spacerH12,
        child,
      ],
    );
  }
}
