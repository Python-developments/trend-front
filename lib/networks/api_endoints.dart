class ApiEndPoints {
  static const String baseUrl = "";
  static const String login = "/auth/login/";
  static const String refreshToken = "/auth/login/refresh/";
  static const String blockList = "/profile/blocked/";
  static const String allUsers = "/auth/list-users/";
  static const String register = "/auth/register/";
  static const String changePassword = "/auth/change-password/";
  static const String resetPassword = "/auth/reset-password/";
  static const String confirmResetPassword = "/auth/reset-password-confirm/";
  ////////////////////////////////////////////////////////////////////
  static const String postsPrefix = "/posts/";
  static const String allPosts = "/posts/all-posts/";
  static const String allPostsWithoutPagination =
      "/posts/all-posts-nopagination/";
  static const String createPost = "${postsPrefix}create/";
  static String commentPost(int id) => "${postsPrefix}$id/comments/";
  static String getPost(int id) => "${postsPrefix}$id/";
  static String getUserPosts(int id) => "${postsPrefix}$id/posts/";
  static String getPostComments(int id) => "${postsPrefix}$id/comments/";
  static String getPostComment(int id, int commentId) =>
      "${postsPrefix}$id/comments/$commentId/";
  static String likePost(int id) => "${postsPrefix}$id/like/";
  static String likeComment(int id) => "${postsPrefix}comments/$id/like/";
  static String addCommentOnComment(int id) =>
      "${postsPrefix}comments/$id/reply/";
  ////////////////////////////////////////////////////////////////////
  static const String profilePrefix = "/profile";
  static String getProfile(int id) => "$profilePrefix/$id/";
  static String followUser(int id) => "$profilePrefix/follow/$id/";
  static String unFollowUser(int id) => "$profilePrefix/unfollow/$id/";
  static String getFollowings(int id) => "$profilePrefix/$id/following/";
  static String getFollowers(int id) => "$profilePrefix/$id/followers/";
  static String blockUser(int id) => "$profilePrefix/$id/block/";
  static String unblockUser(int id) => "$profilePrefix/$id/unblock/";
  ////////////////////////////////////////////////////////////////////
  static const String explorePrefix = "explore";
  static const String trendindPosts = "$explorePrefix/trending-posts";
  static const String hasTags = "$explorePrefix/hashtags";
  static const String hastagDetails = "$explorePrefix/hashtag-detail";
  static const String configuration = "$explorePrefix/configuration";
  static const String location = "$explorePrefix/location";
}
