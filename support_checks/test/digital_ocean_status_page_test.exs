defmodule DigitalOceanStatusPageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  setup do
    navigate_to("http://status.digitalocean.com/")
  end

  test "digital ocean spaces are operational" do
    status_group = find_all_elements(:class, "child-components-container") |> hd
    child_statuses = find_all_within_element(status_group, :class, "component-inner-container")

    for child_status <- child_statuses do
      space_name = child_status |> visible_text |> String.trim()

      component_status =
        find_within_element(child_status, :class, "component-status") |> inner_text
        |> String.trim()

      assert(
        component_status == "Operational",
        "The \"#{space_name}\" space currently has a status of \"#{component_status}\""
      )
    end
  end

  test "digital ocean services are operational" do
    status_group = find_all_elements(:class, "child-components-container") |> Enum.take(-1) |> hd
    child_statuses = find_all_within_element(status_group, :class, "component-inner-container")

    for child_status <- child_statuses do
      service_name = child_status |> visible_text |> String.trim()

      component_status =
        find_within_element(child_status, :class, "component-status") |> inner_text
        |> String.trim()

      assert(
        component_status == "Operational",
        "The \"#{service_name}\" service currently has a status of \"#{component_status}\""
      )
    end
  end
end
