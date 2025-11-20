# Sandwich Shop App

Simple Flutter app to build and preview sandwich orders. It demonstrates state management for quantity, sandwich size, bread selection, and order notes. The app includes small UI components (StyledButton, OrderItemDisplay) and uses an OrderRepository to manage quantity limits.

## Features
- Select sandwich size: six-inch or footlong (Switch).
- Choose bread type: white, wheat, wholemeal (Dropdown).
- Add free-text notes (TextField, key: `notes_textfield`).
- Increase / decrease quantity with styled buttons (Add / Remove).
- Visual order preview with sandwich emoji count.

## Project layout (relevant files)
- lib/main.dart — main app & UI (OrderScreen, StyledButton, OrderItemDisplay, BreadType enum)
- lib/views/app_styles.dart — text styles used by the app (imported in main.dart)
- lib/repositories/order_repository.dart — quantity logic and limits (imported in main.dart)
- build/ — generated build artifacts (remove when troubleshooting)

## Prerequisites
- Flutter SDK (stable recommended)
- For Linux desktop: CMake, ninja, clang or system toolchain installed
- git (optional)

## Run locally
1. Open project root:
   ```bash
   cd '/home/Hiro/code/Dart/Dart Block1/sandwich_shop'
   ```
   Note: path contains a space — quote it or escape spaces.

2. Get packages:
   ```bash
   flutter pub get
   ```

3. Build & run:
   - Linux desktop:
     ```bash
     flutter run -d linux
     ```
   - Android / iOS / other targets: use the matching device flag or run from your IDE.

## Common troubleshooting

- CMake mismatch error (cache from different project):
  ```bash
  cd '/home/Hiro/code/Dart/Dart Block1/sandwich_shop'
  flutter clean
  rm -rf build
  flutter pub get
  flutter run -d linux
  ```
  Removing the `build` directory and rerunning forces CMake to regenerate caches for this project.

- "too many arguments" shell errors:
  - Caused by unquoted paths with spaces. Quote paths when using `cd`, `rm`, etc:
    ```bash
    cd '/home/Hiro/code/Dart/Dart Block1/sandwich_shop'
    rm -rf 'build/linux'
    ```

- Missing imports (URI not found):
  - Confirm package name in `pubspec.yaml` matches import prefixes.
  - Or use relative imports (e.g. `import 'views/app_styles.dart';`) if package imports fail.

- DropdownMenu compatibility:
  - `DropdownMenu`/`DropdownMenuEntry` require a recent Flutter SDK. If build fails, update Flutter or replace with `DropdownButton`.

## Notes on the code
- OrderRepository enforces max quantity; `OrderScreen` initializes it with `maxQuantity` passed from `main.dart` (example uses 5).
- `StyledButton` wraps `ElevatedButton` and enforces consistent style.
- `OrderItemDisplay` shows emoji repetition via `'🥪' * quantity` for a simple visual.
- TextField uses a listener to call setState so note preview updates.

## Testing
- Manual: run and interact with UI.
- Unit tests: add tests for `OrderRepository` logic in `test/` to verify increment/decrement and limit behavior.

## Contributing
- Fix issues, follow existing style, open PRs against this repo.
- When changing native/linux build files, run `flutter clean` and remove `build/` before running.

## License
MIT (add LICENSE file if desired)
