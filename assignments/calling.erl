%% @author 
%% @doc include	the code associated with the “people” process


-module(calling).

%% ====================================================================
%% API functions
%% ====================================================================
-export([talk/2]).



%% ====================================================================
%% Internal functions
%% ====================================================================

talk(Master, Sender) ->
	receive 
		{From, To} -> % master is telling me that "From" can talk with "To" now, so I will send a message to "To"
			{_, _, MicroSecs} = erlang:timestamp(),
			timer:sleep(rand:uniform(1000)),
			Friend = whereis(To), % find my friend
			Friend ! {From, To, "message", MicroSecs}, % send message to my friend
			Master ! {sent, From, To, MicroSecs}, % tell master the action of "sending"
			talk(Master, Sender); % wait further messages
		{From, To, Message, MicroSecs} -> % I recevied a message from "From"
			timer:sleep(rand:uniform(1000)),
			Master ! {received, From, To, MicroSecs}, % tell master the action of "receiving"
			talk(Master, Sender)
	after 1000 -> io:fwrite("~nProcess ~s has received no calls for 1 second, ending...~n~n", [Sender])
	end.
