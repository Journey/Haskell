-- use pattern matching to define a mid-operator
-- in this case >>? is a function, but the parameters not only follows behind the function name
(>>?):: Maybe a -> (a -> Maybe b) -> Maybe b
Nothing >>? _ = Nothing
Just v >>? f = f v

data Maybe a = Nothing | Just a

newtype Parse a = {
	runParse::ParseState->Either String (a, ParseState)
}

(==>)::Parse a -> (a->Parse b) -> Parse b
firstParse ==> secondParse = Parse chainedParser
	where chainedParser initState =
		case runParse firstParse initState of
			Left errMessage ->
				Left errMessage
			Right (firstResult, newState) ->
				runParse (secondParse firstResult) newState
--the common rule- a function takes a plan value, inject it into the target type/
{--
	data type: a function takes a plain value, inject it into the target type
	a type constructor m
	a function type m a -> (a -> m b) -> m b(chain), also called bind- because it bind the result of the computation on the left to the params of the one on the right.
	a functio of type a -> m a for injecting a normal value into the chain

	what makes Maybe type a monad == type constructor Maybe a ; chainning function >>?; the injector function Just

	the Monad typeclass 
 --}

 class Monad m where
 	--chain
 	>>=:: m a -> (a->m b) -> m b
 	-- inject
 	return:: a -> m a
 	-- like bind, it just ignores the value on the left. used for want to perform actions in a certain order, but don't care what the result of one is.
 	(>>):: m a -> m b -> m b
 	-- fail, takes an error message and does something to make the chain of functions fail.
 	fail:: String -> m a

 	-- no standard
 	(=<<):: (Monad m)=> (a -> m b) -> m a -> m b

{--
	Moadic - is a
--}
