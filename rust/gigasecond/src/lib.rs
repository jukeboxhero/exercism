use chrono::{DateTime, Duration, Utc};

// Returns a Utc DateTime one billion seconds after start.
pub fn after(start: DateTime<Utc>) -> DateTime<Utc> {
    let gigasecond_in_milliseconds: i64 = 1000000000;

    return start + Duration::seconds(gigasecond_in_milliseconds);
}
