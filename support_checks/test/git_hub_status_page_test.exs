defmodule GitHubStatusPageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "check latest github status" do
    navigate_to("https://status.github.com/messages")

    latest_status = find_all_elements(:class, "message") |> hd
    latest_status_text = find_within_element(latest_status, :class, "title") |> visible_text

    assert(latest_status_text == "All systems reporting at 100%")
  end
end
