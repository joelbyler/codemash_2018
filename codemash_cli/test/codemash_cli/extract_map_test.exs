defmodule CodemashCli.ExtractMapTest do
  use ExUnit.Case
  doctest CodemashCli.ExtractMap

  test "crazy edge case" do
    description =
      "Two years ago at CodeMash we discussed how Erlang was a paradigm shift masquerading as a programming language. Last year we illustrated how fun it is to write. This year we show off one of its most powerful aspects: maintaining a production system.\r\n\r\nErlang (and Elixir, its younger sibling) allow you to not only trace the behavior of a production system, but also to query the data in memory, replace your code on the fly once you've found the problem, and *fix* the data that the old code mishandled, so the system keeps plugging away. Look, ma, no reboots.\r\n\r\nAlso discussed will be other criminally under-appreciated languages with similar features, because really, can you ever have enough magic tricks in your repertoire?\r\n"

    assert "#{CodemashCli.ExtractMap.wrap(description, 80)}\n" ==
             """
             Two years ago at CodeMash we discussed how Erlang was a paradigm shift
             masquerading as a programming language. Last year we illustrated how fun it is
             to write. This year we show off one of its most powerful aspects: maintaining a
             production system.
             Erlang (and Elixir, its younger sibling) allow you to not only trace the
             behavior of a production system, but also to query the data in memory, replace
             your code on the fly once you've found the problem, and *fix* the data that the
             old code mishandled, so the system keeps plugging away. Look, ma, no reboots.
             Also discussed will be other criminally under-appreciated languages with similar
             features, because really, can you ever have enough magic tricks in your
             repertoire?
             """
  end
end
