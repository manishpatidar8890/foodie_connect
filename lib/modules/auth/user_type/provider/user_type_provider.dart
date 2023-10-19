import 'package:foodie_connect/routes/routes_export.dart';

class UserTypeProvider extends ChangeNotifier {
  ValueNotifier<bool> isInfluencer = ValueNotifier(false);
  ValueNotifier<bool> isBusinessOwner = ValueNotifier(false);

  setInfluencerValue(bool value) {
    isInfluencer.value = value;
    notifyListeners();
  }

  setBusinessOwnerValue(bool value) {
    isBusinessOwner.value = value;
    notifyListeners();
  }
}
