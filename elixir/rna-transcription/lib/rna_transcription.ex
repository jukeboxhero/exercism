defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    convert(dna)
  end

  defp convert([]), do: []
  defp convert([h | t]) do
    rna_char = case h do
      ?G -> ?C
      ?T -> ?A
      ?C -> ?G
      ?A -> ?U
    end
    [ rna_char | convert(t) ]
  end
end
