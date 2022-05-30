defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  defmodule TestGenerator do
    @behaviour Hangman.Goal.Api

    def generate, do: "hangman"
  end

  describe "take_a_guess/2" do
    setup do
      {:ok, pid} = Hangman.start_link(:player)

      %{pid: pid}
    end

    test "announces when the user wins", %{pid: pid} do
      assert "h______. Te quedan 5 intentos." = Hangman.take_a_guess(pid, "h")
      result = check(["a", "n", "g", "m"], pid)
      assert "You won, word was: hangman" == result
    end

    test "announces when the user loses", %{pid: pid} do
      assert "_______. Te quedan 4 intentos." = Hangman.take_a_guess(pid, "z")
      result = check(["q", "w", "e", "r"], pid)
      assert "Game Over, word was: hangman" == result
    end
  end

  defp check(attempts, pid) do
    Enum.reduce(attempts, "", fn letter, _acc ->
      Hangman.take_a_guess(pid, letter)
    end)
  end
end
