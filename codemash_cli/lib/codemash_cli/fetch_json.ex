defmodule CodemashCli.JSONFetch do
  def fetch(search_term) do
    speaker_data_url()
    |> HTTPoison.get()
    |> handle_json
    |> filter_for_term(search_term)
  end

  defp speaker_data_url do
    "https://speakers.codemash.org/api/SessionsData?type=json"
  end

  defp filter_for_term(json, search_term) do
    {:ok, body} = json

    {
      :ok,
      Enum.filter(body, fn x ->
        Map.fetch(x, "Abstract")
        |> (fn y ->
              {_, abstract} = y
              abstract
            end).()
        |> String.downcase()
        |> String.contains?(String.downcase(search_term))
      end)
    }
  end

  def handle_json({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  def handle_json({_, %{status_code: _, body: _}}) do
    IO.puts("Something went wrong. Please check your internet connection")
  end
end
