import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'package:glyder_lints/assists/insert_spell_in_string_literal.dart';
import 'package:glyder_lints/rules/specify_type.dart';
import 'package:glyder_lints/rules/write_docs_pls.dart';

// Plugin entry point.
PluginBase createPlugin() => _GlyderLints();

/// The class listing all the [LintRule]s and [Assist]s defined by our plugin
class _GlyderLints extends PluginBase {
  // Lint rules.
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        SpecifyType(),
        WriteDocsPls(),
      ];

  // Assists.
  @override
  List<Assist> getAssists() => [
        InsertSpellInStringLiteral(),
      ];
}
