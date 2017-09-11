{--find the last element of a list--}
import Data.List

myLast :: [a] -> a
--myLast :: [a] -> a
myLast [] = error "list is empty!"
myLast xs = xs !! n
	where n = length xs - 1

myLast' :: [a] -> a
myLast' [] = error "this is the empty list, no last element at all"
myLast' [x] = x
myLast' (_:xs) = myLast' xs

myLast'' :: [a] -> a
myLast'' = foldr1 (const id)

myLast''' :: [a] -> a
myLast''' = foldr1 (flip const)

myLast'''' :: [a] -> a
myLast'''' = foldl1 (curry snd)


myButList :: [a] -> a
myButList [] = error "list is empty"
myButList [x] = x
myButList xs = xs !! n
	where n = length xs -2

myButList' :: [a] -> a
myButList' [] = error "list is empty"
myButList' xs = last . init $ xs

-- recursive version
myButList'' :: [a] -> a
myButList'' [x,_] = x
myButList'' (x:xs) = myButList'' xs

myButList''' :: [a] -> a
myButList''' = head . tail . reverse

myButList'''' :: [a] -> a
myButList'''' = fst . foldl (\(a,b) x -> (b,x)) (err1, err2)
	where
		err1 = error "last but1: Empty list"
		err2 = error "last but1: Singleton"

--elementAt :: Int b =>[a] b -> a
elementAt :: [a] -> b -> a
elementAt =
