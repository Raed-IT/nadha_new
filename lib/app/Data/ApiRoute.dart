class ApiRoute {
  // static String host = "http://192.168.1.105:8000/api/v1";
  static String redirectDomin = "https://redirectapp.tasawoqi.net";

  // static String domin = "https://tasawoqi.net";
  static String domin = "http://192.168.1.103:8000";
  static String host = "$domin/api/v1";

  // static String host = "http://demo.tasawoqe.com/api/v1";
  static String settings = "$host/settings";
  static String login = "$host/login";
  static String loginBySocial = "$host/login-by-social";
  static String register = "$host/register";
  static String home = "$host/home";
  static String categories = "$host/categories";
  static String products = "$host/products";
  static String addresses = "$host/addresses";
  static String favorites = "$host/favorites";
  static String notifications = "$host/notifications";
  static String orders = "$host/orders";
  static String stores = "$host/stores";
  static String storeOrders = "$host/store-orders";
  static String MyStores = "$host/my_stores";
  static String users = "$host/users";
  static String search = "$host/search";
  static String logout = "$host/logout";
  static String sliders = "$host/sliders";
  static String transforms = "$host/transforms";
}
