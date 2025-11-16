CACHED_TABLE = {}
local cachefunctions = setmetatable({}, {
    __call = function(self)

        self.set = function(key, value)
            if type(value) == 'string' then value = json.decode(value) end
            dp('CACHED ', key)
            cache[key] = value
            CACHED_TABLE[key] = value
            return self
        end

        self.get = function(key)
            return cache[key]
        end

        return self
    end
})

cache = cachefunctions()