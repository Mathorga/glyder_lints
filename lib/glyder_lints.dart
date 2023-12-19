import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:glyder_lints/assists/insert_spell_in_string_literal.dart';
import 'package:glyder_lints/rules/amend_model_suffix.dart';
import 'package:glyder_lints/rules/dont_say_his_name.dart';
import 'package:glyder_lints/rules/prefer_single_import_quotes.dart';

// Plugin entry point.
PluginBase createPlugin() => _GlyderLints();

// The class listing all the [LintRule]s and [Assist]s defined by our plugin
class _GlyderLints extends PluginBase {
  // Lint rules.
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        DontSayHisName(),
        AmendModelSuffix(),
        PreferSingleImportQuotes(),
      ];

  // Assists.
  @override
  List<Assist> getAssists() => [
        InsertSpellInStringLiteral(),
      ];
}
