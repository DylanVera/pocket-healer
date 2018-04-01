Queue = class{
	init = function(self)
		self.first = 0
		self.last = -1
	end
}

function Queue:pushLeft(value)
	local first = self.first - 1
	self.first = first
	self[first] = value
end

function Queue:pushRight(value)
	local last = self.last + 1
	self.last = last
	self[last] = value
end

function Queue:popLeft ()
	local first = self.first
	if first > self.last then error("list is empty") end
	local value = self[first]
	self[first] = nil        -- to allow garbage collection
	self.first = first + 1
	return value
end

function Queue:popRight()
	local last = self.last
	if self.first > last then error("list is empty") end
	local value = self[last]
	self[last] = nil         -- to allow garbage collection
	self.last = last - 1
	return value
end

function Queue:isEmpty()
	return self.first > self.last
end