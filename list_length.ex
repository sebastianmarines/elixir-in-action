defmodule ListLen do
	def list_len(list) do
		calculate_len(list, 0)			
	end
	
	defp calculate_len([], len) do
		len
	end
	
	defp calculate_len(list, len) do
		[head | tail] = list
		calculate_len(tail, len + 1)
	end
end
