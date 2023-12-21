import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Enforces the use of documentation comments for classes and methods declarations.
class WriteDocsPls extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "write_docs_pls",
    problemMessage: "Provide documentation comments for classes and methods",
  );

  WriteDocsPls() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((MethodDeclaration node) {
      final ExecutableElement? declaredMethod = node.declaredElement;

      if (declaredMethod == null) {
        return;
      }

      // Only report for public methods.
      if (!declaredMethod.hasOverride && declaredMethod.isPublic && node.documentationComment == null) {
        reporter.reportErrorForElement(code, declaredMethod);
      }
    });

    context.registry.addClassDeclaration((ClassDeclaration node) {
      final ClassElement? declaredMethod = node.declaredElement;

      if (declaredMethod == null) {
        return;
      }

      // Only report for public classes.
      if (declaredMethod.isPublic && node.documentationComment == null) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }
}