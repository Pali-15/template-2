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
| Routing             | `go_router`                      |
| State Management    | `bloc`, `cubit`                  |
| Dependency Injection| `get_it/Providers`               |
| Localization        | `l10n`                           |

---

## 📁 Folder Structure

```
lib/
├── assets_gen/          # Generated assets
├── app/                 # Application related code: screens, screen related Blocs and other buisness logic
├── core/                # Global, not app related files
├── core/common_widgets/ # Commonly used widget
├── core/design/         # Colors, Spacing, Radius, Theme, Text Styles
├── core/extensions/     # Commonly used extensions
├── core/firebase/       # Firebase related files
├── core/l10n/           # Localization
├── core/router/         # All files related to routing
├── core/di/             # Abstract di class, and bootstrapper file which will create the global dependencies
├── core/di_modules      # All di modules file
```

---

## 🧩 Dependency Injection
- For global dependencies use get_it to register
1. Create a `myrepository_di_module` file inside the `core/di_modules` folder. The class should extend from DiModule
```Dart
class LocaleDiModule extends DiModule {
  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingleton<LocaleCubit>(LocaleCubit(Locales.en.toLocale));
  }
}
```
2. Add the di module to the `bootstrap` inside `core/di/bootstrap.dart`
```Dart
List<DiModule> modules = [
      ThemeDiModule(),
      LocaleDiModule(),
      RouterDiModule(),
    ];
```
It will register the dependencies in the given order, so if a di_module is depending on an other di_module make sure that it will be registered after it.

- The blocs for the screens are registered during the routing. 

---

## 🧭 Routing
- This Project uses Stateful routing with `go_router`
- Create a new route:
1. Add the new route to the `routes.dart`. If it is a top level route use `/` prefix, if not then you should't use that prefix
```Dart
  static const page1 = "/page1";
  static const page1Nested = "page1nested";
```
2. Add a new function to the `AppRoutes`
```dart
static AppRoute page1Route() => AppRoute._(AppRoutes.page1);
```
3. Add a builder function to the `RoutesBuilder` class
```Dart
  Widget page1Builder(BuildContext context, GoRouterState state) {
    // If needed read params from routing here, and wrap the child with BlocProviders
    return RouteWrapper(child: Page1());
  }
```
- Here we can read the object passed to the routes with using `state.input` which is equal to
```Dart
Map<String, dynamic> get input {
    return jsonDecode(uri.queryParameters[AppRoute.QUERY_INPUT_KEY]!);
  }
```
- To have a nice developer experience, for every screen input create a model with freezed.
```Dart

  Widget page1NestedBuilder(BuildContext context, GoRouterState state) {
    final Page1NestedInput input = Page1NestedInput.fromJson(state.input);
    return RouteWrapper(child: Page1Nested(input: input));
  }
```
4. In the `AppRouter` add the new route, either create a new branch or add a new barnch:
In this example we define a top level route `page1` and a subroute `page1Nested` which uses a bloc
```dart
StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.page1,
                  name: AppRoutes.page1,
                  builder: _builder.page1Builder,
                  routes: [
                    routeWithBloc(
                      path: AppRoutes.page1Nested,
                      providers: [
                        BlocProvider<Page1Bloc>(
                          create: (_) => Page1Bloc()..add(Page1BlocLoad()),
                        ),
                      ],
                      builder: _builder.page1NestedBuilder,
                    ),
                  ],
                ),
              ],
            ),
```

- Always use the extension method for routing so it will be compatible with `AppRoute` class. Find it here: `context_router_extensions.dart`
```Dart
onPressed: () {
            context.navigate(AppRoute.page1NestedRoute(input: Page1NestedInput()));
          },
```
### Dependency injection into the UI
- If the page do not require any dependency then just add the builder function.
- If the page do require any bloc then use the `routeWithBloc` function.
- Use `routeWithInheritedBloc` if you want to provide the bloc to all of the subroutes

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
## 👨🏻‍💻 Create a new feature with bloc
1. Create a repository which will handle all of the error and return a `Result` object
```Dart
class Page1Repository {
  Result<List<String>> getData([bool throwError = false]) {
    if (throwError) {
      return ResultError<List<String>>('An error occurred');
    }
    return ResultData(List.generate(3, (index) => 'Item $index'));
  }
}
```
2. Define the bloc which will expect a repository, and handle the responses:
```Dart
class Page1Bloc extends Bloc<Page1BlocEvent, Page1BlocState> {
  final Page1Repository _repository;
  Page1Bloc(this._repository) : super(Page1BlocState.initial()) {
    on<Page1BlocLoad>((event, emit) {
      final data = _repository.getData();
      if (data is ResultData<List<String>>) {
        emit(Page1BlocState.loaded(data.value));
      } else if (data is ResultError<List<String>>) {
        emit(Page1BlocState.error(data.message));
      }
    });
  }
}
```
4. Register the Repository with a di_module
```Dart
// page1nested_di_module.dart
class Page1NestedDiModule extends DiModule {
  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingleton<Page1Repository>(Page1Repository());
  }
}

// bootstrap.dart
List<DiModule> modules = [
  ThemeDiModule(),
  LocaleDiModule(),
  Page1NestedDiModule(),
  RouterDiModule(),
];
```
5. Since the bloc is using the repository we should inject it inside the router:
```Dart
// app_router.dart
class AppRouter {
  // Dependencies
  late final RoutesBuilder _builder;
  late final Page1Repository _page1Repository;
  // Rest
   AppRouter({required builder, required Page1Repository page1Repository})
    : _builder = builder,
      _page1Repository = page1Repository 
}
 // router_di_module.dart
 class RouterDiModule extends DiModule {
  @override
  void initializeModule(GetIt getIt) {
    getIt
      ..registerSingleton(RoutesBuilder())
      ..registerSingleton(
        AppRouter(
          builder: getIt<RoutesBuilder>(),
          page1Repository: getIt<Page1Repository>(),
        ),
      );
  }
}
```
6. Update the `buildMockRouter` function inside the `test/test_extension.dart`:
```Dart
AppRouter buildMockRouter({Page1Repository? page1Repository}) {
  return AppRouter(
    builder: (context, state) => Container(),
    page1Repository: page1Repository ?? MockPage1Repository(),
  );
}
```
7. Now just write the screen, and add the route

This way in the tests you just have the mock the repository, and the bloc will work, and you can test the UI with the original bloc behaviour.
---

## 🧪 Testing

### Mocking
- This project using `mocktail` for testing
- Always use the `testAppWrapper` for testing.
- See the example widget test, with the custom enviroment in the `example_widget_test.dart`

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
- Always use `ScreenUtil`
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
