# Charades!

An open source, free to play and ad free Charades game built in Flutter.

Feel free to contribute or report issues here on GitHub.


# Development

To run the app in debug mode:

    flutter run


## Code organization

Code is organized in a loose and shallow feature-first fashion.
In `lib/`, you'll therefore find directories such as `audio`,
`main_menu` or `settings`. Nothing fancy, but usable.

```text
lib
├── app_lifecycle
├── audio
├── game_internals
├── level_selection
├── main_menu
├── play_session
├── player_progress
├── settings
├── style
├── win_game
│
├── main.dart
└── router.dart
```

The state management approach is intentionally low-level. That way, it's easy to
take this project and run with it, without having to learn new paradigms, or having
to remember to run `flutter pub run build_runner watch`. You are,
of course, encouraged to use whatever paradigm, helper package or code generation
scheme that you prefer.


## Building for production

To build the app for iOS (and open Xcode when finished):

```shell
flutter build ipa && open build/ios/archive/Runner.xcarchive
```

To build the app for Android (and open the folder with the bundle when finished):

```shell
flutter build appbundle && open build/app/outputs/bundle/release
```


## Icons

To generate the icon files, visit [IconKitchen](https://icon.kitchen/i/H4sIAAAAAAAAAzWPPQ7CMAyF72LWDBQJCXoBViS6IQan%2BWlEUpckBaGqd8eJ6BI5n%2F2enxd4o591gnYBhfHZDTpoaA36pAVI230n%2FoKNqJweMwgwG3MBra7gikq50RaPTBO0JwHR2SHXSlLOFGrptSlsLcaXzZFFPXmKDVvujmiMadi0okNB0uwZMsLRet573lf9bcCaIr1mF3tuCMglu%2FqH56FAavbltDtrVSSneMhR4vejJTzWH%2Bu%2B1CH9AAAA) and upload assets/icons/icon_blank.png.
