import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Discourages the use of multiple variable declarations.
class AmendMultipleDeclarations extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "amend_multiple_declarations",
    problemMessage: "Avoid declaring multiple variables at once",
    errorSeverity: ErrorSeverity.INFO,
  );

  AmendMultipleDeclarations() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclarationStatement((VariableDeclarationStatement node) {
      if (node.variables.variables.length > 1) {
        reporter.reportErrorForNode(_code, node);
      }
    });
  }
}