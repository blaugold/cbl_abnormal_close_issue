To replicate the abnormal connection close issue, follow these steps:

1. Install the Dart or Flutter SDK
2. Clone this repository
3. Run `dart pub get` in the root of the repository
4. Run `dart run main.dart` in the root of the repository

The abnormal connection closures don't happen on every run. Repeat step 4 until you see the
following log message in the program output:

```
[...] Transient error (WebSocket error 1006, "connection closed abnormally"); attempt #2 in 2 sec...
```
