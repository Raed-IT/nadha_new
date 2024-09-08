class ApiRouts {
  // static const DOMAIN = '10.8.0.254:8000';

  // static const DOMAIN = 'store.mada-company.com';
  //
  static const DOMAIN = '3alnadha.com';

  // static const DOMAIN = '192.168.1.102:8000';
  // static const DOMAIN = 'tim-company-sy.com';
  static const HOST = 'https://$DOMAIN/api/v1';

  // static const HOST = 'http://$DOMAIN/api/v1';

  // static const HOST = 'http://$DOMAIN/api/v1';
  static const products = "$HOST/products";
  static const cities = "$HOST/cities";
  static const vendors = "$HOST/vendors";
  static const bills = "$HOST/bills";
  static const login = "$HOST/login";
  static const register = "$HOST/register";
  static const categories = "$HOST/categories";
  static const cart = "$HOST/carts";
  static const profile = "$HOST/profile";
  static const orders = "$HOST/orders";
  static const points = "$HOST/points";
  static const balances = "$HOST/balances";
  static const addresses = "$HOST/addresses";
  static const ordersDriver = "$HOST/calls";
  static const notifications = "$HOST/notifications";
  static const loginWithGoogle = "$HOST/register-by-google";
  static const offers = "$HOST/offers";
  static const invoices = "$HOST/invoices";
  static const stores= "$HOST/stores";
}
