%% @author eavis
%% @doc @todo Add description to foo.


-module(foo).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).



%% ====================================================================
%% Internal functions
%% ====================================================================

% The start method below will simply execurte the baz method
% and then wait for a single response.
%
% if you replace baz with baz2, and get_feedback with get_feedback2,
% you will get a different output.
start() ->
	Pid = spawn(bar, baz, []),
    Pid ! {self(), {cat, "Fluffy"}},
    Pid ! {self(), {dog, "Spot"}},
	io:fwrite("parent ID: ~w\n\n", [self()]),
    get_feedback().

get_feedback() ->
	receive
		{Msg} -> 
			io:fwrite("Msg in get_feedback ~s \n\n", [Msg])
	end.



%% get_feedback2() ->
%% 	receive
%% 		{Msg} -> 
%% 			io:fwrite("Msg in get_feedback2 ~s \n\n", [Msg]),
%% 		    get_feedback2()
%% 	after 2000 -> true
%% 	end.
%% 

