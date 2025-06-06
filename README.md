# Flutter Template Project
Use this template repository to kickstart new Flutter projects.

---

# 🛠 Initial Steps

To clone this template into your own new project and set up the bundle ID, app name, and import paths:

### 1. Install rename tool

```bash
flutter pub global activate rename
```

### 2. Set the new bundle ID

```bash
flutter pub global run rename setBundleId --value new-bundle-id
```

### 3. Set the new App name

```bash
flutter pub global run rename setAppName --value "new-app-name"
```

### 3. Rename in `pubspec.yaml`

Change:

```yaml
name: template
```

To:

```yaml
name: new-app-name
```

### 4. Replace Dart imports
 MacOS script:
```bash
find . -type f -name "*.dart" -exec sed -i '' "s/package:template/package:new-app-name/g" {} +
```

### 5. Android files
1. Create a new folder with the new bundle id for the MainActivity.kt
```bash
mkdir -p android/app/src/main/kotlin/com/bundle/id
mv android/app/src/main/kotlin/com/example/template/MainActivity.kt android/app/src/main/kotlin/com/bundle/id/
rm -r android/app/src/main/kotlin/com/example/template
```
2. In the build.gradle rewrite the namespace for the new bundle id
3. In the MainAcivity.kt update the package name for the new bundle id

---

## 🚀 Features

- Stateful nested routing with `go_router`
- Dependency injection with `get_it`
- Dark/Light theme support
- Localization
- Consistent UI system with design tokens
- Firebase basic implementation
- Mason brick generator for BLoCs
- Asset generation

---

## 🛠 Prerequisites

- Developed using [Flutter 3.29.3](https://docs.flutter.dev/get-started/install)
- Code generation via `build_runner`:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🧱 Architecture Overview

This project follows a clean, modular structure:

| Layer               | Technology                       |
|---------------------|----------------------------------|
| Routing             | `go_router` + `go_router_builder`|
| State Management    | `bloc`, `cubit`                  |
| Dependency Injection| `RepositoryProvider/BlocProvider`|
| Localization        | `l10n`                           |

---

## 📁 Folder Structure

```
lib/
├── assets_gen/     # Generated assets
├── common_widgets/ # Commonly used widget
├── dependencies/   # For global dependencies
├── design/         # Colors, Spacing, Radius, Theme, Text Styles
├── extensions/     # Commonly used extensions
├── firebase/       # Firebase related files
├── l10n/           # Localization
├── router/         # All files related to routing
├── screen/         # Screens and the corresponding blocs and repositories
└── main.dart
```

---

## 🧩 Dependency Injection

- For global dependency register it inside `dependencies/global_dependencies.dart`
- If you would like to access it from the context, then add a new field inside the `GlobalDependenciesExtension`

- The screens should NOT create their own dependencies
- If a screen needs a dependency, then it is the responsibility of the corresponding GoRouteData class in the `app_routes.dart`

```dart
class Page1NestedRoute extends GoRouteData {
  const Page1NestedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider(
        create: (context) => Page1Bloc()..add(Page1BlocLoad()),
        child: const Page1Nested(),
      );
}
```

---

## 🧭 Routing
- This Project uses Stateful routing with TypedRoutes
- Create a new route:
1. Create a new class which extends from the GoRouteData 
```dart
class Page1Route extends GoRouteData {
  const Page1Route();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Page1();
}
```
2. If that is a top level route then, before creating the class define it to the router builder:
```dart
@TypedGoRoute<Page2Route>(
  path: '/page2',
)
```
3. If it is a sub route, living inside a top level route, then define it like this:
```dart
@TypedGoRoute<Page1Route>(
  path: '/page1',
  routes: [
    TypedGoRoute<Page1NestedRoute>(path: 'page1Nested'),
  ],
)
```

2. After this is done regenerate it with `build_runner`

---

## 🌍 Localization

Localization is fully integrated using Flutter's `gen-l10n` tool.

To add or update localizations:

1. Edit ARB files in `lib/l10n/`  
   e.g. `app_en.arb`, `app_hu.arb`
2. Run `flutter gen-l10n`
3. Update `preferred-supported-locales` in `l10n.yaml` if needed

The app uses a custom `LocaleCubit` to manage language changes at runtime. The selected locale is applied to `MaterialApp.router`.

To change the language programmatically:
```Dart
context.read<LocaleCubit>().changeLocale(Locales.en)
```

---

## ⚙️ Asset generation

Every asset should be generated for usage
1. Place the asset inside the assets folder
2. Generate it with `build_runner` -- This will generate it inside the assets_gen folder
3. Usage
```Dart
Assets.images.avatarPlaceholder.svg(),
```

---

## 🧪 Testing

### Mocking
- Use generated mocks by `mockito`
- In the `test/mocks` folder find the corresponding file or a create a new one
- Define the new mock and generate it by the `build_runner`:
```dart
@GenerateNiceMocks([
  MockSpec<MockObject>(),
])
export 'file_name_mock.mocks.dart';
```

### Writing widget tests
- To mock bloc behavior use `mockitoWhenListen`:
```dart
mockitoWhenListen(mockPage1Bloc,
        initState: Page1BlocStateLoaded(['Item 1', 'Item 2', 'Item 3']))
```
- To pump the screen to be tested use the `pumpAppScreen` extension function:
```dart
    await tester.pumpAppScreen(
      BlocProvider<Page1Bloc>.value(
        value: mockPage1Bloc,
        child: const Page1Nested(),
      ),
    );
```
- In order to test the routing, create a mockRoute object and pass it:
```dart
    final router = MockGoRouter();

    await tester.pumpAppScreen(
      const Page1(),
      router: router,
    );
```
- Then verify the routing:
```dart
verify(router.go(const Page1NestedRoute().location)).called(1);
```
### What to test?
- Add tests for:
  - Widget rendering
  - Bloc behavior
  - Repository logic

---

## 🎨 UI Guidelines

- **Never hardcode colors or text styles or spacing**
- Use `AppColors` where you can easily define colors for multiple themes
- Use `AppTextSyles` for textStyles
- Use `AppButtons` with factory constructors
- Use `AppSpacing` for spacing and EdgeInsets
- Use `AppRadius` instead of hard coded values
- Wrap pages with `BasePage`
- Use `ErrorWidget` for displaying error messages
- The colors, textstyles are avaliable from the context:
```Dart
Text(
  "Page 1 Nested",
  style: context.textStyles.body,
),

Scaffold(
  backgroundColor: context.colors.background,
)
```
---

## 🔥 Firebase Integration

Firebase Cubits have a basic implementations in these files:
- `analytics_cubit.dart`
- `crashlytics_cubti.dart`

---

## 🧱 Mason Setup

Mason is pre-configured for generating BLoCs.

To use:

1. Open a terminal in the desired folder (e.g. `lib/screens/page_1`)
2. Run:

```bash
mason make bloc --bloc_name my_feature
```

This generates:

```
bloc/
├── bloc.dart      // class MyFeatureBloc
├── state.dart     // class MyFeatureState
└── event.dart     // class MyFeatureEvent
```

You can edit the Mason brick in `/bricks/bloc/` to customize the structure and code.

---

## 🧼 Best Practices

- Keep business logic inside blocs or services — **no async in UI**
- Never mutate state directly; always emit new states
- Use factory constructors and sealed classes where appropriate
- Use `freezed` for immutable models and state/event unions
- Write unit tests for every core logic
- Keep screens thin, focused on layout and interaction

---
