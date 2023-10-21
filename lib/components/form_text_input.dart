import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormTextInput extends StatefulWidget {
  const FormTextInput({
    super.key,
    required this.label,
    this.keyBoardType = TextInputType.text,
    this.validators,
    this.autofocus = false,
    this.autocorrect = false,
    this.obscured = false,
    this.required = true,
    this.email = false,
    this.password = false,
    this.maxWords = 1,
  });

  final String label;
  final TextInputType keyBoardType;
  final List<FormFieldValidator<String>>? validators;
  final bool autocorrect;
  final bool autofocus;
  final bool obscured;
  final bool required;
  final bool email;
  final bool password;
  final int maxWords;

  @override
  State<FormTextInput> createState() => _FormTextInputState();
}

class _FormTextInputState extends State<FormTextInput> {
  final textFieldController = TextEditingController();
  bool textObscured = true;

  FormFieldValidator<String?> passwordValidator() {
    RegExp expresion = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[A-Z])');

    return (String? valueCandidate) {
      if (!expresion.hasMatch(valueCandidate!)) {
        return 'form.error.password'.tr();
      }

      return null;
    };
  }

  List<FormFieldValidator<String>> validatorsList() {
    final List<FormFieldValidator<String>> validators = widget.validators ?? [];

    if (widget.required) {
      validators.add(FormBuilderValidators.required(
        errorText: 'form.error.required'.tr(args: [widget.label]),
      ));
    }

    if (widget.email) {
      validators.add(FormBuilderValidators.email(
        errorText: 'form.error.invalid_format'.tr(),
      ));
    }

    if (widget.password) {
      validators.add(passwordValidator());
      validators.add(FormBuilderValidators.minLength(
        8,
        errorText: 'form.error.min_length'.tr(args: ['8']),
      ));
    }

    int maxWords = widget.maxWords;
    if (maxWords >= 0) {
      validators.add(FormBuilderValidators.maxWordsCount(
        maxWords,
        errorText: 'form.error.max_words'.tr(args: [maxWords.toString()]),
      ));
    }

    return validators;
  }

  Widget? generateSuffixIcon() {
    if (widget.obscured) {
      return IconButton(
        icon: Icon(
          textObscured ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() => textObscured = !textObscured);
        },
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        FormBuilderTextField(
          controller: textFieldController,
          name: widget.label.toLowerCase().replaceAll(' ', '_'),
          autofocus: widget.autofocus,
          autocorrect: widget.autocorrect,
          obscureText: widget.obscured && textObscured,
          keyboardType: widget.keyBoardType,
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            suffixIcon: generateSuffixIcon(),
          ),
          validator: FormBuilderValidators.compose(validatorsList()),
        ),
      ],
    );
  }
}
