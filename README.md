# Listing and Detail Showcase Application

## Description

This is a Flutter application that implements a listing and detail showcase using the following APIs from [JSONPlaceholder](https://jsonplaceholder.typicode.com/):

- [Posts](https://jsonplaceholder.typicode.com/posts)
- [Comments](https://jsonplaceholder.typicode.com/posts/{post_id}/comments)
- [Users](https://jsonplaceholder.typicode.com/users)
- [User's Posts](https://jsonplaceholder.typicode.com/users/{user_id}/posts)
- [Todos](https://jsonplaceholder.typicode.com/users/{user_id}/todos)
- [Albums](https://jsonplaceholder.typicode.com/users/{user_id}/albums)
- [Photos](https://jsonplaceholder.typicode.com/albums/{album_id}/photos)

The app includes features such as listing posts, displaying post details with comments, adding new comments, and managing todos with CRUD operations. The app also has light and dark theme options.

## Features

- **Posts Screen**: Displays a list of all posts.
- **Users Screen**: Displays a list of users with expandable cards. Clicking on a user navigates to their details.
- **User Details**:
  - **Posts**: Displays user's posts with the ability to add comments.
  - **Todos**: Displays user's todos with CRUD operations.
  - **Albums**: Displays user's albums with the ability to view photos.
- **Persistent Data**: The data is cached or stored to persist across sessions.
- **Light and Dark Themes**: The app supports both light and dark themes.

## Screenshots

### Splash

![Splash Screen](assets/images/splash.png)

### Light Theme

![Light Theme - Posts Screen](assets/images/light_post.png)
![Light Theme - Users Screen](assets/images/light_user.png)

### Dark Theme

![Dark Theme - Posts Screen](assets/images/dark_post.png)
![Dark Theme - Users Screen](assets/images/dark_user.png)

## How to Run

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Shah-Labhesh/listing_app.git
   cd listing_app/listing_app/

2. **Install dependencies**:
    flutter pub get

3. **Run the Projet**:
    flutter run