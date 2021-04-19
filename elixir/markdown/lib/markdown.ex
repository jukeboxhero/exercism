defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    String.split(markdown, "\n")
      |> Enum.map_join(fn line -> process(line) end)
      |> wrap_list_elements
  end

  defp process(line) do
    cond do
      String.starts_with?(line, "#") ->
        line
          |> parse_header_md_level
          |> enclose_with_header_tag
      String.starts_with?(line, "*") -> parse_list_md_level(line)
      true ->
        line
          |> String.split
          |> enclose_with_paragraph_tag
    end
  end

  defp parse_header_md_level(line) do
    [h | t] = String.split(line)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(line) do
    "* " <> rest = line
    words = String.split(rest)
    "<li>" <> join_words_with_tags(words) <> "</li>"
  end

  defp enclose_with_header_tag({md_level, text}) do
    "<h" <> md_level <> ">" <> text <> "</h" <> md_level <> ">"
  end

  defp enclose_with_paragraph_tag(words) do
    "<p>#{join_words_with_tags(words)}</p>"
  end

  defp join_words_with_tags(words) do
    Enum.map(words, fn word -> replace_md_with_tag(word) end)
      |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
      |> format_markdown
  end

  defp format_markdown(word) do
    word
      |> String.replace_prefix("__", "<strong>")
      |> String.replace_prefix("_", "<em>")
      |> String.replace_suffix("__", "</strong>")
      |> String.replace_suffix("_", "</em>")
  end

  defp wrap_list_elements(line) do
    line
      |> String.replace("<li>", "<ul><li>", global: false)
      |> String.replace_suffix("</li>", "</li></ul>")
  end
end
