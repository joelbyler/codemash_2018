defmodule CodemashCli.ExtractMap do

  def extract_from_body(map) do
    {:ok, body} = map

    # Enum.map(body, fn(x) -> extract_article(x) |> wrap(80) end)
    Enum.map(body, fn x -> extract_article(x) end)
  end

  def extract_article(session) do
    """
    #{get_in(session, ["Title"])}
    #{String.duplicate("- ", 40)}
    #{get_in(session, ["SessionStartTime"])}
    #{String.duplicate("- ", 40)}
    #{get_in(session, ["Abstract"])}
    #{String.duplicate("=", 80)}
    """
  end

  def wrap("", _width) do
    ""
  end

  @doc """
  Given a number, returns trueif the number is even and else otherwise.

  ## Example
    iex> CodemashCli.ExtractMap.wrap("abc def", 3)
    "abc
    def"
    iex> CodemashCli.ExtractMap.wrap("abc def", 9)
    "abc def"
  """
  def wrap(session_description, width) do
    session_description
    |> write_lines(width)
    |> String.trim()
  end

  def write_lines(session_description, width) do
    """
    #{words_under_width(session_description, width)}
    #{words_after_width(session_description, width) |> String.trim()}
    """
  end

  @doc """
  Given a number, returns trueif the number is even and else otherwise.

  ## Example
  iex> CodemashCli.ExtractMap.words_under_width("abc def", 3)
  "abc"
  iex> CodemashCli.ExtractMap.words_under_width("abc def", 9)
  "abc def"
  iex> CodemashCli.ExtractMap.words_under_width("abc def gh", 6)
  "abc"
  iex> CodemashCli.ExtractMap.words_under_width("abc def gh", 10)
  "abc def gh"
  """
  def words_under_width(session_description, width) do
    session_description
    |> String.slice(0..end_of_line(session_description, width))
    |> String.trim()
  end

  @doc """
  Given a number, returns trueif the number is even and else otherwise.

  ## Example
    iex> CodemashCli.ExtractMap.eol("abc def", 3)
    3
    iex> CodemashCli.ExtractMap.eol("abc def asdf", 6)
    3
    iex> CodemashCli.ExtractMap.eol("abc def", 7)
    7
    iex> CodemashCli.ExtractMap.eol("abc def asdf", 9)
    7
    iex> CodemashCli.ExtractMap.eol(String.duplicate("- ", 40), 80)
    80
  """
  def eol(session_description, width) do
    session_description =
      session_description
      |> String.replace("\r", "\r\n")
      |> String.replace("\n", "\r\n")
      |> String.replace("\n\n", "\n")
      |> String.replace("\r\r", "\r")

    IO.puts("YO")
    IO.puts(session_description)

    end_of_line =
      Regex.run(~r/\s+\S*$/, String.slice(session_description, 0..width), return: :index)

    line_break = to_charlist(session_description) |> :string.chr(?\n)
    line_return = to_charlist(session_description) |> :string.chr(?\r)

    cond do
      String.length(session_description) <= width ->
        String.length(session_description)

      line_break > 0 && line_break <= width ->
        line_break - 1

      line_return > 0 && line_return <= width ->
        line_return - 1

      true ->
        case end_of_line do
          nil -> width
          [{start, _length}] -> start
        end
    end
  end

  @doc """
  Given a number, returns trueif the number is even and else otherwise.

  ## Example
    iex> CodemashCli.ExtractMap.eol("abc def", 3)
    3
    iex> CodemashCli.ExtractMap.eol("abc def asdf", 6)
    3
    iex> CodemashCli.ExtractMap.eol("abc def", 7)
    7
    iex> CodemashCli.ExtractMap.eol("abc def asdf", 9)
    7
    iex> CodemashCli.ExtractMap.eol(String.duplicate("- ", 40), 80)
    80
  """
  def end_of_line(session_description, width) do
    session_description =
      session_description
      |> String.replace("\r", "\r\n")
      |> String.replace("\n", "\r\n")
      |> String.replace("\n\n", "\n")
      |> String.replace("\r\r", "\r")
      |> String.replace("\r\n\r\n", "\r\n")

    end_of_line =
      Regex.run(~r/\\r\\n$/, String.slice(session_description, 0..width), return: :index)

    end_of_width =
      Regex.run(~r/\s+\S*$/, String.slice(session_description, 0..width), return: :index)

    IO.puts(session_description)

    case end_of_line do
      nil ->
        cond do
          String.length(session_description) <= width ->
            String.length(session_description)

          true ->
            case end_of_width do
              nil ->
                width

              [{start, _length}] ->
                start
            end
        end

      [{start, _length}] ->
        start
    end
  end

  @doc """
  Given a number, returns trueif the number is even and else otherwise.

  ## Example
    iex> CodemashCli.ExtractMap.words_after_width("abc def", 3)
    "def"
    iex> CodemashCli.ExtractMap.words_after_width("abc def", 9)
    ""
    iex> CodemashCli.ExtractMap.words_after_width("abc def gh", 6)
    "def gh"
    iex> CodemashCli.ExtractMap.words_after_width("abc def gh", 10)
    ""
  """
  def words_after_width(session_description, width) do
    start_of_line = end_of_line(session_description, width)

    session_description
    |> String.slice(start_of_line..-1)
    |> String.trim()
    |> wrap(width)
  end
end
