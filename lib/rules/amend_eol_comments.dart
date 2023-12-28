import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AmendEOLComments extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "amend_eol_comments",
    problemMessage: "Place comments in their own line",
    errorSeverity: ErrorSeverity.INFO,
  );

  AmendEOLComments() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addComment((Comment node) {
      if (node.isEndOfLine) {
        reporter.reportErrorForNode(_code, node);
      }
    });
  }
}