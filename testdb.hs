import Control.Exception
import Database.HDBC
import Database.HDBC.PostgreSQL (connectPostgreSQL)

main = do
	c <- connectPostgreSQL "host=localhost dbname=test user=postgres password=Abcd1234"
	state <- prepare c "insert into test values (?,?);"
	select <- prepare c "select * from  test;"
	--execute state [toSql (60::Int), toSql ("test byte string"::ByteString)]
	execute state [toSql (35::Int), toSql "{Journey}"]
	execute select []
	result <- fetchAllRows select
	putStrLn $ show result
	commit c
	disconnect c
	return ()