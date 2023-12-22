function sumvect(vect::Vector, ind=1::Int, s=0::Int)
    if ind > length(vect)
        return(s)
    else
        sumvect(vect, ind+1, s+vect[ind])
    end
end

v = [1, 2, 44, 45]
print(sumvect(v))

        
