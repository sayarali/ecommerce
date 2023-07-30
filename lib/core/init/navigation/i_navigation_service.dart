abstract class INavigationService {
  Future<void> navigateToPage(String path, {Object object});
  Future<void> navigateToPageRemoveUntil(String path, Object object);
}