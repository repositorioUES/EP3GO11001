

CREATE DATABASE GO11001P3
go

USE GO11001P3
go

CREATE TABLE AerolineaRAW(
	AerolineaID int not null primary key identity(1,1),
	codigo varchar(100),
	descripcion varchar(255)
)
go

CREATE TABLE LecturaRAW(
	LecturaID int not null primary key identity(1,1),
	FlightDate varchar(255) not null,
	Tail_Number varchar(255),
	Marketing_Airline_Network varchar(255),
	Flight_Number_Operating_Airline varchar(255),
	OriginCityName varchar(255),
	DestCityName varchar(255),
	DepTime varchar(255),
	DepDelay varchar(255),
	ArrTime varchar(255),
	ArrDelay varchar(255),
	Cancelled varchar(255),
	Diverted varchar(255),
	AirTime varchar(255),
	Distance varchar(255),
	CarrierDelay varchar(255),
	WeatherDelay varchar(255),
	NASDelay varchar(255),
	SecurityDelay varchar(255),
	LateAircraftDelay varchar(255)
)
go

CREATE TABLE DimFecha(
    FechaKey int not null primary key,
    fecha datetime not null,
	nombre_dia varchar(9) not null,
	nombre_mes varchar(12),
    dia tinyint not null,
    semana tinyint not null,
    mes tinyint not null,
    trimestre tinyint not null,
    anio smallint not null
)
go

CREATE TABLE DimDetalleVuelo(
	DetalleVueloKey int not null primary key,
	DetalleVueloID int not null,
	Tail_Number varchar(255) not null,
	Marketing_Airline_Network varchar(255) not null,
	Aeroline_Name varchar(255) not null,
	Flight_Number_Operating_Airline varchar(255) not null,
	OriginCityName varchar(255) not null,
	DestCityName varchar(255) not null,
	DepTime varchar(255) not null,
	DepDelay varchar(255) not null, 
	ArrTime varchar(255) not null,
	ArrDelay varchar(255) not null,
	Cancelled varchar(255) not null,
	Diverted varchar(255) not null,
	AirTime varchar(255) not null,
	Distance varchar(255) not null
)
go

CREATE TABLE FactVuelo(
	DetalleVueloKey int not null foreign key references DimDetalleVuelo(DetalleVueloKey),
	FechaVueloKey int not null foreign key references DimFecha(FechaKey),
	CarrierDelay int,
	WeatherDelay int,
	NASDelay int,
	SecurityDelay int,
	LateAircraftDelay int
)

/* Tabla inicial para fecha  */
create table Date_Dimension (
date_key int not null,
full_date smalldatetime,
day_of_week tinyint,
day_num_in_month tinyint,
day_num_overall smallint,
day_name varchar(9),
day_abbrev varchar(3),
weekday_flag varchar(7),
week_num_in_year tinyint,
week_num_overall smallint,
week_begin_date smalldatetime,
week_begin_date_key int,
month tinyint,
month_num_overall smallint,
month_name varchar(12),
month_abbrev varchar(3),
quarter tinyint,
year smallint,
yearmo int,
fiscal_month tinyint,
fiscal_quarter tinyint,
fiscal_year smallint,
last_day_in_month_flag varchar(15),
same_day_year_ago_date smalldatetime,
primary key (date_key))
;

insert into DimFecha
select date_key,full_date,day_name,month_name,day_num_in_month,week_num_in_year,[month],[quarter],[year] from Date_Dimension