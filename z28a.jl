function nfib(n::Int)
    i1 = 1
    i2 = 1
    for i in range(1, n-2)
        c = i2
        i2 += i1
        i1 = c
    end
    return i2
end
print(nfib(7))

            
        

