defmodule TwitterExperimentTest do
  use ExUnit.Case
  doctest TwitterExperiment

  test "greets the world" do
    assert TwitterExperiment.hello() == :world
  end
end
