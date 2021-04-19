defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    items =
      replace_special_characters(sentence)
      |> String.downcase
      |> String.split(" ")
      |> remove_blank_entries
    count_instance(items, %{})
  end

  defp count_instance([], out), do: out
  defp count_instance(arr, out) do
    [h | t] = arr
    Enum.reject(t, fn x -> x == h end )
     |> count_instance(Map.put(out, h, Enum.count(arr, &(&1 == h))))
  end

  defp replace_special_characters(str)do
    String.replace(str, ~r/[^[:alnum:]-]/u, " ")
  end

  defp remove_blank_entries(arr) do
    Enum.filter(arr, &(!(&1 == nil || String.length(String.trim(&1)) == 0)))
  end
end
