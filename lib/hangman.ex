defmodule Hangman do
  @moduledoc """
  The famous Hangman game 
  """
  use Agent

  alias Hangman.GameLogic
  alias Hangman.State
  alias Hangman.View
  alias Hangman.Goal

  @doc """
  Starts the game 
  """
  def start_link(name) when is_atom(name) do
    Agent.start_link(
      fn ->
        Goal.generate() |> State.new()
      end,
      name: name
    )
  end

  @doc """
  Lets the user to take a guess

  ## Examples

      iex> {_word, state} = Hangman.start_game()
      iex> Hangman.take_a_guess("a", state) |> elem(0)
      "_a___a_"

  """
  def take_a_guess(player, letter) do
    new_state =
      Agent.get_and_update(player, fn state ->
        new_state =
          letter
          |> String.downcase()
          |> GameLogic.guess(state)

        {new_state, new_state}
      end)

    View.format_response(new_state)
  end

  def stop(player) when is_atom(player), do: Agent.stop(player)
end
