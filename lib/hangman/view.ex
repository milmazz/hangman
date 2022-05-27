defmodule Hangman.View do
  @moduledoc """
  Presentation layer for the Hangman game
  """

  alias Hangman.State

  @doc """
  Returns a human-friendly response
  """
  def format_response(%State{limit: limit, completed?: false} = state) when limit > 0 do
    mask_word(state) <> ". Te quedan #{limit} intentos."
  end

  def format_response(%State{limit: limit, word: word} = _state) when limit > 0 do
    "You won, word was: #{word}"
  end

  def format_response(%State{word: word} = _state) do
    "Game Over, word was: #{word}"
  end

  defp mask_word(%{matches: matches, word: word, mask: mask} = _state) do
    if MapSet.size(matches) > 0 do
      matches = Enum.join(matches)
      String.replace(word, ~r/[^#{matches}]/, mask)
    else
      String.replace(word, ~r/./, mask)
    end
  end
end
