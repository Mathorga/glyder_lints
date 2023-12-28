import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AmendVarKeyword extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "amend_var_keyword",
    problemMessage: "Never use the var keyword",
    errorSeverity: ErrorSeverity.WARNING,
  );

  AmendVarKeyword() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclarationStatement((VariableDeclarationStatement node) {
      if (node.beginToken.toString() == "var") {
        reporter.reportErrorForToken(_code, node.beginToken);
      }
    });
  }
}