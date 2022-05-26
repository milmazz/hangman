check = fn attempts ->
  {_, state} = Hangman.start_game()

  Enum.reduce(attempts, state, fn letter, state ->
    {word, state} = Hangman.take_a_guess(letter, state)
    IO.puts(word)
    state
  end)
end

IO.puts("WIN")
check.(["h", "a", "n", "g", "m"])

IO.puts("Game over")
check.(["z", "q", "w", "f", "s"])
