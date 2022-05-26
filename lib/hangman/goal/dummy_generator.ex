defmodule Hangman.Goal.DummyGenerator do
  @behaviour Hangman.Goal.Api

  def generate do
    Enum.random(["hangman", "fortune", "dummy"])
  end
end
