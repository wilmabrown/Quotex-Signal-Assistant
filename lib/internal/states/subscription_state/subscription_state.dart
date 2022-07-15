import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_paywall.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:mobx/mobx.dart';
import 'package:quotex/internal/utils/infrastructure.dart';

part 'subscription_state.g.dart';

class SubscriptionState = _SubscriptionStateBase with _$SubscriptionState;

abstract class _SubscriptionStateBase with Store {
  @observable
  bool isSubscribed = false;

  @action
  Future<bool> subscribe() async {
    final paywalls = await Apphud.paywallsDidLoadCallback();
    for (ApphudPaywall paywall in paywalls.paywalls) {
      for (ApphudProduct product in paywall.products ?? []) {
        if (product.productId == 'premium_quotex_signals') {
          final result = await Apphud.purchase(product: product);
          if (result.subscription?.isActive ?? false) {
            isSubscribed = true;
            return true;
          }
        }
      }
    }
    return isSubscribed;
  }

  @action
  Future<bool> restore() async {
    final result = await Apphud.restorePurchases();
    if (result.subscriptions.map((e) => e.isActive).contains(true)) {
      isSubscribed = true;
    }
    return isSubscribed;
  }
}
