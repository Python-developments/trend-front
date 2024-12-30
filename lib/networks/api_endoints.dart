class ApiEndPoints {
  static const String baseUrl = "";
  static const String login = "/login/";
  static const String refreshToken = "/login/refresh/";
  static const String blockList = "/login/blacklist/";
  static const String allUsers = "/list-users/";
  static const String register = "/register/";
  static const String changePassword = "/change-password/";
  static const String resetPassword = "/reset-password/";
  static const String confirmResetPassword = "/reset-password-confirm/";
  ////////////////////////////////////////////////////////////////////
  static const String postsPrefix = "posts";
  static const String createPost = "$postsPrefix/create/";
  static String getPost(int id) => "$postsPrefix/$id/";
  static String getPostComments(int id) => "$postsPrefix/$id/comments/";
  static String getPostComment(int id, int commentId) =>
      "$postsPrefix/$id/comments/$commentId/";
  static String likePost(int id) => "$postsPrefix/$id/like/";
  static String likeComment(int id) => "$postsPrefix/comments/$id/like/";
  ////////////////////////////////////////////////////////////////////
  static const String profilePrefix = "profile";
  static String getProfile(int id) => "$profilePrefix/$id";
  static String followUser(int id) => "$profilePrefix/follow/$id/";
  static String unFollowUser(int id) => "$profilePrefix/unfollow/$id/";
  static String getFollowings(int id) => "$profilePrefix/$id/following/";
  ////////////////////////////////////////////////////////////////////
  static const String explorePrefix = "explore";
  static const String trendindPosts = "$explorePrefix/trending-posts";
  static const String hasTags = "$explorePrefix/hashtags";
  static const String hastagDetails = "$explorePrefix/hashtag-detail";
  static const String configuration = "$explorePrefix/configuration";
  static const String location = "$explorePrefix/location";
}
