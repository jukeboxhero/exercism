const gigaInMilliseconds = 1 * Math.pow(10, 12);

export const gigasecond = (date) => {
  const milliseconds = date.getTime();
  return new Date(milliseconds + gigaInMilliseconds);
};
