local module = {}
local data = nil

function module.registerHooks(host, store)
    for _, fn in ipairs(data.hooks) do
        fn(host, store)
    end
end

function module.bind(moduleData)
    data = moduleData
    return module
end

return module
