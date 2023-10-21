import 'package:e_commerce/components/brand_logo.dart';
import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:e_commerce/components/form_text_input.dart';
import 'package:e_commerce/pages/sign_up_correct_page.dart';
import 'package:e_commerce/services/auth_service.dart';
import 'package:e_commerce/utils/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  void signUp(BuildContext context, Map<String, dynamic>? values) {
    UIUtil.showCircularSpinner(context);

    final String email = values!['email'];
    final String password = values['password'];
    final String userName = values['user_name'];

    AuthService.signUp(email, password, userName).then((_) {
      UIUtil.closeDialog(context);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpCorrectPage()),
      );
    }).catchError((error) {
      UIUtil.closeDialog(context);

      UIUtil.showError(
        context,
        body: AuthService.parseError(error),
        title: 'dialogs.error.title'.tr(),
      );
    });
  }

  FormFieldValidator<String?> confirmedPasswordValidator() {
    return (String? valueCandidate) {
      final label = 'form.field.password'.tr();
      final name = label.toLowerCase().replaceAll(' ', '_');
      final fieldValue = formKey.currentState?.fields[name]?.value;

      if (fieldValue != valueCandidate) {
        return 'form.error.password_not_match'.tr();
      }

      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100.0),
              const Center(child: BrandLogo(color: Colors.black)),
              const SizedBox(height: 50.0),
              Text(
                'page.sign_up.title'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 15.0),
              Text(
                'page.sign_up.sub_title'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30.0),
              FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextInput(
                      label: 'form.field.user_name'.tr(),
                      autofocus: true,
                    ),
                    const SizedBox(height: 15),
                    FormTextInput(
                      label: 'form.field.email'.tr(),
                      email: true,
                    ),
                    const SizedBox(height: 15),
                    FormTextInput(
                      label: 'form.field.password'.tr(),
                      obscured: true,
                      password: true,
                    ),
                    const SizedBox(height: 15),
                    FormTextInput(
                      label: 'form.field.confirm_password'.tr(),
                      obscured: true,
                      validators: [confirmedPasswordValidator()],
                    ),
                    const SizedBox(height: 15),
                    FormBuilderCheckbox(
                      name: 'toc',
                      title: Text(
                        'page.sign_up.form.toc'.tr(),
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      initialValue: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      checkColor: Theme.of(context).colorScheme.primary,
                      validator: (value) {
                        String error = 'page.sign_up.form.error.toc'.tr();
                        return value == false ? error : null;
                      },
                    ),
                    const SizedBox(height: 15),
                    PrimaryButton(
                      padding: EdgeInsets.zero,
                      text: 'sign_up'.tr(),
                      onPressed: () {
                        if (formKey.currentState?.saveAndValidate() == true) {
                          signUp(context, formKey.currentState?.value);
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
