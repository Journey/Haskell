module Main where
import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

spaces :: Parser ()
spaces = skipMany1 space

data LispVal = Atom String
	|

readExpr :: String -> String
readExpr input = case parse (spaces >> symbol) "lisp" input of
	Left err -> "No match:" ++ show err
	Right val -> "Found value"

main :: IO ()
main = do
	(expr:_) <- getArgs
	putStrLn (readExpr expr)
