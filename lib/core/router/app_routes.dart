abstract final class AppRoutes {
  static const home = '/';
  static const recognition = '/recognition';
  static const recognitionResult = '/recognition/result';
  static const catalog = '/catalog';
  static const plant = '/catalog/:plantId';
  static const calendar = '/calendar';
  static const history = '/history';
  static const settings = '/settings';
  static const dataPolicy = '/settings/data-policy';

  static String plantPath(String id) => '/catalog/$id';
}
