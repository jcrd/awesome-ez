package = "awesome-ez"
version = "devel-2"
source = {
    url = "git+https://github.com/jcrd/awesome-ez",
    tag = "master",
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
