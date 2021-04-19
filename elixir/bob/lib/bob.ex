defmodule Bob do
  def hey(input) do
    cond do
      empty?(input)                    -> "Fine. Be that way!"
      question?(input) && yell?(input) -> "Calm down, I know what I'm doing!"
      question?(input)                 -> "Sure."
      yell?(input)                     -> "Whoa, chill out!"
      true                             -> "Whatever."
    end
  end

  defp empty?(str) do
    String.strip(str) == ""
  end

  defp question?(str) do
    str = String.trim(str)
    String.at(str, String.length(str)-1) == "?"
  end

  defp yell?(str) do
    String.upcase(str) == str && String.downcase(str) != str
  end
end
