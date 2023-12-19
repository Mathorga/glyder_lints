import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AmendModelSuffix extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "amend_model_suffix",
    problemMessage: "Amend Model suffix in class names",
    correctionMessage: "Rename class",
  );

  static const String _modelSuffix = "Model";

  AmendModelSuffix() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((ClassDeclaration node) {
      final String className = node.name.lexeme;
      if (className.endsWith(_modelSuffix)) {
        reporter.reportErrorForToken(code, node.name);
      }
    });
  }
}