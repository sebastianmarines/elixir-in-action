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
end
