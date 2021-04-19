const TRANSCRIPTION = {
  "G": "C",
  "C": "G",
  "T": "A",
  "A": "U"
}

export const toRna = (strand) => {
  return strand.split('').map((nucleotide) => transcribe(nucleotide)).join('');
};

const transcribe = (nucleotide) => TRANSCRIPTION[nucleotide];
