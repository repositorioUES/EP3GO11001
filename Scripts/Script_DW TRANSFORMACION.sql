-- USE GO11001P3

-- SELECT TOP 1000 * FROM LecturaRAW;

SELECT
	lr.LecturaID,
	--FlightDate,
	CAST(REPLACE(CONVERT(VARCHAR, lr.FlightDate, 120), '-', '') AS INT) AS FlightDate,
	lr.Marketing_Airline_Network,
	ar.descripcion AS Aeroline_Name,
	ISNULL(lr.Tail_Number,'SIN REGISTRO') AS Tail_Number,
	lr.Flight_Number_Operating_Airline,
	lr.OriginCityName,
	lr.DestCityName,
	COALESCE(Substring(lr.DepTime,1,2) + ':' + Substring(lr.DepTime,3,2),'SIN REGISTRO') AS Deptime,
	COALESCE(Substring(lr.ArrTime,1,2) + ':' + Substring(lr.ArrTime,3,2),'SIN REGISTRO') AS ArrTime,
	-- ISNULL(REPLACE(DepDelay, '.00', ''), 'SIN REGISTRO') AS DepDelay,
	CASE
		WHEN lr.DepDelay IS NULL THEN 'SIN REGISTRO'
		WHEN CAST(lr.DepDelay AS FLOAT) > 0 THEN 'VUELO DIFERIDO'
		WHEN CAST(lr.DepDelay AS FLOAT) < 0 THEN 'VUELO SALIO ANTES'
		ELSE 'NO HAY DATOS' END AS DepDelay,
	-- ISNULL(REPLACE(ArrDelay, '.00', ''), 'SIN REGISTRO') AS ArrDelay,
	CASE
		WHEN lr.ArrDelay IS NULL THEN 'SIN REGISTRO'
		WHEN CAST(lr.ArrDelay AS FLOAT) > 0 THEN 'VUELO RETRASADO'
		WHEN CAST(lr.ArrDelay AS FLOAT) < 0 THEN 'VUELO LLEGO ANTES'
		ELSE 'NO HAY DATOS' END AS ArrDelay,
	CASE lr.Cancelled
		WHEN '0.00' THEN 'VUELO REGULAR'
		WHEN '1.00' THEN 'CANCELADO'
		ELSE 'SIN REGISTRO' END AS Cancelled,
	CASE lr.Diverted
		WHEN '0.00' THEN 'SIN DESVIO'
		WHEN '1.00' THEN 'DESVIADO'
		ELSE 'NO HAY DATOS' END AS Diverted,
	ISNULL(REPLACE(lr.AirTime, '.00', ''), 'SIN REGISTRO') AS AirTime,
	ISNULL(REPLACE(lr.Distance, '.00', ''), 'SIN REGISTRO') AS Distance,
	ISNULL(CAST(CAST(lr.CarrierDelay AS FLOAT) AS INT),-1 )AS CarrierDelay,
	ISNULL(CAST(CAST(lr.WeatherDelay AS FLOAT) AS INT),-1) AS WeatherDelay,
	ISNULL(CAST(CAST(lr.NASDelay AS FLOAT) AS INT),-1) AS NASDelay,
	ISNULL(CAST(CAST(lr.SecurityDelay AS FLOAT) AS INT),-1) AS SecurityDelay,
	ISNULL(CAST(CAST(lr.LateAircraftDelay AS FLOAT) AS INT),-1) AS LateAircraftDelay
FROM LecturaRAW lr
	INNER JOIN AerolineaRAW ar ON lr.Marketing_Airline_Network=ar.codigo
	  WHERE 
		   CAST(CAST(lr.NASDelay AS FLOAT) AS INT)>=0
	  AND CAST(CAST(lr.WeatherDelay AS FLOAT) AS INT) >=0
	  AND CAST(CAST(lr.NASDelay AS FLOAT) AS INT) >=0
	  AND CAST(CAST(lr.SecurityDelay AS FLOAT) AS INT)>=0
	  AND CAST(CAST(lr.LateAircraftDelay AS FLOAT) AS INT)>=0 
	  ;