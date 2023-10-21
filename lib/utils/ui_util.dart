import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:e_commerce/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UIUtil {
  static void showCircularSpinner(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showInfo(
    context, {
    required String body,
    required String title,
    required Function() onTap,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'close'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  static void showError(context, {String? body, required String title}) {
    showInfo(
      context,
      body: body ?? 'errors.general'.tr(),
      title: title,
      onTap: () => Navigator.of(context).pop(),
    );
  }

  static void resetToRootPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainApp()),
      (Route<dynamic> route) => false,
    );
  }

  static void showSuccessDialog(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String body,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      anchorPoint: Offset.zero,
      builder: (context) => Dialog(
        child: Container(
          width: 250,
          height: 310,
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 45, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                body,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                text: 'Continue shopping',
                onPressed: onTap,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
