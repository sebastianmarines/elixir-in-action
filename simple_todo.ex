defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      fn (entry, todo_list_acc) ->
        add_entry(todo_list_acc, entry)
      end
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(
      todo_list.entries,
      todo_list.auto_id,
      entry
    )

    %TodoList{
      todo_list |
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(
         fn {_, entry} -> entry.date == date end
       )
    |> Enum.map(
         fn {_, entry} -> entry end
       )
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error -> todo_list
      {:ok, old_entry} ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{
          todo_list |
          entries: new_entries
        }
    end
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def delete_entry(todo_list, entry_id) do
    todo_list.entries
    |> Stream.filter(
         fn {_, entry} -> entry.id != entry_id end
       )
    |> Enum.map(
         fn {_, entry} -> entry end
       )
  end
end

defmodule TodoList.CsvImporter do
  def import(path) do
    path
    |> read_file
    |> Stream.map(&parse_line(&1))
    |> Stream.map(&create_entry(&1))
    |> TodoList.new
  end

  defp read_file(path) do
    path
    |> File.stream!
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  defp parse_line(line) do
    [date, title] = String.split(line, ",")
    [year, month, day] = parse_date(date)
    {{year, month, day}, title}
  end

  defp parse_date(string_date) do
    string_date
    |> String.split("/")
    |> Enum.map(
         &String.to_integer(&1)
       )
  end

  defp create_entry({{year, month, day}, title}) do
    date = Date.new!(year, month, day)
    %{date: date, title: title}
  end
end