d=Dict{String,String}()
for li in eachline("words.eng")
    d[li]=string(sort(collect(li)))
end

function revDict(d)
  rd=Dict()
  for (k,dk) in d
    rd[dk]=push!(get(rd,dk,[]),k)
  end
  rd
end  

for (k,v) in revDict(d)
  if length(v)>2
    println(v)
  end
end
