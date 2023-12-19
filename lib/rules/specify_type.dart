import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Enforces the explicit declaration of variable types.
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
      if (element == null) {
        return;
      }

      // Report error for implicit type declarations.
      if (element.hasImplicitType) {
        reporter.reportErrorForElement(code, element);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
        _AddType(),
      ];
}

/// Fixes the missing type by inserting it.
class _AddType extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    // Callback fn that runs on every variable declaration in a file
    context.registry.addVariableDeclaration((VariableDeclaration node) {
      final VariableElement? element = node.declaredElement;

      // Just return if the current variable declaration is not where the lint error has appeared.
      if (element == null /*|| !analysisError.sourceRange.intersects(node.sourceRange)*/) {
        return;
      }

      // Create a ChangeBuilder instance to do file operations with an action
      final ChangeBuilder changeBuilder = reporter.createChangeBuilder(
        message: "Add type",
        priority: 1,
      );

      // Use the changeBuilder to make Dart file edits.
      changeBuilder.addDartFileEdit((DartFileEditBuilder builder) {
        // builder.addInsertion(node.beginToken.offset + node.beginToken.length, (DartEditBuilder builder) {
        //   builder.writeType(element.type);
        // });
        builder.addSimpleInsertion(node.beginToken.offset, "${element.type.toString()} ");

        // // Use the `builder` to replace the variable name
        // builder.addSimpleReplacement(
        //   SourceRange(element.nameOffset, element.nameLength),
        //   // the string to be replaced instead of variable name
        //   element.name.replaceAll(
        //     "_voldemortRegex",
        //     "HeWhoMustNotBeNamed",
        //   ),
        // );
      });
    });
  }
}
