defmodule MyRange do
	def range(n1, n2) when n1 > n2 do
		[]
	end 

	def range(n1, n2) do
		[n1 | range(n1 + 1, n2)]
	end
end
