function makeFun()
  mset=Set('a':'z')
  function isGood(s)
	  for c in s
      if !(c in mset)
        return false
  	  end
    end
    true
  end
end

good=makeFun()
d=Dict{String,String}()
for li in eachline("words")
  if good(li)
    cli=string(sort(collect(li)))
    d[li]=cli
  end
end

function revDict(d)
  rd=Dict()
  for (k,dk) in d
    rd[dk]=push!(get(rd,dk,[]),k)
  end
  rd
end  

for (k,v) in revDict(d)
  if length(v)>5
    println(v)
  end
end
