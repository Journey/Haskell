add:: Int -> Int -> Int
add x y = x + y

square:: Int -> Int
square x = x * x

add_cps :: Int -> Int -> ((Int -> r) -> r)
add_cps x y = \k -> k (add x y)
 
square_cps :: Int -> ((Int -> r) -> r)
square_cps x = \k -> k (square x)
 
pythagoras_cps :: Int -> Int -> ((Int -> r) -> r)
pythagoras_cps x y = \k ->
 square_cps x $ \x_squared ->
 square_cps y $ \y_squared ->
 add_cps x_squared y_squared $ k

thrice::(Int->Int)->Int->Int
thrice f x=(f.f.f) x
--thrice f x=f(f(f x))

f::Int->Int
f x = x + 1

--f_cps::(Int->Int)-Int
f_cps::a->((a->r)->r)
f_cps x = \k -> (k . f) x

thrice_cps:: (a->((a->r)->r))-> a ->((a->r)->r)
thrice_cps f_cps x = \k -> 
	f_cps x $ \fx ->
	f_cps fx $ \ffx ->
	f_cps ffx $ k

{-
cont :: ((a->r)->r) -> Cont r a
runCont :: Cont r a -> ((a->r)->r)

instance Monad (Cont r) where
	return x = cont ($ x)
	s >>= f = cont $ \c -> runCont s $ \x -> runCont (f x) c
-}
{-
	$ :: (a->b) -> a -> b
	expand >>=
		>>=:: m a -> (a - > m b) -> m b
		const expected input:: (a -> r) -> r
		
		from right:: \x -> runCont (f x) c
		=> runCont (f c)

		the left: \c -> runCont s	
		=> runCont ss

-}
{-
	invoke pythagoras_cps 2 4 print

	step 1: square_cps x => \k -> k (square x)
	setep 2: k in step 	 is \x_squared -> square_cps y
	step 3: k apply in step 1  ==> square_cps y (square x)
	step 4: expand 3 ==> (\k -> k (square y)) (square x)

	in another way -- f $ g $ h $ i

	:type ($)
	($) :: (a -> b) -> a -> b
	f $ g = f g

	maybe::
		pythonagoras_cps x y = 
			\k ->
				square_cps x $ \x_squared ->
								squared_cps y $
									\y_squared ->
										add_cps x_suqared y_squared $ k
		pythonagoras_cps x y print =
			square_cps x $ \x_squared ->
								squared_cps y $
									\y_squared ->
										add_cps x_suqared y_squared $ print



	pythonagoras_cps x y = f $ g $ h $ i
		where 
			f = \k -> square_cps x
			g = \x_squared -> square_cps y
			h = \y_squared -> add_cps \x_squared y_squared
			i = k

	f $ g = (\k -> square_cps x) (\x_squared -> square_cps y)
		= square_cps x

	f $ g = f g = g (square_cps x) = (\x_squared -> square_cps y) (square_cps x)
		= (square_cps x) (square_cps y)
		= (\k-> k (square x)) (square_cps y)
		= (square_cps y) (square x)
		= (\k -> k (square y)) (square x)
		= x' y'
-}

{-
	callCC:: ( (a->Con r b)-> Con r a) -> Con r a
	Con r a ==> (a->r)->r

	divExcpt:: Int -> Int -> (String->Con r Int)->Cont r Int
	divExcpt x y handler =  callCC $ \ok -> do
		err <- callCC $ \notOk -> do
			when (y==0) $ notOk "Denominator 0"
			ok $ x 's' y
		handler err
	
	invocation -- runCont (divExcpt 10 2 error) id
	Expand--- 

	ok :: (a->Con r b)  a :: int
	notOK :: (a-> Con r b) a:: string
-}