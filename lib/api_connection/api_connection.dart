class API{
  static const hostAdmin = "http://192.168.1.64/restoweb/userAd/";
  static const hostConnect="http://192.168.1.64/restoweb/android";


//  signUp user
  static const validateEmail = "$hostConnect/validate_email.php";
  static const signUp = "$hostConnect/newAcount.php";
  static const login = "$hostConnect/login.php";
  static const getCategories = "$hostConnect/get_categories.php";
  static const getUser = "$hostConnect/profile.php";
  static const getProduct = "$hostConnect/getProduct.php";
  static const getProductByCategory = "$hostConnect/getProductByCategory.php";
  static const editProfile = "$hostConnect/editProfile.php";
  // getTbales
  static const getTables = "$hostConnect/getTable.php";
  // get location
  static const getLocations = "$hostConnect/getLocation.php";
  // make quick Order
  static const makeQuickOrder = "$hostConnect/makeQuickOrder.php";
}