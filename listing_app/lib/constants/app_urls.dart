class AppUrls{
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static const String posts = '$baseUrl/posts';
  static String comments({required int postId}) => '$posts/$postId/comments';

  // user
  static const String users = '$baseUrl/users';
  static String userPosts({required int userId}) => '$users/$userId/posts';
  static String userAlbums({required int userId}) => '$users/$userId/albums';
  static String userTodos({required int userId}) => '$users/$userId/todos';
  static String albumPhotos({required int albumId}) => '$baseUrl/albums/$albumId/photos';
}