## Template Information

| Name      | Description       |
| --------- | ----------------- |
| File name | strings-default.stencil |
| Invocation example | `swiftgen strings -t default …` |
| Language | Swift 2 |
| Author | Olivier Halligon |

## When to use it

- When you need to generate *Swift 2* code
- If you use unstructured key names for your strings, or a structure that we don't support (yet). If you use "dot-syntax" keys, please check out the [dot-syntax](dot-syntax.md) template.

## Customization

You can customize some elements of this template by overriding the following parameters when invoking `swiftgen` in the command line, using `--param <paramName> <newValue>`

| Parameter Name | Default Value | Description |
| -------------- | ------------- | ----------- |
| `enumName` | `L10n` | Allows you to change the name of the generated `enum` containing all string tables. |

## Generated Code

**Extract:**

```swift
enum L10n {
  /// Some alert body there
  case AlertMessage
  /// Title of the alert
  case AlertTitle
  /// You have %d apples
  case ApplesCount(Int)
  /// Those %d bananas belong to %@.
  case BananasOwner(Int, String)
}
```

[Full generated code](https://github.com/SwiftGen/templates/blob/master/Tests/Expected/Strings/default-context-defaults.swift)

## Usage example

```swift
// Simple strings
let message = L10n.AlertMessage.string
let title = tr(.AlertTitle)

// with parameters, note that each argument needs to be of the correct type
let apples = L10n.ApplesCount(3)
let bananas = L10n.BananasOwner(5, "Olivier")
```
