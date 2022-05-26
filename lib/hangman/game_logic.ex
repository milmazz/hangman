defmodule Hangman.GameLogic do
  @moduledoc """
  Main logic for the game
  """

  alias Hangman.State

  @doc """
  Returns the game state after the user takes a guess
  """
  def guess(letter, %State{} = state) do
    %{goal: goal, matches: matches, misses: misses, limit: limit} = state

    if MapSet.member?(goal, letter) do
      matches = MapSet.put(matches, letter)
      completed? = MapSet.equal?(goal, matches)
      %{state | matches: matches, completed?: completed?}
    else
      %{state | misses: MapSet.put(misses, letter), limit: limit - 1}
    end
  end
end
