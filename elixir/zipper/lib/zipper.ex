defmodule Zipper do
  @type t :: BinTree.t

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    { bin_tree, :top }
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree({bit_tree, :top}) do
    bit_tree
  end
  def to_tree(el) do
    el |> up |> to_tree
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value({bin_tree, _}) do
    Map.get(bin_tree, :value)
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left({%{left: bin_tree}, _}) when is_nil(bin_tree), do: nil
  def left({bin_tree, trail}) do
    {bin_tree.left, {:left, bin_tree, trail}}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right({%{right: bin_tree}, _}) when is_nil(bin_tree), do: nil
  def right({bin_tree, trail}) do
    {bin_tree.right, {:right, bin_tree, trail}}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up({_, :top}) do
    nil
  end
  def up({_, {_, parent, trail}}) do
    {parent, trail}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value({focus, :top}, value) do
    {%{focus | value: value}, :top}
  end
  def set_value({focus, trail}, value) do
    focus = %{ focus | value: value}
    {focus, update_trail(focus, trail)}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left({focus, :top}, left) do
    {%{focus | left: left}, :top}
  end
  def set_left({current_node, trail}, left) do
    focus = %{ current_node | left: left}
    {focus, update_trail(focus, trail)}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right({focus, :top}, right) do
    {%{focus | right: right}, :top}
  end
  def set_right({current_node, trail}, right) do
    focus = %{ current_node | right: right}
    {focus, update_trail(focus, trail)}
  end

  defp update_trail(_, :top), do: :top
  defp update_trail(focus, {direction, parent, trail}) do
    {_, parent} = Map.get_and_update(parent, direction, fn(focus_in_parent) ->
      {focus_in_parent, focus}
    end)
    {direction, parent, update_trail(parent, trail)}
  end
end
