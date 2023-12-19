import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferSingleImportQuotes extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "prefer_single_import_quotes",
    problemMessage: "Prefer single quotes in import directives.",
    correctionMessage: "Rename class",
  );

  PreferSingleImportQuotes() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addImportDirective((ImportDirective node) {
      if (node.beginToken.stringValue == "\"") {
        reporter.reportErrorForToken(code, node.beginToken);
      }
    });
  }
}
