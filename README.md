# awesome-ez

awesome-ez is a library for [Awesome](https://github.com/awesomeWM/awesome)
window manager that aims to simplify the creation of key and button bindings.
It is based on code from the old Awesome wiki.

## Installation

```
$ git clone https://github.com/jcrd/awesome-ez.git
$ cd awesome-ez
$ luarocks make --local rockspec/awesome-ez-devel-1.rockspec
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

The following modifiers can be identified by their shorthand characters
in key and button definitions:

Modifier | Character
-------- | ---------
Mod4     | M
Mod1     | A
Shift    | S
Control  | C

## License

awesome-ez is licensed under the GNU General Public License v3.0 or later
(see [LICENSE](LICENSE)).
