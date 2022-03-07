# What is YAML?

YAML stands for *YAML Ain't Markup Language* and it is used for configuration files, blueprints, and also in page settings.
YAML is to configuration what markdown is to markup. It’s basically a human-readable structured data format. It is less complex and ungainly than XML or JSON, but provides similar capabilities.

# Basic rules

There are some rules that YAML has in place to avoid issues related to ambiguity in relation to various languages and editing programs. These rules make it possible for a single YAML file to be interpreted consistently, regardless of which application and/or library is being used to interpret it.

- YAML files should end in ``.yaml`` or ``yml``.
- YAML is case sensitive.
- YAML does not allow the use of tabs. Spaces are used instead as tabs are not universally supported.

# Basic data types

YAML excels at working with:

- mappings (hashes/dictionaries)
- sequences (arrays/lists)
- scalars (strings/numbers)

# Features

- Null value

```yaml
null_value: null
```

- Boolean values

```yaml
boolean: true or false
```

- Strings not need to be quoted

However, they can be.

```yaml
however: 'A string, enclosed in quotes.'
single quotes: 'have ''one'' escape pattern'
double quotes: "have many: \", \0, \t, \u263A, \x0d\x0a == \r\n, and more."
```

- Multiline-strings

Multiple-line strings can be written either as a *literal block* (using ``|``), or a *folded block* (using '>').

```yaml
literal_block: |
    This entire block of text will be the value of the 'literal_block' key,
    with line breaks being preserved.

    The literal continues until de-dented, and the leading indentation is
    stripped.
```

```yaml
folded_style: >
    This entire block of text will be the value of 'folded_style', but this
    time, all newlines will be replaced with a single space.

    Blank lines, like above, are converted to a newline character.
```

- Comments

```yaml
# Comments in YAML look like this.
```

- YAML is a superset of JSON

```yaml
json_map: {"key": "value"}
json_seq: [3, 2, 1, "takeoff"]
and quotes are optional: {key: [3, 2, 1, takeoff]}
```

- Anchors and Aliases

YAML anchors let you easily duplicate contents across your document. Both of these keys will have the same value:

```yaml
anchored_content: &anchor_name This string will appear as the value of two keys.
other_anchor: *anchor_name
```

- Merge Key Language-Independent Type

It is used to indicate that all the keys of one or more specified maps should be inserted into the current map.

```yaml
foo: &foo
  <<: *base
  age: 10

bar: &bar
  <<: *base
  age: 20
```

# References

- [Official YAML 1.2 Documentation](https://yaml.org/spec/1.2/spec.html)
- [Xavier Shay's YAML tutorial](https://rhnh.net/2011/01/31/yaml-tutorial/)
- [YAML Reference Card](https://yaml.org/refcard.html)
- [YAMLLint](http://www.yamllint.com/)
