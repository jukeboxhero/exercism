defmodule Forth do
  @opaque evaluator :: %Forth{}
  defstruct stack: [], commands: %{}

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new(), do: %Forth{}

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
    s |> do_parse(ev)
  end

  def do_parse(s, ev) do
    s
      |> parse_operators
      |> cast_integers
      |> evaluate_terms(ev)
  end

  defp parse_operators(s) do
    s |> String.split(~r/[^[[:graph:]]/u, trim: true)
  end

  # empty, return evaluator
  defp evaluate_terms([], ev), do: ev
  # addition
  defp evaluate_terms(["+"| t], ev), do: evaluate_terms(t, add(ev))
  #subtraction
  defp evaluate_terms(["-"| t], ev), do: evaluate_terms(t, subtract(ev))
  #multiplication
  defp evaluate_terms(["*"| t], ev), do: evaluate_terms(t, multiply(ev))
  #Division
  defp evaluate_terms(["/"| t], ev), do: evaluate_terms(t, divide(ev))
  #define word
  defp evaluate_terms([":"| t], ev) do
    { ev, t } = define(ev, t)
    evaluate_terms(t, ev)
  end
  #Commands
  defp evaluate_terms([h | t], ev) when is_binary(h) do
    cond do
      is_custom_command?(ev, h)     -> custom(ev, h, t) |> evaluate_terms(ev)
      String.match?(h, ~r/^DUP$/i)  -> evaluate_terms(t, dup(ev))
      String.match?(h, ~r/^DROP$/i) -> evaluate_terms(t, drop(ev))
      String.match?(h, ~r/^SWAP$/i) -> evaluate_terms(t, swap(ev))
      String.match?(h, ~r/^OVER$/i) -> evaluate_terms(t, over(ev))
      true -> raise Forth.UnknownWord
    end
  end
  # noop
  defp evaluate_terms([h | t], ev) do
    evaluate_terms(t, %{ev | stack: append(ev.stack, h)})
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(ev) do
    ev.stack |> Enum.join(" ")
  end

  defp cast_integers(stack) do
    Enum.map(stack, fn x ->
      if Regex.match?(~r/\d+/, x), do: String.to_integer(x), else: x
    end)
  end

  defp execute_arithmetic(ev, func) do
    {right, stack} = List.pop_at(ev.stack, -1)
    {left, stack} = List.pop_at(stack, -1)

    %{ev| stack: append(stack, func.(left, right))}
  end

  defp is_custom_command?(ev, str) do
    ev.commands |> Map.has_key?(str)
  end

  defp add(ev), do: execute_arithmetic(ev, &(&1 + &2))
  defp subtract(ev), do: execute_arithmetic(ev, &(&1 - &2))
  defp multiply(ev), do: execute_arithmetic(ev, &(&1 * &2))
  defp divide(%{stack: [_, 0 | _]}), do: raise Forth.DivisionByZero
  defp divide(ev), do: execute_arithmetic(ev, &(floor(&1 / &2)))

  defp dup(%{stack: []}), do: raise Forth.StackUnderflow
  defp dup(%{stack: stack, commands: commands}) do
    last = Enum.at(stack, -1)
    %{ stack: append(stack, last), commands: commands }
  end

  defp drop(%{stack: []}), do: raise Forth.StackUnderflow
  defp drop(%{stack: stack, commands: commands}) do
    {_, stack} = List.pop_at(stack, -1)
    %{ stack: stack, commands: commands }
  end

  defp swap(%{stack: []}), do: raise Forth.StackUnderflow
  defp swap(%{stack: [_]}), do: raise Forth.StackUnderflow
  defp swap(%{stack: stack, commands: commands}) do
    {right, stack} = List.pop_at(stack, -1)
    {left, stack} = List.pop_at(stack, -1)
    %{ stack: stack ++ [right, left], commands: commands }
  end

  defp over(%{stack: []}), do: raise Forth.StackUnderflow
  defp over(%{stack: [_]}), do: raise Forth.StackUnderflow
  defp over(%{stack: stack, commands: commands}) do
    %{ stack: append(stack, Enum.at(stack, -2)), commands: commands }
  end

  defp define(ev, input) do
    do_define(ev, input, 0)
  end

  defp do_define(ev, [h | t], 0) do
    do_define(%{ev | commands: Map.put(ev.commands, h, [])}, t, 1, h)
  end
  defp do_define(ev, [";" | t], _, _), do: {ev, t}
  defp do_define(_, _, _, command_name) when is_integer(command_name) do
    raise Forth.InvalidWord
  end
  defp do_define(ev, [h | t], index, command_name) do
    definition = append(Map.get(ev.commands, command_name), h)
    commands = Map.put(ev.commands, command_name, definition)
    do_define(%{ev | commands: commands}, t, index+1, command_name)
  end

  defp custom(ev, h, t) do
    Map.get(ev.commands, h) ++ t
  end

  defp append(list, el) do
    Enum.reverse([el | Enum.reverse(list)])
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
