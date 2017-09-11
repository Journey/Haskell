#how to run haskell file?
* compile the program: `ghc -o target_file --make source_file.hs` , then `target_file parameters`
*  load the file - `:l myfunctions.hs`


# how to handle exceptions


# how to read/use standard components
* read
* show
*getLine


# concept
* bind >>
* Mond


## diff between `>>` `>>=` `do`
* if the action does not return a value  `>>`
* if immediately passing the value into the next action `>>=`
* otherwise `do`

## `$`

* `return $ String x` <=> `return (String x)`
