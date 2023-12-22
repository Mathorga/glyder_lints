import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Suggests that static fields go first in class declarations.
class StaticFieldsGoFirst extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "static_fields_go_first",
    problemMessage: "Static fields should go first in class definition",
    errorSeverity: ErrorSeverity.INFO,
  );

  const StaticFieldsGoFirst() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((ClassDeclaration node) {
      final ClassElement? declaredClass = node.declaredElement;

      if (declaredClass == null) {
        return;
      }

      // Defines whether the last scanned field is static or not.
      bool lastFieldStatic = true;

      for (FieldElement field in declaredClass.fields) {
        if (field.isStatic) {
          if (!lastFieldStatic) {
            reporter.reportErrorForElement(code, field);
          } else {
            lastFieldStatic = true;
          }
        } else {
          lastFieldStatic = false;
        }
      }
    });
  }
}
