blockPlain xs ys =
	xs >>=
	\x -> ys >>=
	\y -> return (x,y)

blockPlain_reload xs ys =
	concat (map (\x -> concat (map (\y->return (x,y)) ys)) xs)