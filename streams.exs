[9, -1, "foo", 25, 49]
|> Stream.filter(&(is_number(&1) and &1 > 0))
|> Stream.map(&{&1, :math.sqrt(&1)})
|> Stream.with_index(1)
|> Enum.each(
     fn ({{input, result}, index}) ->
       IO.puts "#{index}. sqrt(#{input}) = #{result}"
     end
   )
