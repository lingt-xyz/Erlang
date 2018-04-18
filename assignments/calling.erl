%% @author 
%% @doc include	the code associated with the “people” process


-module(calling).

%% ====================================================================
%% API functions
%% ====================================================================
-export([caller/0]).



%% ====================================================================
%% Internal functions
%% ====================================================================

caller() ->
	receive 
		{Sender, {From, To, MicroSecs}} ->
			timer:sleep(rand:uniform(1000)),
			Sender ! {From, To, MicroSecs},
			caller()
	after 2000 -> true
	end.



