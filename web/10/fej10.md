
# Tömbök

Az egyik leggyakrabban használt szerkezet a programozásban. Értékek **sorozat**a. **Mutábilis**, azaz 
létrehozás után a benne lvő értékek megváltoztathatók. Inhomogén is lehet, azaz az értékek nem feltétlen azonos típusuak.


## Létrehozásuk
A legegyszerűbb esetben ```[``` és ```]``` zárójelek közötti felsorolással hozzuk létre:


```julia
számok1=[1,2,3,4]
számok2=[1,2,3,"négy"]
számok3=[1,2,3,"négy",[5,6,Inf]]
X=[]                             # üres tömb
```




    0-element Array{Any,1}



## A tömb egy érték sorozat, mely változtatható

A tömbök tehát tetszőleges elemeket tartalmazhatnak, így ha tömböt teszünk egy tömbbe azt mondjuk beleágyaztuk.<br>
A benne levő elemeknek **sorrend**je van. Az elemeket a ```[]``` operátorral érjuk el:


```julia
println(typeof(számok1))
println(számok1[3])
számok1[3]=33
println(számok1[3])
számok1[3]=3           # visszaállít
# számok1[3]="harminchárom"       # hiba, a definíciókor csak egészek voltak a tömbbe
#
println(typeof(számok2))
számok2[4]="four"
println(számok2[4])
#
println(typeof(számok3))
println(typeof(számok3[5]))
#
println(typeof(X))
#
println(length(számok1))
println(length(számok2))
println(length(számok3))
println(length(X))
# 
println(1 ∈ számok1)
println(11 ∈ számok2)
println("négy" ∈ számok3)
println(4 ∈ számok3)
```

    Array{Int64,1}
    3
    33
    Array{Any,1}
    four
    Array{Any,1}
    Array{Float64,1}
    Array{Any,1}
    4
    4
    5
    0
    true
    false
    true
    false


>1. Bár inhomogének is lehetnek, ha létrehozáskor egyféle az elemek típusa, akkor nem változtatható meg. (kivéve az 
üres tömb) <br>
>1. A ```length``` és az ∈ ugyanúgy használható mint sztringeknél


## A tömb bejárása


```julia
for val in számok1
  println(val)
end
# vagy
for i in 1:length(számok1)
  println(számok1[i])
end
# vagy
for i in eachindex(számok1)
  println(számok1[i])
end

```

    1
    2
    3
    4
    1
    2
    3
    4
    1
    2
    3
    4


## Szeletek, résztömbök

A három legegyszerűbb módja résztöm létrehozásának:
>1. ```UnitRange``` 
>1. Index tömb 
>1. Logikai értékek tömbje

Lásd a következő példát:


```julia
páros=számok1[2:2:end]
csakÚgy1=számok1[[1,4]]
csakÚgy2=számok1[[true,false,false,true]]
```




    2-element Array{Int64,1}:
     1
     4



## Értékadás

>1. Ha az értékadás **jobb**oldalán egy módosítatlan (nincs szelet szerkezet) tömb-név szerepel, akkor a baloldali név egy újabb kötést hoz létre <br>
a jobboldali elemsorozatra, azaz **referencia** nem másolás van. 
>1. Ha résztömb, szelet szerkezet van a **jobb**oldalon, akkor **másolás** történik.
>1. Ha szelet szerkezet van a **bal**oldalon, akkor ez referenciaként viselkedik, tehát egyszerre több helyen módosíthatjuk


```julia
másik=számok
másik[1]=-1
println(számok[1])
számok1[1]=1  # visszacsinál
másik=számok1[:]
másik[1]=-1
println(számok1[1])
számok[1:2]=[10,20]
```

    -1
    1





    2-element Array{Int64,1}:
     10
     20



## Tömbkezelők

>1. A ```push!(X, x)``` kiegészíti az ```X``` tömböt az ```x``` elemmel a **végén**. Helyben hajtódik végre.
>1. Az ```append!(X,Y)``` az ``X``` után fűzi az ```Y```-t
>1. A ```sort``` visszaadja valamilyen alapértelmezett összehasonlítás szerint növekvőleg rendezett példányát a 
paraméterül átadott tömbnek. A ```sort!``` helyben végzi el ugyanezt.
>1. A ```sum``` visszaadja a tömb elemeinek összegét, ha értelmezve van.
>1. Mindegyiknél adódhatnak típusproblémák. Pl. mit ```1<"kettő"```-re nincs alapértelmezés. Vagy: ha a tömb típusa 
a definiáláskor már rögzült pl ```Int64```, nem lehet sztringet ```push!```olni bele. Ezek a dolgok mind orvosolhatók.


```julia
push!(számok1,5)
println(számok1)
append!(számok1,számok1)
println(számok1)
# push!(számok1, "tíz")
sort(számok1)
# sort(számok2)
sum(számok1)
```

    [1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 5, 5]
    [1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5, 5, 5]





    310




```julia

```


    MethodError: no method matching isless(::String, ::Int64)
    Closest candidates are:
      isless(!Matched::Missing, ::Any) at missing.jl:66
      isless(!Matched::AbstractFloat, ::Real) at operators.jl:150
      isless(!Matched::Real, ::Real) at operators.jl:338
      ...

    

    Stacktrace:

     [1] lt(::Base.Order.ForwardOrdering, ::String, ::Int64) at ./ordering.jl:49

     [2] sort!(::Array{Any,1}, ::Int64, ::Int64, ::Base.Sort.InsertionSortAlg, ::Base.Order.ForwardOrdering) at ./sort.jl:456

     [3] sort!(::Array{Any,1}, ::Int64, ::Int64, ::Base.Sort.MergeSortAlg, ::Base.Order.ForwardOrdering, ::Array{Any,1}) at ./sort.jl:545

     [4] sort! at ./sort.jl:544 [inlined]

     [5] sort! at ./sort.jl:639 [inlined]

     [6] #sort!#7 at ./sort.jl:699 [inlined]

     [7] sort! at ./sort.jl:687 [inlined]

     [8] #sort#8 at ./sort.jl:747 [inlined]

     [9] sort(::Array{Any,1}) at ./sort.jl:747

     [10] top-level scope at In[301]:1


Az adatmanipuláció 3 fontos eszköze a map, filter és redukció.<br>

## Map

Egy kollekció **minden** elemére egy adott függvényt akarunk alkalmazni, hozzá akarunk rendelni egy jól 
meghatározott elemet: pl. egy stringet nagybetűssé akarunk tenni, egy tömb minden eleméhez 1-et hozzá akarunk adni. 
Ezt **map**-nak nevezzük. <br> 
Ez a következőképpen tehető meg:


```julia
a="alma dió mogyoró"
b=uppercase.(a)
println(b)
c=map(uppercase,a)
println(c)
d=broadcast(uppercase,a)
println(d)
```

    ALMA DIÓ MOGYORÓ
    ALMA DIÓ MOGYORÓ
    ALMA DIÓ MOGYORÓ



```julia
a=[1,2,3,4]
println(a .+ 1)
println(.+(a,1))
println(map((x)->x+1,a))

```

    [2, 3, 4, 5]
    [2, 3, 4, 5]
    [2, 3, 4, 5]


## Filter

Egy kollekció **néhány** elemét ki akarjuk **választani** és elhelyezni őket egy új kollekcióba.
Pl. egy stringből csak a kisbetűket akarjuk leválogatni  egy tömbből csak páratlan számokra van szükségünk.
Az ilyen szerkezeteket **filter**-nek nevezzük.<br>
Ez a következőképpen tehető meg:


```julia
a=[1,2,3,4]
println([v for v in a if v%2== 1])       # comprehension
println(a[a.%2 .== 1])
println(a[rem.(a,2) .== 1])
# sztringeknél kicsit körülményes, sok minden alkalmazható rajtuk ami sima tömbokre igen
a="aAbBcCaAbBcC"
ca=collect(a)                                 # tömböt csinálunk
println(join(ca[map(isuppercase,ca)]))        # egyesítjük a kiválogatott elemeket
println(join([ v for v in ca if isuppercase(v)]))        # egyesítjük a kiválogatott elemeket
        
        
```

    [1, 3]
    [1, 3]
    [1, 3]
    ABCABC
    ABCABC


## Redukció
Egy kollekcióhoz egyetlen értéket akarunk rendelni. Pl. összegezzük a tömb elemeit, megszámoljuk egy sztring kisbetűit.


```julia
a=[1,2,3,4,5]
sum(a)
a="aAbBcCaAbBcC"
ca=collect(a)
sum(islowercase.(ca))      # itt kihasználjuk hogy a true,false=1,0 aritmetikai értékként
```




    6



A ```map,filter és redukció``` hármas a programozás, problémamegoldás folyamatában léten nyomon előfordul.

## Dot szerkezet

A számokat tartalmazó tömbök esetén gyakran szeretnénk egy-egy műveletet elemenként elvégezni az összes elemen. Ezt 
alapesetben ciklus(ok) létrehozásával tesszük meg. Ezt tesszi feleslegessé a ```dot``` azaz ```.```:



```julia
# a=[1,2,3]. ^ 2          # infix
# b=a. + 2
# a=.^([1,2,3], 2)          # prefix
# b=.+(a, 2)
a=map((x)->x*x+2, [1,2,3])   # map
a=broadcast((x)->x*x+2, [1,2,3])   # broadcast
```




    3-element Array{Int64,1}:
      3
      6
     11



## Törlés-beillesztés



```julia
arr=['a','b','c']
splice!(arr,2)       # törli az adott index-nél levő elemet
println(arr)
insert!(arr,2,'b')   # beilleszt
println(arr)
deleteat!(arr,2)       # törli az adott index-nél levő elemet
println(arr)
insert!(arr,2,'b')   # beilleszt
println(arr)
x=pop!(arr)          # elvesz a végéről
println(arr," ",x)
push!(arr,x)        # a végére illeszt
println(arr)
x=popfirst!(arr)     # elvesz az elejéről
println(arr," ",x)
pushfirst!(arr,x)    # az elejére illeszt
println(arr)
```

    ['a', 'c']
    ['a', 'b', 'c']
    ['a', 'c']
    ['a', 'b', 'c']
    ['a', 'b'] c
    ['a', 'b', 'c']
    ['b', 'c'] a
    ['a', 'b', 'c'] a


## Tömbök és sztringek

A sztringek immutábilisek. 
1. Ha módosítható karaktertömbre van szükségünk, ki kell gyűjteni a sztring elemeit: ```collect```
1. Ha egy sztringet részekre akarunk szedni bizonyos határoló-karakter mentén: ```split```
1. A dolgok újraegyesítésére: ```join```



```julia
a="lada szamara"
aa=collect(a)
join(sort!(aa))

println(split(a))
println(split(a,'a'))

join(["asd", "2*2=", 2*2])    # sztringre transzformál majd egyesít
join(["asd", "2*2=", 2*2], ',')    # határoló is megadható
```

    SubString{String}["lada", "szamara"]
    SubString{String}["l", "d", " sz", "m", "r", ""]





    "asd,2*2=,4"



## Objektum, érték, referencia

Amikor egy objektumhoz, értékhez több nevet is hozzákötünk.



```julia
a="banán"
b="banán"
a===b        # ugyanarra azértékre hivatkoznak?
a=[1,2]
b=[1,2]
a===b       # itt nem ugyanaz az objektum, mert a tömb mutábilis
```




    false



Figyeljünk oda a többszörös neveknél bámelyik néven keresztul módosítható az érték:


```julia
a=[1,2,3,4]
b=a
println(b===a)         # most ugyanarra az objektumra (memóriatartalomra) mutatnak
b[1]=0
println(a)
```

    true
    [0, 2, 3, 4]


## Tömbök mint függvény-argumentumok

A tömbök referenciaként kerülnek átadásra, tehát ha a fv. módosítja a tömböt, akkor az a hívás helyén is módosul.


```julia
f(x)=(x[1]=1)    # az értékadás is egy érték
y=[2,3,4]
println(f(y))
println(y)
```

    1
    [1, 3, 4]


### Feladat 
Írjunk egy függvényt mely egy egymásba ágyazott tömbökből álló tömbből egy "sima" tömböt alkot.<br>
```[0,[1, 2],[3]]``` -> ```[0,1,2,3]```



```julia
function bejár(X)
  r=[]
  for x in X
    if typeof(x) <: Number || typeof(x) <: Char
      r=vcat(r,x)
    else
      r=vcat(r,bejár(x))
    end
  end
  r
end
a=[0,[1.1,2],[3.14,4,[[5,1/10]]],"alma"]
bejár(a)
```




    11-element Array{Any,1}:
     0   
     1.1 
     2.0 
     3.14
     4   
     5.0 
     0.1 
      'a'
      'l'
      'm'
      'a'


