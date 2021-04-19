#[derive(Debug)]
pub struct Duration {
    seconds: u64
}

impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        return Self { seconds: s };
    }
}

const EARTH_YEAR_IN_SECONDS: f64 = 31_557_600_f64;

pub trait Planet {
    const ORBITAL_PERIOD: f64;

    fn years_during(d: &Duration) -> f64 {
        (d.seconds as f64 / EARTH_YEAR_IN_SECONDS) / Self::ORBITAL_PERIOD
    }
}

macro_rules! orbital {
    ($planet:ident, $period:expr) => {
        pub struct $planet; impl Planet for $planet {
            const ORBITAL_PERIOD: f64 = $period;
        }
    }
}

orbital!(Mercury, 0.2408467);
orbital!(Venus, 0.61519726);
orbital!(Earth, 1.0);
orbital!(Mars, 1.8808158);
orbital!(Jupiter, 11.862615);
orbital!(Saturn, 29.447498);
orbital!(Uranus, 84.016846);
orbital!(Neptune, 164.79132);
