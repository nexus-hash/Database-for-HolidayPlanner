
CREATE TABLE users (
  UserName serial not null primary key ,
    Password text not null ,
    FirstName varchar(20) ,
    MiddleName varchar(20),
    LastName varchar(20),
    Address varchar(150),
    DOB date,
    PhoneNumber varchar(13),
    EmailID varchar(150)
);


CREATE TABLE Flight (
    FlightNumber varchar(6) not null primary key ,
    Departure varchar(20),
    Arrival varchar(20),
    AirlineName varchar(20),
    DepartureTime TIME,
    ArrivalTime TIME,
    NoOfTickets Int,
    FlightFare varchar(10)
);

CREATE TABLE Hotel(
  HotelID varchar(5) not null primary key ,
  HotelName varchar(20),
  HotelLocation varchar(30),
  AreaCode varchar(7),
  CONSTRAINT AreaPresent
                  foreign key (AreaCode)
                  references StateDetails(AreaCode)
);

CREATE TABLE HotelDetailed(
    HotelDetailsID serial not null primary key ,
    HotelID varchar(5) null ,
    HotelFare varchar(10) null ,
    NoOfBeds varchar(3) null ,
    Availability int null,
    DateAvail date null,
    constraint HotelDetailedID
                          foreign key (HotelID)
                          references Hotel(HotelID)
 );



CREATE Table StateDetails(
    AreaCode varchar(7) not null primary key ,
  CityName varchar(30),
  CityDescription varchar(200),
  StateName varchar(15),
  Country varchar(20)
);

CREATE Table TourGuide(
    GuideID varchar(5) not null primary key ,
    GuideName varchar(50) null ,
    Gender varchar(1) check ( Gender='M'or Gender='T'or Gender='F' ) null ,
    KnownLanguage varchar(100) null ,
    PhoneNumber varchar(13) null ,
    EmailID varchar(150) null unique ,
    FeeAmount Int null ,
    TourID varchar(5) null,
    CONSTRAINT TourRefer
                      foreign key (TourID)
                      references Tour(TourID)
);


CREATE TABLE Cab(
    CabID varchar(5) not null primary key ,
    CabType varchar(10) check ( CabType='Mini' or CabType='Sedan'or CabType='SUV' or CabType='Micro' ),
    CabLocation varchar(30),
    CabFare Int,
    CabVehicleNo varchar(15) null unique ,
    availability boolean null ,
    CabModel varchar(60) null ,
    DriverNo varchar(13) null
);

CREATE TABLE FlightAvailability(
    flightNumber varchar(5) ,
    Dates date,
    NoOfTicket int,
    CONSTRAINT FlightNumberAvail
                               foreign key (flightNumber)
                               references Flight(FlightNumber)
);


CREATE TABLE Tour(
    TourID varchar(5) not null primary key ,
    TourName varchar(20),
    TourDescription varchar(300),
    PlaceFrom varchar(100),
    PlaceTo varchar(100),
    PlacesTobe varchar(400),
    Duration INT,
    TourFare Int
);

CREATE TABLE TourContainsGuide(
    TourID varchar(5),
    GuideID varchar(5),
    CONSTRAINT TourGuideRefer
                              foreign key (TourID)
                              references Tour (TourID),
    CONSTRAINT GuideReferTour
                              foreign key (GuideID)
                              references TourGuide(GuideID)
);

CREATE TABLE TourContainsAreaCode(
    TourID varchar(5),
    AreaCode varchar(5),
    CONSTRAINT TourAreaCodeRefer
                              foreign key (TourID)
                              references Tour (TourID),
    CONSTRAINT AreaCodeReferTour
                              foreign key (AreaCode)
                              references StateDetails(AreaCode)
);

CREATE TABLE TourContainsCab(
    TourID varchar(5),
    CabID varchar(5),
    CONSTRAINT TourCabRefer
                              foreign key (TourID)
                              references Tour (TourID),
    CONSTRAINT CabReferTour
                              foreign key (CabID)
                              references Cab(CabID)
);

CREATE TABLE Package(
  PackageID varchar(5) not null  primary key ,
  PackageName varchar(20) null,
  TotalDays INT null,
  Places varchar(80) null,
  PackageDescription varchar(300) null,
  PackageFare varchar(10) null
);



CREATE TABLE PackageContainsFlights(
    PackageID varchar(5),
    FlightNumber varchar(5),
    CONSTRAINT PackageHasFlights
                              foreign key (PackageID)
                              references Package(PackageID),
    CONSTRAINT FlightinPackage
                              foreign key (FlightNumber)
                              references Flight(FlightNumber)
);

CREATE TABLE PackageContainsTours(
    PackageID varchar(5),
    TourID varchar(5),
    CONSTRAINT PackageHasTours
                              foreign key (PackageID)
                              references Package(PackageID),
    CONSTRAINT ToursinPackage
                              foreign key (TourID)
                              references Tour(TourID)
);

CREATE TABLE PackageContainsHotel(
    PackageID varchar(5) null ,
    HotelID varchar(5) null ,
    constraint PackageHotelID
                                 foreign key (HotelID)
                                 references Hotel(HotelID),
    constraint PackagePackageID
                                 foreign key (PackageID)
                                 references Package(PACKAGEID)
);

CREATE TABLE DosAndDonts(
    LocalRules varchar(800),
    AreaCode varchar(7),
    CONSTRAINT AreaCodeRules
                        foreign key (AreaCode)
                        references StateDetails(AreaCode)
);

CREATE TABLE EventsDetails(
    AreaCode varchar(7),
    Month varchar(15),
    FamousFestivals varchar(100)
);

CREATE Table PackageBooking(
    PackageBookID SERIAL PRIMARY KEY NOT NULL ,
    UserName int,
    PackageID varchar(5),
    PackageFromDate date,
    PaymentMethod text,
    NumberOfPersons INT,
    BookingTime timestamp,
    CONSTRAINT UserNamePackage
                           foreign key (UserName)
                           references users (UserName),
    CONSTRAINT PackageIDPackage
                           foreign key (PackageID)
                           references Package (PackageID)
);


CREATE TABLE TourBooking(
    TourBookingID Serial NOT NULL PRIMARY KEY ,
    TourID varchar(5),
    UserName int null,
    TourFromDate date,
    PaymentMethod text,
    NumberOfPersons Int,
    BookingTime timestamp,
    CONSTRAINT TourBookingTour
                        foreign key (TourID)
                        references Tour(TourID),
    CONSTRAINT TourBookingUser
                        foreign key (UserName)
                        references users(UserName)
);

CREATE TABLE FlightBooking (
    FlightBookingID serial not null primary key ,
    UserName int null,
    FlightNumber varchar(5),
    BookingTime timestamp,
    PaymentMethod text,
    CONSTRAINT FlightBookingUser
                           foreign key (UserName)
                           references users(UserName),
    CONSTRAINT FlightBookingFlight
                           foreign key (FlightNumber)
                           references Flight(FlightNumber)
);


CREATE TABLE HotelBooking (
    HotelBookingID serial not null primary key ,
    UserName int null,
    HotelID varchar(5),
    FromDate timestamp,
    ToDate timestamp,
    PaymenMethod text,
    NumberOfPersons Int,
    PeopleDetails text null,
    AmountPaid int null,
    CONSTRAINT HotelBookingUser
                          foreign key (UserName)
                          references users(UserName),
    CONSTRAINT HotelBookingHotel
                          foreign key (HotelID)
                          references Hotel(HotelID)
);


CREATE TABLE CabAssigns (
    ReportTime timestamp not null ,
    CabID varchar(5),
    TourBookingID int,
    CONSTRAINT CabAssignsTour
                        foreign key (TourBookingID)
                        references TourBooking(TourBookingID),
    CONSTRAINT CabAssignsCab
                        foreign key (CabID)
                        references Cab(CabID)
);



CREATE TABLE GuideAssigns (
  GuideID varchar(5) null ,
  TourBookingID int,
  ReportTime timestamp not null ,
  CONSTRAINT GuideAssignsTour
                        foreign key (TourBookingID)
                        references TourBooking(TourBookingID),
    CONSTRAINT CabAssignsGuide
                        foreign key (GuideID)
                        references TourGuide(GuideID)
);
