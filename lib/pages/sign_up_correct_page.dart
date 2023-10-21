import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:e_commerce/utils/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpCorrectPage extends StatelessWidget {
  const SignUpCorrectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/tick_icon.svg',
                      width: 80,
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'page.sign_up_correct.title'.tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'page.sign_up_correct.body'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
              PrimaryButton(
                padding: EdgeInsets.zero,
                text: 'page.sign_up_correct.button'.tr(),
                onPressed: () => UIUtil.resetToRootPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
