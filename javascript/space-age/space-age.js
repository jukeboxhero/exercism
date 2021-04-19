const ORBITALS_IN_EARTH_YEARS = {
  "earth": 1.0,
  "mercury": 0.2408467,
  "venus": 0.61519726,
  "mars": 1.8808158,
  "jupiter": 11.862615,
  "saturn": 29.447498,
  "uranus": 84.016846,
  "neptune": 164.79132
}

const EARTH_ORBITAL_IN_SECONDS = 31557600;

export const age = (planetName, ageInSeconds) => {
  let ageInYears = (ageInSeconds / EARTH_ORBITAL_IN_SECONDS);
  let planetYears = (ageInYears / ORBITALS_IN_EARTH_YEARS[planetName]);
  return Math.round(planetYears * 100) / 100;
};
