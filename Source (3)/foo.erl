%% @author eavis
%% @doc @todo Add description to foo.


-module(foo).

%% ====================================================================
%% API functions
%% ====================================================================
-export([area/1, area2/1, area2/2, area3/1]).



%% ====================================================================
%% Internal functions
%% ====================================================================


% The area function is defined so as to be call-able
% in three ways. With Erlang, we are essentially using
% pattern matching on the first element of the tuple 
% to determine which version of the function that should 
% be invoked.
% Note the following:
%  1] The three variations will be tried, in order, until a 
%     match is found.
%  2] Each variation of the function only takes a single
%     argument - a tuple. 
%  3] Each variation of the function is delimited by a 
%     semi-colon (except for the last one). It other
%     words, this is a single fucntion definition.
area({rectangle, Width, Height}) ->
	Width * Height;

area({square, Side}) ->
	Side * Side;

area({circle, Radius}) ->
	3.14159 * Radius * Radius.


% The area2 function is defined so as to be call-able
% in multiple ways. In this case, we are defining two
% versions of the function, one with two parameters
% and one with a single parm.
% Note the followng that each version of the area2 
%  function is terminated by a period. In other words, 
%  these are two separate function definitions. This 
%  is more like the method over-loading seen in other languages.
area2(Width, Height) ->
	Width * Height.

area2(Side) ->
	Side * Side.

% uncomment this and see what happens
%area2(Radius) ->
%	3.14159 * Radius * Radius.



% The area3 function is defined as two distinct functions,
% one with two parameters and one with a single parm.
% Note, howeverm, that we are only exporting the area3/1
% version, thus making the area3/2 version private.
area3(Whatever1, Whatever2) ->
	Whatever1 * Whatever2.

area3(Whatever) ->
	area3(Whatever, 1000).




	

