function calc(...)
    return string.format("")
end

function equals(x, y, eps)
    local abs = math.abs(x-y)
    return abs <= eps;
end

function length(x, y, z)
    return math.sqrt((x)^2 + (y)^2 + (z)^2)
end
