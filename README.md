# Glyder Lints
This package defines all custom lint rules for flutter applications and is built on top of the [custom_lint](https://pub.dev/packages/custom_lint) package.

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

### Example analysis_options.yaml file
```
include: package:flutter_lints/flutter.yaml

# Flutter linter.
linter:
  rules:

# Added custom_lint as additional package.
analyzer:
  plugins:
    - custom_lint

# Plugin customization.
custom_lint:
  # Uncomment this to enable specific lint rules at will.
  # By default all lint rules are enabled.
  # enable_all_lint_rules: false
  rules:
    # Disable a single lint rule.
    - specify_type: false
    # Uncomment this to enable a specific rule. Only usefule if enable_all_lint_rules is false.
    # - other_rule: true
```

## Lint Rules
  * `specify_type` -> Explicitly specify type in variable declarations.
  * `write_docs_pls` -> Provide documentation comments for public classes and methods.
  * `static_fields_go_first` -> Static fields should go first in class definition.
