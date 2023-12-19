# Glyder Lints
## Install
Add the following in the `dev_dependencies` section in your `pubspec.yaml` after `flutter_lints` if present:</br>
```
# Linting.
custom_lint: 0.5.7
glyder_lints:
    git:
        url: https://github.com/Mathorga/glyder_lints.git
        ref: main
```

Add the following at the bottom of the `analysis_options.yaml` if present (create it otherwise):</br>
```
analyzer:
  plugins:
    - custom_lint
```

## Lints List
  * `amend_model_suffix` -> All model classes should end with the "Model" suffix.
  * 
  