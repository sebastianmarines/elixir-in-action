defmodule MyFile do
  defp filtered_lines(path) do
    path
    |> File.stream!
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  def large_lines!(path) do
    path
    |> filtered_lines
    |> Enum.filter(&(String.length(&1) > 80))
  end

  def line_lengths!(path) do
    path
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&String.length/1)
  end

  def longest_line_length!(path) do
    path
    |> filtered_lines
    |> Stream.map(&String.length/1)
    |> Enum.max
  end
end