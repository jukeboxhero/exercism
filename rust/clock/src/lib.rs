#[derive(Debug, PartialEq)]
pub struct Clock {
    hours: i32,
    minutes: i32
}

const MINUTES_IN_DAY:i32 = 60 * 24;

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let clock_minutes = Clock::total_minutes(hours, minutes);
        let clock_hours = Clock::total_hours_in_minutes(clock_minutes);

        Clock {
            hours: clock_hours % 24,
            minutes: clock_minutes % 60
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        let clock_minutes = Clock::total_minutes(self.hours, self.minutes) + minutes;
        let clock_hours = Clock::total_hours_in_minutes(clock_minutes);

        Clock::new(clock_hours % 24, clock_minutes % 60)
    }

    pub fn to_string(&self) -> String {
        format!("{:02}:{:02}", self.hours, self.minutes)
    }

    fn total_minutes(hours: i32, minutes: i32) -> i32 {
        let total = (hours * 60) + minutes;
        (MINUTES_IN_DAY * 10) + total % MINUTES_IN_DAY
    }

    fn total_hours_in_minutes(minutes: i32) -> i32 {
        minutes / 60
    }
}
