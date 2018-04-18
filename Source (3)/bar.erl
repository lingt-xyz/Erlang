%% @author eavis
%% @doc @todo Add description to bar.


-module(bar).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0, hello_world/1]).


% shorten paths
-import(foo, [area3/1]).


%% ====================================================================
%% Internal functions
%% ====================================================================

% This is the default start point for the program
start() ->
	hello_world("calling start and then hello_world...").

% but we can start with this function if we explcitly invoke it
% on the command line
hello_world(Msg) ->
	io:fwrite("msg: ~s~n", [Msg] ),
	io:fwrite("rectangle area: ~w~n", [foo:area({rectangle, 4, 5})] ),
	io:fwrite("square area: ~w~n", [foo:area({square, 6})] ),
	io:fwrite("circle area: ~w~n", [foo:area({square, 6})] ),
	io:fwrite("area2 2 parm: ~w~n", [foo:area2(4, 6)] ),
	io:fwrite("area2 1 parm: ~w~n", [foo:area2(5)] ),
	io:fwrite("area3, non qualified: ~w~n", [area3(10)] ),
	io:fwrite("An int, a float and a string: ~w, ~w, ~s ~n", [4, 77.76, "woo"] ).

