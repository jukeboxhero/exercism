defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: get_count(l)
  defp get_count([h | t]), do: get_count(t) + 1
  defp get_count([]), do: 0

  @spec reverse(list) :: list
  def reverse(l), do: get_reverse(l, [])
  defp get_reverse([h | t], acc), do: get_reverse(t, [h | acc])
  defp get_reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: for element <- l, do: f.(element)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, func), do: for element <- list, func.(element), do: element

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f), do: do_reduce(l, acc, f)
  defp do_reduce([h | t], acc, f) do
    acc = f.(h, acc)
    do_reduce(t, acc, f)
  end
  defp do_reduce([], acc, _), do: acc

  @spec append(list, list) :: list
  def append(a, b), do: do_append(a, b)
  defp do_append([h | t], b), do: [h | do_append(t, b)]
  defp do_append([], b), do: b

  @spec concat([[any]]) :: [any]
  def concat(ll), do: do_concat(ll)
  defp do_concat([h | t]), do: append(h, do_concat(t))
  defp do_concat([]), do: []
end
