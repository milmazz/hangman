defmodule Hangman.State do
  def new(word) do
    word = String.downcase(word)
    goal = word |> String.graphemes() |> MapSet.new()

    %{
      word: word,
      goal: goal,
      misses: MapSet.new(),
      matches: MapSet.new(),
      limit: 5,
      mask: "_",
      completed?: false
    }
  end
end
