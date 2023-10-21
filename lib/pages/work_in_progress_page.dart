import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:flutter/material.dart';

class WorkInProgressPage extends StatelessWidget {
  const WorkInProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryIconButton(
                    icon: Icons.arrow_back_rounded,
                    size: 20,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          'PAGE IN DEVELOPMENT',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
