package = "awesome-ez"
version = "0.1.0-1"
source = {
    url = "git://github.com/jcrd/awesome-ez",
    tag = "v0.1.0",
}
description = {
    summary = "AwesomeWM library for simplifying key and button bindings",
    homepage = "https://github.com/jcrd/awesome-ez",
    license = "GPL-3.0",
}
dependencies = {
    "lua >= 5.1",
}
build = {
    type = "builtin",
    modules = {
        ["awesome-ez"] = "init.lua",
    },
}
