# awesome-ez

awesome-ez is a library for [Awesome](https://github.com/awesomeWM/awesome)
window manager that aims to simplify the creation of key and button bindings.
It is based on code from the old Awesome wiki.

## Installation

Install the latest stable release with `luarocks`:

```sh
luarocks install awesome-ez
```

## Usage

Require the library:

```lua
local ez = require("awesome-ez")
```

Use `ez.keytable` to define key bindings:

```lua
local globalkeys = ez.keytable {
    ["M-Return"] = {awful.spawn, "xterm"},
    ...
}
```

Use `ez.btntable` to define button bindings:

```lua
local clientbtns = ez.btntable {
    ["1"] = function (c) client.focus = c end,
    ["M-1"] = awful.mouse.client.move,
    ["M-3"] = awful.mouse.client.resize,
}
```

Binding definition strings consist of modifier characters and a key or button
separated by hyphens, e.g. `M-S-x` is the combination of `Mod4`, `Shift`, and
the `x` key.

See the [API documentation](https://jcrd.github.io/awesome-ez/) for
descriptions of all functions.

### Modifiers

The following modifiers can be identified by their default shorthand characters
in key and button definitions:

Character | Modifier
--------- | --------
M         | Mod4
A         | Mod1
S         | Shift
C         | Control

The `modifiers` table can be customized:

```lua
ez.modifiers["M"] = "Mod1"
```

## License

This project is licensed under the MIT License (see [LICENSE](LICENSE)).
