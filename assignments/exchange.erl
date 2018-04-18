%% @author
%% @doc correspond to the master process


-module(exchange).

%% ====================================================================
%% API functions
%% ====================================================================
-import(string,[len/1, concat/2, chr/2,substr/3,str/2,to_lower/1,to_upper/1]).
-export([start/0]).



%% ====================================================================
%% Internal functions
%% ====================================================================

start() ->
	read_by().



		
read_by()->
	{_,Content}=file:consult("calls.txt"),
	%io:format("~w~n",[Result]),
	%io:format("~w~n",[Content]).
	io:fwrite("**Calls to be made**~n"),
	lists:foreach(fun(X)->{Head,Tail}=X, io:format("~w: ~w~n", [Head, Tail]) end, Content),
	io:fwrite("~n"),

	lists:foreach(
		fun(X)->
			{Head,Tail}=X, 
			%io:format("~w: ~w~n", [Head, Tail]) 
			lists:foreach(
				fun(Y)->
					Pid = spawn(calling, caller, []),
					timer:sleep(rand:uniform(1000)),
					{_,_,MicroSecs} = erlang:timestamp(),
					Pid ! {self(), {Head, Y, MicroSecs}},
					io:fwrite("~s received intro message from ~s [~w]\n", [Y, Head, MicroSecs])
				end, 
				Tail)
		end, 
		Content),
	get_feedback().


get_feedback() ->
	receive
		{From, To, MicroSecs} -> 
			io:fwrite("~s received reply message from ~s [~w]\n", [From, To, MicroSecs]),
			get_feedback()
	after 2000 -> true
	end.
