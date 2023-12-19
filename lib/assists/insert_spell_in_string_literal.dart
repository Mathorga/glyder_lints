import 'dart:math';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// Assist to suggest spells to insert in string literals
class InsertSpellInStringLiteral extends DartAssist {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    final Random rand = Random();
    // A list of spells I know -- not much of a wizard!
    final List<String> spells = [
      "Accio",
      "Alohomora",
      "Lumos",
      "Wingardium Leviosa",
      "Expecto Patronum",
    ];

    context.registry.addSimpleStringLiteral((SimpleStringLiteral node) {
      // `return` if the visited node is not under the cursor
      if (!target.intersects(node.sourceRange)) return;

      // Create `ChangeBuilder` instance to do file operations with an action
      final ChangeBuilder changeBuilder = reporter.createChangeBuilder(
        message: "Insert a random spell in the string literal",
        priority: 1,
      );

      // Use the `changeBuilder` to make Dart file edits
      changeBuilder.addDartFileEdit((DartFileEditBuilder builder) {
        // Use the `builder` to insert a string at the beginning of string literal
        builder.addSimpleInsertion(
          node.offset + 1,
          // A random value from the `spells` to insert
          "${spells.elementAt(rand.nextInt(spells.length - 1))}! ",
        );
      });
    });
  }
}
