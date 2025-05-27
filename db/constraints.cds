using {sap.fe.cap.travel as my} from './schema';

annotate my.Travel with @assert.constraint.beginBeforeEndDate: {
    condition : (BeginDate <= EndDate),
    message   : 'error.travel.date.before',
    parameters: [
        (TravelID),
        (EndDate),
        (BeginDate)
    ],
    targets   : [
        (BeginDate),
        (EndDate)
    ]
};

annotate my.Travel : BeginDate with @assert.constraint.beginDateMustBeInFuture: {
    condition : (BeginDate > $now),
    message   : 'error.travel.date.past',
    parameters: [
        (TravelID),
        (BeginDate)
    ]
};

annotate my.Booking : FlightDate with @assert.constraint.flightDate: {
    condition : (FlightDate between to_Travel.BeginDate and to_Travel.EndDate),
    message   : 'FLIGHT_DATE_IN_RANGE',
    parameters: [
        (BookingID),
        (to_Travel.BeginDate),
        (to_Travel.EndDate)
    ]
};

annotate my.Booking : to_Flight with @assert.constraint.freeseats: {
    condition: (to_Flight.OccupiedSeats < to_Flight.MaximumSeats),
    message  : 'no free seats on selected flight'
};