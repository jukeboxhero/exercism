const CODON_MAP = {
  "AUG": "Methionine",
  "UUU": "Phenylalanine",
  "UUC": "Phenylalanine",
  "UUA": "Leucine",
  "UUG": "Leucine",
  "UCU": "Serine",
  "UCC": "Serine",
  "UCA": "Serine",
  "UCG": "Serine",
  "UAU": "Tyrosine",
  "UAC": "Tyrosine",
  "UGU": "Cysteine",
  "UGC": "Cysteine",
  "UGG": "Tryptophan",
  "UAA": "STOP",
  "UAG": "STOP",
  "UGA": "STOP"
}

export const translate = (rna) => {
  if (!rna) { return [] }

  // split codons into 3s and map to proteins
  let codons = rna.match(/.{1,3}/g);
  let proteins = codons.map((c) => CODON_MAP[c]);

  // if any undefined elements exist, we raise an error
  if (proteins.includes(undefined)) {
    throw new Error('Invalid codon');
  }

  // cut array off at first STOP instance
  let stop_index = proteins.indexOf("STOP");
  stop_index = stop_index > -1 ? stop_index : undefined;
  proteins = proteins.slice(0, stop_index);

  return proteins;
};
