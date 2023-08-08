abstract class INavigationService {
  Future<void> navigateToPage({String path, Object data});
  Future<void> navigateToPageRemoveUntil({String path, Object data});
}
