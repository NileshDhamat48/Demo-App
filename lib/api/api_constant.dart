// const String apiBaseUrl = "http://randomuser.me/";
//
// const String apiBookingList = "api/";

class AppStrings {
  static String apiBookingList(int page, int result) => 'http://randomuser.me/api/?page=$page&results=$result';
  // static String apiBookingList(int page, int result) => 'https://randomuser.me/api/?page=1&results=10';
}
