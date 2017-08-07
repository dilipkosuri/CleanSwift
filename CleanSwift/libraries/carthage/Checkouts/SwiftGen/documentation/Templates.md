# Customize SwiftGen templates

This document describes how to make your own templates for SwiftGen, so it can generate code more to your liking and code following your own coding conventions.

## Templates files on disk

When you invoke SwiftGen, you can specify templates by name or by path.

### Using a full path

If you use the `--templatePath` (or `-p`) option, you'll need to specify the **full path** to the template you want to use. This allows you to store your templates anywhere you want and name them anyhow you want, but can become quite annoying to type.

### Using a name

When you use the `--template` (or `-t`) option, you only specify a **template name**. SwiftGen then searches a matching template using the following rules (where `<subcommand>` is one of `colors`, `images`, `storyboards` or `strings` depending on the subcommand you invoke):

* It searches for a file named `<subcommand>-<name>.stencil` in `~/Library/Application Support/SwiftGen/templates`, which is supposed to contain your own custom templates
* If it does not find one, it searches for a file named `<subcommand>-<name>.stencil` in `<installdir>/share/swiftgen/templates` which contains the templates bundled with SwiftGen.

For example `swiftgen images -t foo DIR` will search for a template named `images-foo.stencil` in Application Support, then in `/usr/local/share/SwiftGen/templates` (assuming you installed SwiftGen using Homebrew in `/usr/local`)

### Default template

If you don't specify neither `-t` nor `-p`, SwiftGen will assume you specified `-t default`.

That means that `swiftgen images DIR` will use the `images-default.stencil` template. 

Stencil comes with a default template for each of its subcommand, but given this rule, this means that **you have the ability to make your own default template for each subcommand** and store them in `Application Support` named like `images-default.stencil`, etc.

## List installed templates

The `swiftgen templates` command will list all the installed templates (as YAML output) for each subcommand, both for bundled templates and custom templates.

```bash
$ swiftgen templates
colors:
  custom:
  bundled:
   - default
   - rawValue
images:
  custom:
  bundled:
   - allvalues
   - default
storyboards:
  custom:
   - mytemplate
  bundled:
   - default
   - lowercase
   - swift3
strings:
  custom:
   - default
  bundled:
   - default
   - swift3
```

## Templates Format, Nodes and Filters

Templates in SwiftGen are based on [Stencil](https://stencil.fuller.li/), a template engine inspired by Django and Mustache. The syntax of the templates [is explained in Stencil's documentation](https://stencil.fuller.li/en/latest/templates.html).

Additionally to the [tags and filters](https://stencil.fuller.li/en/latest/builtins.html) provided by Stencil, SwiftGen provides some additional ones, documented in the [StencilSwiftKit framework](https://github.com/SwiftGen/StencilSwiftKit).

## Templates Contexts

When SwiftGen generates your code, it provides a context (a dictionary) with the variables containing what images/colors/strings/… the subcommand did detect, to render your Stencil template using those variables.

Below are the variables in the context generated by each SwiftGen subcommand. They are also visible as [comments in the source code here](https://github.com/SwiftGen/SwiftGenKit/tree/master/Sources/Stencil).

### Colors

 - `colors`: `Array` of:
    - `name` : `String` — name of each color
    - `red`  : `String` — hex value of the red component
    - `green`: `String` — hex value of the green component
    - `blue` : `String` — hex value of the blue component
    - `alpha`: `String` — hex value of the alpha component

### Fonts

 - `families`: `Array` — list of font families
   - `name` : `String` — name of family
   - `fonts`: `Array` — list of fonts in family
     - `style`: `String` — font style
     - `name` : `String` — font postscript name

### Images

 - `catalogs`: `Array` — list of asset catalogs
   - `name`  : `String` — the name of the catalog
   - `assets`: `Array` — tree structure of items, each item is either a:
     - group: this represents a folder
		- `name` : `String` — name of the folder
        - `items`: `Array` — list of items, can be either groups or images
     - image: this represents an image asset
        - `name` : `String` — name of the image
        - `value`: `String` — the actual name for loading the image

### Storyboards

 - `modules`    : `Array<String>` — List of modules used by scenes and segues
 - `storyboards`: `Array` — List of storyboards
    - `name`: `String` — Name of the storyboard
    - `initialScene`: `Dictionary` (absent if not specified)
       - `customClass` : `String` (absent if generic UIViewController/NSViewController)
       - `customModule`: `String` (absent if no custom class)
       - `baseType`: `String` (absent if class is a custom class).
          The base class type on which the initial scene is base.
          Possible values include 'ViewController', 'NavigationController', 'TableViewController'…
    - `scenes`: `Array` (absent if empty)
       - `identifier` : `String`
       - `customClass`: `String` (absent if generic UIViewController/NSViewController)
       - `customModule`: `String` (absent if no custom class)
       - `baseType`: `String` (absent if class is a custom class).
          The base class type on which a scene is base.
          Possible values include 'ViewController', 'NavigationController', 'TableViewController'…
    - `segues`: `Array` (absent if empty)
       - `identifier`: `String`
       - `customClass`: `String` (absent if generic UIStoryboardSegue)
 
### String

 - `tables`: `Array` — List of string tables
   - `name`   : `String` — name of the `.strings` file (usually `"Localizable"`)
   - `strings`: `Array` — Tree structure of strings (based on dot syntax), each level has:
     - `name`   : `String` — name of the level
     - `strings`: `Array` — list of strings at this level:
       - `key`: `String` — the full translation key
       - `translation`: `String` — the translated text
       - `types`: `Array<String>` — defined only if localized string has parameters.
          Containing types like `"String"`, `"Int"`, etc
       - `keytail`: `String` containing the rest of the key after the next first `.`
         (useful to do recursion when splitting keys against `.` for structured templates)
     - `subenums`: `Array` — list of sub-levels, repeating the structure mentioned above