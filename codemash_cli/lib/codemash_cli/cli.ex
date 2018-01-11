defmodule CodemashCli.CLI do
  def main(args) do
    parse_args(args)
    |> process
  end

  def parse_args(args) do
    parse =
      OptionParser.parse(
        args,
        switches: [help: :boolean],
        aliases: [h: :help]
      )

    case parse do
      {[help: true], _, _} ->
        :help

      {_, [search_term], _} ->
        search_term

      {_, _, _} ->
        :help
    end
  end

  def process(:help) do
    IO.puts("""
    Codemash CLI
    — — — — —
    usage: codemash_cli <search_term>
    example: codemash_cli elixir
    """)
  end

  def process(search_term) do
    CodemashCli.JSONFetch.fetch(search_term)
    |> CodemashCli.ExtractMap.extract_from_body()
    |> string_format
  end

  def string_format(matches) do
    Enum.join(matches, "\n")
    |> String.replace(". ", ". \n")
    |> IO.puts()
  end
end
