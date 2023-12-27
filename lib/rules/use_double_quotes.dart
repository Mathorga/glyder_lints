import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Suggests the use of double quotes for string literals.
/// Import directives are allowed to use single quotes.
class UseDoubleQuotes extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "use_double_quotes",
    problemMessage: "Use double quotes for string literals",
    errorSeverity: ErrorSeverity.INFO,
  );

  const UseDoubleQuotes() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addStringLiteral((StringLiteral node) {
      // Check whether the node is an import directive or not.
      final Iterable<SyntacticEntity>? siblings = node.parent?.childEntities;
      final bool isImportDirective = siblings != null && siblings.first.toString() == "import";

      if (node.beginToken.toString()[0] == "'" && !isImportDirective) {
        reporter.reportErrorForNode(code, node);
      }
    });
  }
}
