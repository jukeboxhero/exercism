defmodule RomanNumerals do
  @numeral_map [M: 1000, CM: 900, D: 500, CD: 400, C: 100, XC: 90, L: 50, XL: 40, X: 10, IX: 9, V: 5, IV: 4, I: 1]
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    parse_integer(number, @numeral_map, []) |> Enum.join
  end

  defp parse_integer(_number, [], acc), do: acc
  defp parse_integer(number, [ { roman_char, divisor } | tail], acc) do
    acc = case floor(number / divisor) do
      x when x > 0 ->
        result = for i <- 0..(x-1), do: roman_char
        (acc ++ result)
      0 -> acc
    end
    parse_integer(rem(number, divisor), tail, acc);
  end
end
