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
	{_, Content}=file:consult("calls.txt"),
	%io:format("~w~n",[Result]),
	%io:format("~w~n",[Content]).
	io:fwrite("**Calls to be made**~n"),
	lists:foreach(
		fun(Friends)->
			{Head, Tail} = Friends, 
			io:format("~w: ~w~n", [Head, Tail]),
			Pid = spawn(calling, talk, [self(), Head]),
			register(Head, Pid)
		end, 
		Content),
	io:fwrite("~n"),

	lists:foreach(
		fun(Friends)->
			{Head, Tail} = Friends, 
			Pid = whereis(Head),
			lists:foreach(
				fun(To)->					
					Pid ! {Head, To}
				end, 
				Tail)
		end, 
		Content),
	get_feedback().


get_feedback() ->
	receive
		{sent, From, To, MicroSecs} -> 
			io:fwrite("~s received intro message from ~s [~w]~n", [To, From, MicroSecs]),
			get_feedback();
		{received, From, To, MicroSecs} -> 
			io:fwrite("~s received reply message from ~s [~w]~n", [From, To, MicroSecs]),
			get_feedback();
		{ended, Sender} -> 
			io:fwrite("~nProcess ~s has received no calls for 1 second, ending...~n", [Sender]),
			get_feedback()
	after 1500 -> io:fwrite("~nMaster has received no replies for 1.5 seconds, ending...~n")
	end.
