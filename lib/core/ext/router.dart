import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  void clearStackNavigate(String location) {
    while (canPop()) {
      pop();
    }
  }
}
