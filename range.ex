defmodule MyRange do
	def range(n1, n2) when n1 > n2 do
		[]
	end 

	def range(n1, n2) do
		[n1 | range(n1 + 1, n2)]
	end

	def range_tr(n1, n2) do
		range_tr_h(n1, n2, [])
	end

	defp range_tr_h(n1, n2, acc) when n1 > n2 do
		acc
	end

	defp range_tr_h(n1, n2, acc) do
		range_tr_h(n1, n2 - 1, [n2 | acc])	
	end
end
