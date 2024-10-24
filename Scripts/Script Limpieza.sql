--USE GO11001P3

/*******************************************DELETE y REINICIAR AUTOINCREMENTAL ****************************************************************/
DELETE AerolineaRAW
dbcc checkident('AerolineaRAW',RESEED,0);

DELETE LecturaRAW
dbcc checkident('LecturaRAW',RESEED,0);

DELETE DimDetalleVuelo;
dbcc checkident('DimDetalleVuelo',RESEED,0);

DELETE FactVuelo;


drop table LecturaRAW;

/***************************************** Lllenado de DimFecha ******************************************************************/




/*******************************************SELECT DE DIMENSIONES ****************************************************************/
SELECT TOP 1000000 * FROM LecturaRAW;
SELECT * FROM AerolineaRAW;

SELECT * FROM DimDetalleVuelo;
SELECT * FROM FactVuelo;


SELECT * FROM LecturaRAW;
SELECT * FROM DimDetalleVuelo;
SELECT * FROM FactVuelo;
SELECT * FROM DimFecha

delete FactVuelo
drop table FactVuelo
/***********************************************************************************************************/


SELECT * FROM FactVuelo WHERE LateAircraftDelay is null;

SELECT * FROM LecturaRAW WHERE DepDelay is null;
SELECT * FROM LecturaRAW WHERE Cancelled is null;
