defmodule MyList do
	def positives([]) do
		[]
	end

	def positives(list) do
		[head | tail] = list
		if head >= 0 do
			[head | positives(tail)]
		else
			positives(tail)
		end	
	end

	def positives_tr(list) do
		positives_tr_h(list, [])
	end
	
	defp positives_tr_h([], acc) do
		acc
	end

	defp positives_tr_h(list, acc) do
		[head | tail] = list
		if head >= 0 do
			positives_tr_h(tail, [acc | head])
		else
			positives_tr_h(tail, acc)
		end
	end
end
