# NewsFeed
News Feed is a Flutter application that provides a comprehensive news reading experience. The app displays a list of news articles, and users can tap on any article to view its details. Additionally, there is a feature to view the full article in a browser.
# Features
* List Screen: Shows a list of news articles.
* Detail Screen: Provides detailed information about a selected news article.
* View Full Article: Opens the full news article in a browser.
* Offline Caching: Stores data locally for offline access using Floor.
* Pull to Refresh: Allows users to refresh the news list.
* Dark Mode Support: Provides a dark theme for better readability in low-light environments.
* Dynamic Theme: Supports dynamic theming based on user preferences.
* Animations: Includes smooth animations for transitions and interactions.
* Reusable Widgets: Utilizes reusable widgets to ensure code efficiency.
* Dynamic UI: Adapts to multiple screen sizes for a responsive design.
* MVVM Design Pattern: Organizes code using the Model-View-ViewModel architecture.
* Shared Preferences: Saves user preferences locally.
* News API Integration: Fetches news articles from a news API.
* URL Launcher: Opens external links in a browser.
* Picsum API: Uses the Picsum API for random images when news images are not available.

# Technologies Used
* Floor: A persistence library for local database storage.
* Dio: A powerful HTTP client for making API requests.
* Provider: A state management solution for managing app state.
* Shared Preferences: For storing simple data locally.
* Flutter Animation: For smooth and engaging animations.

# Setup
### Environment Configuration
* The app uses Dart defines to store API keys. To configure the API key:
* Add Dart Define: When building or running the app, you need to pass the API key using Dart defines. Here is an example of how to do this:
flutter run --dart-define=API_KEY=your_api_key_here
* Replace your_api_key_here with your actual API key.

# Screenshots

<img width="274" alt="List screen light mode" src="https://github.com/user-attachments/assets/8853a461-b7f2-43ef-a5cc-29d1158597fe">
<img width="274" alt="Detail screen light mode" src="https://github.com/user-attachments/assets/3879f2ed-2eda-40c8-a63d-af562791c370">
<img width="274" alt="List screen dark mode" src="https://github.com/user-attachments/assets/74f93ff9-25f6-4b32-80c9-7e7f30e0ba5e">
<img width="274" alt="Detail screen dark mode" src="https://github.com/user-attachments/assets/a0fa607f-d0e4-45fa-98e9-fcc48184b722">

