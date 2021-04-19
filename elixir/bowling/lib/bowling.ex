defmodule Bowling do
  @total_pins 10

  defguard spare?(a, b) when a + b == 10
  defguard strike?(a) when a == 10

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %{ frames: List.duplicate([], 10), round: 0}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  def roll(game, score) do
    try do
      game
        |> validate_input(score)
        |> add_roll_to_frames(score)
        |> calculate_round
    catch
      :negative_roll -> {:error, "Negative roll is invalid"}
      :pin_count_exceeded -> {:error, "Pin count exceeds pins on the lane"}
      :game_over -> {:error, "Cannot roll after game is over"}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(game) do
    if game_over?(game), do: sum_frames(game.frames), else: {:error, "Score cannot be taken until the end of the game"}
  end

  def current_frame(%{frames: frames, round: round}), do: Enum.at(frames, round)

  defp game_over?(game) do
    on_last_round?(game) && completed_final_frame?(game)
  end

  defp sum_frames([]), do: 0
  defp sum_frames([[a]|t]) when strike?(a), do: calc_strike([a],t) + sum_frames(t)
  defp sum_frames([[a,b]|t]) when spare?(a,b), do: calc_spare([a,b],t) + sum_frames(t)
  defp sum_frames([h|t]), do: Enum.sum(h) + sum_frames(t)

  defp add_roll_to_frames(%{frames: frames, round: round}, roll) do
    %{
      frames: List.replace_at(frames, round, Enum.at(frames, round) ++ [roll]),
      round: round
    }
  end

  defp calculate_round(%{frames: f, round: r}) when r == 9, do: %{ frames: f, round: r}
  defp calculate_round(game) do
    if length(current_frame(game)) == 2 || strike?(List.first(current_frame(game))) do
      %{ game | round: game.round + 1}
    else
      game
    end
  end

  defp calc_spare(h,t) do
    t
      |> List.first
      |> List.first
      |> Kernel.+(Enum.sum(h))
  end

  defp calc_strike([h],[[a,b,_]]), do: h + a + b
  defp calc_strike(h,t) do
    if t && length(List.first(t)) == 1 do
      t
        |> Enum.at(1)
        |> List.first
        |> Kernel.+(@total_pins)
        |> Kernel.+(@total_pins)
    else
      t
        |> List.first
        |> Enum.sum
        |> Kernel.+(Enum.sum(h))
    end
  end

  defp validate_input(game, score) do
    last_frame = List.insert_at(current_frame(game), -1, score)

    cond do
      game_over?(game)                            -> throw :game_over
      score < 0                                   -> throw :negative_roll
      score > @total_pins                         -> throw :pin_count_exceeded
      invalid_roll?(last_frame)                   -> throw :pin_count_exceeded
      last_round_exceeds_pin_count?(game, score)  -> throw :pin_count_exceeded
      true -> game
    end
  end

  defp on_last_round?(%{round: round}), do: round == 9

  defp completed_final_frame?(game) do
    cond do
      length(current_frame(game)) == 2 && (Enum.sum(current_frame(game)) < @total_pins) -> true
      length(current_frame(game)) > 2 -> true
      true -> false
    end
  end

  defp last_round_exceeds_pin_count?(game, score) do
    current_frame = current_frame(game) |> List.insert_at(-1, score)
    on_last_round?(game) && (sum_of_final_frame_over_limit?(current_frame) || invalid_final_strike?(game, score))
  end

  defp sum_of_final_frame_over_limit?([]), do: false
  defp sum_of_final_frame_over_limit?([a]), do: a > @total_pins
  defp sum_of_final_frame_over_limit?([@total_pins,_]), do: false
  defp sum_of_final_frame_over_limit?([a,b]), do: a + b > @total_pins
  defp sum_of_final_frame_over_limit?([a, b, c]) do
    if (strike?(a)), do: invalid_roll?([b,c]), else: invalid_roll?([a,b])
  end

  defp invalid_final_strike?(game, score) do
    last_frame = current_frame(game) |> List.insert_at(-1, score)
    (Enum.at(last_frame, -1) == @total_pins) && (Enum.sum(Enum.take(last_frame, 2)) < @total_pins)
  end

  defp invalid_roll?([_]), do: false
  defp invalid_roll?([a,b]) do
    [a, b]
      |> Enum.filter(&(&1 < @total_pins))
      |> Enum.sum
      |> Kernel.>(@total_pins)
  end
  defp invalid_roll?([a,b,c]) do
    c == @total_pins && Enum.any?([a,b,c], &(&1 < @total_pins) && a + b > @total_pins)
  end
end
