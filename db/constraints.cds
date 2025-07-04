using {sap.fe.cap.travel as my} from './schema';

annotate my.Travel with @assert.constraint.beginAfterToday: {
    condition : (BeginDate > $now),
    parameters: [
        (BeginDate),
        (Date($now))
    ],
    message   : 'error.travel.date.past',
    targets   : [(BeginDate)]
};

annotate my.Travel : EndDate with @assert.constraint.beginBeforeEndDate: {
    condition : (BeginDate <= EndDate),
    message   : 'error.travel.date.before',
    parameters: {
        BeginDate: (BeginDate),
        EndDate: (EndDate),
    }
};

annotate my.Booking : FlightDate with @assert.constraint.flightDate: {
    condition: (FlightDate between to_Travel.BeginDate and to_Travel.EndDate),
    message: 'error.flight.date.range',
    parameters: [
        (to_Travel.BeginDate),
        (to_Travel.EndDate),
        (to_Travel.TravelID)
    ]
} ;
