defmodule SecretHandshake do
  use Bitwise, only_operators: true
  @instructions %{16 => :reverse, 8 => "jump", 4 => "close your eyes", 2 => "double blink", 1 => "wink"}
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    map_instructions(code)
      |> check_reverse
  end

  defp check_reverse(list) do
    if (List.last(list) == :reverse) do
      list = List.delete_at(list, length(list)-1)
      Enum.reverse(list)
    else
      list
    end
  end

  defp map_instructions(code) do
    Enum.reduce(@instructions, [], fn { bit, action }, acc ->
      (code &&& bit) |> command_map(action, acc)
      case code &&& bit do
        0 -> acc
        _ -> acc ++ [action]
      end
    end)
  end

  defp command_map(0, _, acc), do: acc
  defp command_map(_, action, acc), do: acc ++ [action]
end
