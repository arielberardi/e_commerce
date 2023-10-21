import 'package:e_commerce/components/brand_logo.dart';
import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:e_commerce/components/buttons/secondary_button.dart';
import 'package:e_commerce/components/form_text_input.dart';
import 'package:e_commerce/services/auth_service.dart';
import 'package:e_commerce/utils/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  void signIn(BuildContext context, Map<String, dynamic>? values) {
    UIUtil.showCircularSpinner(context);

    AuthService.signIn(values!['email'], values['password']).then((_) {
      UIUtil.resetToRootPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);

      UIUtil.showError(
        context,
        body: AuthService.parseError(error),
        title: 'dialogs.error.title'.tr(),
      );
    });
  }

  void signInWithGoogle(BuildContext context) {
    UIUtil.showCircularSpinner(context);

    AuthService.signInWithGoogle().then((_) {
      UIUtil.resetToRootPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);

      UIUtil.showError(
        context,
        body: AuthService.parseError(error),
        title: 'dialogs.error.title'.tr(),
      );
    });
  }

  void signInWithFacebook(BuildContext context) {
    UIUtil.showCircularSpinner(context);

    AuthService.signInWithFacebook().then((_) {
      UIUtil.resetToRootPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);

      UIUtil.showError(
        context,
        body: AuthService.parseError(error),
        title: 'dialogs.error.title'.tr(),
      );
    });
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
                'page.sign_in.title'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 15.0),
              Text(
                'page.sign_in.sub_title'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30.0),
              FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 30),
                    PrimaryButton(
                      padding: EdgeInsets.zero,
                      text: 'sign_in'.tr(),
                      onPressed: () {
                        if (formKey.currentState?.saveAndValidate() == true) {
                          signIn(context, formKey.currentState?.value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const TextDivider(),
              const SizedBox(height: 30),
              PrimaryButton(
                padding: EdgeInsets.zero,
                onPressed: () => signInWithFacebook(context),
                icon: const Icon(Icons.facebook),
                text: 'page.sign_in.facebook'.tr(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 15),
              SecondaryButton(
                padding: EdgeInsets.zero,
                onPressed: () => signInWithGoogle(context),
                icon: SvgPicture.asset(
                  'assets/images/google_icon.svg',
                  width: 20,
                ),
                text: 'page.sign_in.google'.tr(),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: .5, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextDivider extends StatelessWidget {
  const TextDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(child: Divider(color: Colors.grey)),
        const SizedBox(width: 5.0),
        Text('page.sign_in.divider'.tr()),
        const SizedBox(width: 5.0),
        const Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }
}
