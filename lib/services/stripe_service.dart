import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static final _authToken = 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}';
  static const _stripeVersion = '2023-08-16';

  static void init() {
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC_KEY']!;
    Stripe.merchantIdentifier = dotenv.env['STRIPE_MERCHANT_ID']!;
  }

  static Future<String> getCustomerId() async {
    final response = await http.post(
      Uri.https('api.stripe.com', 'v1/customers'),
      headers: {'Authorization': _authToken},
    );

    return jsonDecode(response.body)['id'];
  }

  static Future<String> getCustomerEphemeralKey(String customerId) async {
    final response = await http.post(
      Uri.https('api.stripe.com', 'v1/ephemeral_keys'),
      headers: {
        'Stripe-Version': _stripeVersion,
        'Authorization': _authToken,
      },
      body: {'customer': customerId},
    );

    return jsonDecode(response.body)['secret'];
  }

  static Future<String> getPaymentClientSecret({
    required String amount,
    required String currency,
  }) async {
    final response = await http.post(
      Uri.https('api.stripe.com', 'v1/payment_intents'),
      headers: {'Authorization': _authToken},
      body: {
        'amount': amount,
        'currency': currency,
      },
    );

    return jsonDecode(response.body)['client_secret'];
  }

  static Future<void> createPaymentSheet({
    required BillingDetails billingDetails,
    required String customerId,
    required String amount,
    required String currency,
  }) async {
    // // TODO: Customer ID must come from currentUser
    final String customerIdTemp = await StripeService.getCustomerId();

    final String ephemeralKey = await getCustomerEphemeralKey(
      customerIdTemp,
    );

    final String clientSecret = await getPaymentClientSecret(
      amount: amount,
      currency: currency,
    );

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: false,
        merchantDisplayName: 'Flutter Stripe Store Demo',
        paymentIntentClientSecret: clientSecret,
        customerEphemeralKeySecret: ephemeralKey,
        customerId: customerIdTemp,
        applePay: PaymentSheetApplePay(
          merchantCountryCode: dotenv.env['STRIPE_MERCHANT_COUNTRY']!,
        ),
        billingDetails: billingDetails,
      ),
    );

    await Stripe.instance.presentPaymentSheet();
  }
}
