class ApiEndpoints {
  ApiEndpoints._();
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://192.168.1.66:5000/api/";

  //auth routes
  static const String login = "user/login";
  static const String register = "user/create";
  static const String sentOtp = 'user/forgot_password';
  static const String verifyOtp = 'user/verify_otp';
  static const String getMe = "user/get_single_user";
  static const String currentUser = "user/getMe";
  static const String verifyUser = "user/verify";
  static const int limitPage = 2;
  static const String imageUrl = 'http://192.168.1.66:5000/products/';

  //product routes
  static const String getAllProducts = 'product/get_all_products';
  static const String paginatonProducts = "product/pagination";

  //cart routes
  static const String addToCart = 'cart/addToCart';
  static const String getCart = 'cart/getCartByUserID';
  static const String clearCart = "/update/";
  static const String changeStatus = "cart/status";

  // place order routes
  static const String createOrder = 'order/create';
  static const String getOrder = 'order/get';
}
