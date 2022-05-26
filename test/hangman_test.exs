defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  defmodule TestGenerator do
    @behaviour Hangman.Goal.Api

    def generate, do: "hangman"
  end

  describe "take_a_guess/2" do
    setup do
      {"_______", state} = Hangman.start_game()

      %{state: state}
    end

    test "announces when the user wins", %{state: state} do
      assert {"h______", state} = Hangman.take_a_guess("h", state)
      {result, state} = check(["a", "n", "g", "m"], state)
      assert "You won, word was: hangman" == result
      assert state.completed?
    end

    test "announces when the user loses", %{state: state} do
      assert {"_______", state} = Hangman.take_a_guess("z", %{state | limit: 2})
      assert {"Game Over, word was: hangman", state} = Hangman.take_a_guess("q", state)
      refute state.completed?
    end
  end

  defp check(attempts, state) do
    Enum.reduce(attempts, {"", state}, fn letter, {_, state} ->
      Hangman.take_a_guess(letter, state)
    end)
  end
end
