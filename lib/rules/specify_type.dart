import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class SpecifyType extends DartLintRule {
  static const LintCode _code = LintCode(
    name: "specify_type",
    problemMessage: "Explicitly specify type in variable declarations",
    correctionMessage: "Specify type",
  );

  SpecifyType() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclaration((VariableDeclaration node) {
      final VariableElement? element = node.declaredElement;

      // Just return if no variable was found.
      // if (element == null) {
      //   return;
      // }

      if (element!.hasImplicitType) {
        reporter.reportErrorForElement(code, element);
      }
    });
  }
}
