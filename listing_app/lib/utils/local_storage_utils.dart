import 'package:listing_app/app/albums/data/model/album.dart';
import 'package:listing_app/app/albums/data/model/photos.dart';
import 'package:listing_app/app/posts/data/model/comment.dart';
import 'package:listing_app/app/posts/data/model/post.dart';
import 'package:listing_app/app/todos/data/model/todo.dart';
import 'package:listing_app/app/users/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtils {

  // delete all data from local storage
  static void clearAllData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }


  static void saveThemeMode(bool isDark) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isDark', isDark);
  }

  static Future<bool> getThemeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('isDark') ?? false;
  }

  static void saveUserId(int userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('userId', userId);
  }

  static Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId') ?? 1;
  }

  // save list of posts to local storage
  static Future<void> savePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('posts', posts.map((e) => e.toJson()).toList());
  }

  static Future<List<Post>> getPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsString = prefs.getStringList('posts');

    if (postsString != null) {
      return postsString.map((e) => Post.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // save list of comments to local storage
  static Future<void> saveComments(List<Comment> comments) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('comments', comments.map((e) => e.toJson()).toList());
  }

  static Future<void> saveAlbums(List<Album> albums) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('albums', albums.map((e) => e.toJson()).toList());
  }

  static Future<void> saveTodos(List<Todo> todos) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('todos', todos.map((e) => e.toJson()).toList());
  }

  static Future<void> saveUsers(List<User> users) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('users', users.map((e) => e.toJson()).toList());
  }

  // photos
  static Future<void> savePhotos(List<Photos> photos) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('photos', photos.map((e) => e.toJson()).toList());
  }

  static Future<List<Comment>> getComments() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> comments = pref.getStringList('comments') ?? [];
    return comments.map((e) => Comment.fromJson(e)).toList();
  }

  static Future<List<Album>> getAlbums() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> albums = pref.getStringList('albums') ?? [];
    return albums.map((e) => Album.fromJson(e)).toList();
  }

  static Future<List<Todo>> getTodos() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> todos = pref.getStringList('todos') ?? [];
    return todos.map((e) => Todo.fromJson(e)).toList();
  }

  static Future<List<User>> getUsers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> users = pref.getStringList('users') ?? [];
    return users.map((e) => User.fromJson(e)).toList();
  }

  static Future<List<Photos>> getPhotos() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> photos = pref.getStringList('photos') ?? [];
    return photos.map((e) => Photos.fromJson(e)).toList();
  }
}
