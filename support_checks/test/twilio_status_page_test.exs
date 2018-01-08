defmodule TwilioStatusPageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "check latest pusher status status" do
    navigate_to("https://status.twilio.com/")

    status_text = find_element_text_with_fallback(:class, "page-status", "incident-title")

    assert(status_text == "All Systems Operational")
  end

  defp find_element_text_with_fallback(strategy, selector1, selector2) do
    case search_element(strategy, selector1) do
      {:ok, element} -> element
      {:error, _} -> find_element(strategy, selector2)
    end
    |> visible_text
    |> String.trim()
  end
end
