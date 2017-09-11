{--
	type constur
--}
module Logger
	(
		Logger,
		Log,
		runLog,
		record
	) where
		type Log = [String]

		runLogger:: Logger a -> (a, Log)