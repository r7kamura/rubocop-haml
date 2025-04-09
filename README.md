# rubocop-haml

[RuboCop](https://github.com/rubocop/rubocop) plugin for [Haml](https://github.com/haml/haml) template.

## Installation

Install the gem and add to the application's Gemfile by executing:

```
bundle add rubocop-haml
```

If bundler is not being used to manage dependencies, install the gem by executing:

```
gem install rubocop-haml
```

## Usage

Require `rubocop-haml` in your RuboCop config.

```yaml
# .rubocop.yml
plugins:
  - rubocop-haml
```

> [!NOTE]
> The plugin system is supported in RuboCop 1.72+. In earlier versions, use `require` instead of `plugins`.

Now you can use RuboCop also for Haml templates.

```
$ bundle exec rubocop spec/fixtures/dummy.haml
Inspecting 1 file
C

Offenses:

spec/fixtures/dummy.haml:1:13: C: [Correctable] Style/CharacterLiteral: Do not use the character literal - use string literal instead.
%div(a="b #{?c}")
            ^^
spec/fixtures/dummy.haml:2:7: C: [Correctable] Style/HashSyntax: Use the new Ruby 1.9 hash syntax.
%div{ :a => "b" }
      ^^^^^
spec/fixtures/dummy.haml:2:13: C: [Correctable] Style/StringLiterals: Prefer single-quoted strings when you don't need string interpolation or special symbols.
%div{ :a => "b" }
            ^^^

1 file inspected, 3 offenses detected, 3 offenses autocorrectable
```

## Related projects

- https://github.com/r7kamura/rubocop-erb
- https://github.com/r7kamura/rubocop-haml
- https://github.com/r7kamura/rubocop-markdown
