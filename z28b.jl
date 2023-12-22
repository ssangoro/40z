function nfib(n::Int, i1=1::Int, i2=1::Int)
    if n > 2
        c = i2
        nfib(n-1, c, i2+i1)
    else
        return i2
    end
end
print(nfib(7))