defmodule PusherStatusPageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "check latest pusher status status" do
    navigate_to("https://status.pusher.com/")

    latest_status_text =
      find_element(:class, "page-status")
      |> visible_text
      |> String.trim()

    assert(latest_status_text == "All Systems Operational")
  end
end
