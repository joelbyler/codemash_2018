defmodule CodemashCli.ExtractMap do

  def extract_from_body(map) do
    {:ok, body} = map

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
end
