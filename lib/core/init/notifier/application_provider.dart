import 'package:ecommerce/core/init/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../navigation/navigation_service.dart';

class ApplicationProvider {
  ApplicationProvider._init();
  static ApplicationProvider _instance;
  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance;
  }

  List<SingleChildWidget> singleItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    ),
    Provider.value(value: NavigationService.instance)
  ];
}
