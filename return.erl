-module(return).
-compile(export_all).

start() ->
    io:fwrite("lol"),
    Test = io:format("xd"),
    io:format("The value is: ~p.", [Test]).