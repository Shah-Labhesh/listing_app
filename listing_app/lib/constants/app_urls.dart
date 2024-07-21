class AppUrls{
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static const String posts = '$baseUrl/posts';
  static const String photos = '$baseUrl/photos';
  static const String albums = '$baseUrl/albums';
  static const String todos = '$baseUrl/todos';
  static const String comments = '$baseUrl/comments';
  static String addComments({required int postId}) => '$posts/$postId/comments';

  static const String users = '$baseUrl/users';
  // static String userPosts({required int userId}) => '$users/$userId/posts';
  // static String userAlbums({required int userId}) => '$users/$userId/albums';
  // static String userTodos({required int userId}) => '$users/$userId/todos';
  // static String albumPhotos({required int albumId}) => '$baseUrl/albums/$albumId/photos';
}