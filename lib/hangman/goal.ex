defmodule Hangman.Goal do
  @behaviour Hangman.Goal.Api

  def generate do
    client = Application.get_env(:hangman, __MODULE__, Hangman.Goal.DummyGenerator)
    client.generate()
  end
end
