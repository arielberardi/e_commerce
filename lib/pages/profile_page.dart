import 'package:e_commerce/components/menu/menu.dart';
import 'package:e_commerce/models/menu_item_model.dart';
import 'package:e_commerce/pages/addresses_page.dart';
import 'package:e_commerce/pages/favorite_page.dart';
import 'package:e_commerce/pages/work_in_progress_page.dart';
import 'package:e_commerce/services/auth_service.dart';
import 'package:e_commerce/utils/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final user = AuthService.getCurrentUser()!;

  void signOut(BuildContext context) async {
    UIUtil.showCircularSpinner(context);

    AuthService.signOut().then((_) {
      UIUtil.resetToRootPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);

      UIUtil.showError(
        context,
        body: AuthService.parseError(error),
        title: 'error.title'.tr(),
      );
    });
  }

  void goToInWorkPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WorkInProgressPage(),
      ),
    );
  }

  void goToFavorite(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const FavoritePage();
      }),
    );
  }

  void goToAddresses(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const AddressesPage();
      }),
    );
  }

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
                  Text(
                    'page.profile.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://placehold.co/400x400/png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(user.displayName!),
                  subtitle: Text(user.email!),
                ),
              ),
              const SizedBox(height: 25.0),
              Menu(
                items: [
                  MenuItem(
                    'page.profile.personal_details'.tr(),
                    Icons.person,
                    () => goToInWorkPage(context),
                  ),
                  MenuItem(
                    'page.profile.my_orders'.tr(),
                    Icons.shopping_cart,
                    () => goToInWorkPage(context),
                  ),
                  MenuItem(
                    'page.profile.my_favorites'.tr(),
                    Icons.favorite,
                    () => goToFavorite(context),
                  ),
                  MenuItem(
                    'page.profile.shipping_address'.tr(),
                    Icons.local_shipping,
                    () => goToAddresses(context),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              Menu(
                items: [
                  MenuItem(
                    'page.profile.faq'.tr(),
                    Icons.question_mark,
                    () => goToInWorkPage(context),
                  ),
                  MenuItem(
                    'page.profile.privacy_policy'.tr(),
                    Icons.privacy_tip,
                    () => goToInWorkPage(context),
                  ),
                  MenuItem(
                    'sign_out'.tr(),
                    Icons.logout,
                    () => signOut(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
