package = "awesome-ez"
version = "0.2.0-1"
source = {
    url = "git://github.com/jcrd/awesome-ez",
    tag = "v0.2.0",
}
description = {
    summary = "AwesomeWM library for simplifying key and button bindings",
    homepage = "https://github.com/jcrd/awesome-ez",
    license = "MIT",
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
