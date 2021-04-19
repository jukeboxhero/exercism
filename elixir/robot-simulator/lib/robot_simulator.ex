defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  @directions [:north, :east, :south, :west]

  defguard valid_position?(position) when is_tuple(position) and tuple_size(position) == 2 and is_integer(elem(position, 0)) and is_integer(elem(position, 1))
  defguard valid_direction?(direction) when direction in @directions

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0,0})
  def create(direction, position) when valid_position?(position) and valid_direction?(direction) do
    %{ direction: direction, position: position }
  end
  def create(_, position) when valid_position?(position) == false, do: { :error, "invalid position" }
  def create(direction, _) when valid_direction?(direction) == false, do: { :error, "invalid direction" }

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce_while(robot, fn instruction, robot ->
      case perform_action(robot, instruction) do
        {:error, _} = error -> {:halt, error}
        robot -> {:cont, robot}
      end
    end)
  end

  defp perform_action(robot, instruction) do
    case instruction do
      "R" -> turn_right(robot)
      "L" -> turn_left(robot)
      "A" -> advance(robot)
      _   -> { :error, "invalid instruction" }
    end
  end

  defp turn_left(robot) do
    current_dir_index = Enum.find_index(@directions, fn x -> x == robot[:direction] end)
    current_dir_index = if (current_dir_index < 0) do
      length(@directions) - 1
    else
      current_dir_index - 1
    end
    %{robot | direction: Enum.at(@directions, current_dir_index)}
  end

  defp turn_right(robot) do
    current_dir_index = Enum.find_index(@directions, fn x -> x == robot[:direction] end)
    current_dir_index = if (current_dir_index + 1 > length(@directions) - 1) do
      0
    else
      current_dir_index + 1
    end

    %{robot | direction: Enum.at(@directions, current_dir_index)}
  end

  defp advance(robot) do
    {x, y} = robot[:position]
    pos = case robot[:direction] do
      :east -> {x+1, y}
      :west -> {x-1, y}
      :north-> {x, y+1}
      :south-> {x, y-1}
    end
    %{robot | position: pos}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    %{ direction: dir, position: _ } = robot
    dir
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    %{ direction: _, position: pos } = robot
    pos
  end
end
