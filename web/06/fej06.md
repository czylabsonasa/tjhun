
# Függvények, visszatérési értékek

Juliá-ban minden függvénynek van visszatérési értéke, annak is mely nem ad vissza semmit sem.
A függvény egy kifejezés, mely kiértékelődik, ha nincs mit kiértékelni, akkor ```nothing``` 
speciális érték (mely ```Nothing``` típus tagja) rendelődik a kifejezéshez:



```julia
function semmi()
end
show(semmi())
typeof(semmi())

```

    nothing




    Nothing



A ```function,end``` pár zárójelként viselkedik. Az általa képviselt kifejezés értéke alapesetben az<br>
utolsóként kiértékelt rész-kifejezésének az értéke lesz:



```julia
function terület(r)
  1+1==2
  2*2==5
  r^2*pi
end
terület(1)
```




    3.141592653589793



Azt hogy mi legyen az utoljára részkifejezés a ```return```-al tudjuk módosítani:


```julia
function terület(r)
  if r<0 return 0 end
  r^2*pi
end
terület(-1)
```




    0



A ```return```-nal explicit kinyilvánítjuk: ezt és ezt akarjuk visszaadni a hívónak. <br>
Ezt elérhetjük másként is, mivel az ```if-else-end``` is egy kifejezés:


```julia
function terület(r)
  if r<0 0 else r^2*pi end
end
terület(-1)
```




    0



## Lépésenkénti finomítás, kompozíció, logikai függvények

Nagyobb függvények írásánál hasznos elv, ha kiindulva a semmiből, pontosasbban egy homályos vázlatból,<br> újabb és újabb adalékokat hozzáadva, lépésenként tesztelve (kóstolgatva) közelítünk a megoldáshoz.<br>
Példaként nézzük [Héron](https://en.wikipedia.org/wiki/Heron%27s_formula)-féle háromszög-területszámoló függvényt:


```julia
# 0. verzió
function Heron(a,b,c)
end

# 1. verzió
function Heron(a,b,c)
  s=0.5*(a+b+c)
end

# 2. verzió
function Heron(a,b,c)
  s=0.5*(a+b+c)
  sqrt(s*(s-a)*(s-b)*(s-c))
end
println(Heron(1,2,3))
println(Heron(1,1,1))
println(Heron(1,1,3))

```

    0.0
    0.4330127018922193



    DomainError with -2.8125:
    sqrt will only return a complex result if called with a complex argument. Try sqrt(Complex(x)).

    

    Stacktrace:

     [1] throw_complex_domainerror(::Symbol, ::Float64) at ./math.jl:31

     [2] sqrt at ./math.jl:492 [inlined]

     [3] Heron(::Int64, ::Int64, ::Int64) at ./In[13]:13

     [4] top-level scope at In[13]:17


Ez bizony nem jó, mert lehet hogy a 3 adott szám nem alkot háromszöget, és ekkor az ```sqrt```-nek 
negatív számot adunk át. <br> 
Kiderült, hogy szükségünk van egy ```isTriangle``` függvényre. Tudjuk, hogy egy háromszög pontosan <br>
akkor szerkeszthető (létezik) ha bármely két oldalát választva ezek összege nagyobb mint a harmadik. <br>
Ezt kell megfogalmazni az adott nyelven:


```julia
# 0. verzió
function isTriangle(a,b,c)
   # ide kerül egy kifejezés ami pont akkor igaz ha létezik a háromszög
end

# 1. verzió
function isTriangle(a,b,c)
  (a+b>c)&&(a+c>b)&&(b+c>a)
end

println(isTriangle(1,2,3))
println(isTriangle(1,1,1))
println(isTriangle(1,1,3))

```

    false
    true
    false


Ez jónak tűnik. Összekomponálva a félig kész ```Heron```-nal:


```julia
# 3. verzió
function Heron(a,b,c)
  if isTriangle(a,b,c) s=0.5*(a+b+c); sqrt(s*(s-a)*(s-b)*(s-c)) else 0 end
end

```




    Heron (generic function with 1 method)




```julia
println(Heron(1,2,3))
println(Heron(1,1,1))
println(Heron(1,1,3))
println(Heron(1,1,sqrt(2)))

```

    0
    0.4330127018922193
    0
    0.49999999999999983


## Még egy kis rekurzió

Tekintsük az úgynevezett faktoriális függvényt:
\begin{equation}
{\textrm{factorial}(n)=n! =
\begin{cases}
  1& \textrm{if}\  n < 2 \\
  n (n-1)!& \textrm{if}\  n \ge 2
\end{cases}}
\end{equation}
Nagy számokra az értéke a kisebb számokra felvett értékétől függ, azzal definiált. Érezhetjük benne a rekurziót. Próbáljuk meg rekurzív függvényként megvalósítani:



```julia
# 0. verzió
function fact(n)
  # ide kerül a számolás
end

# 1. verzió
function fact(n)
  if n<2 return 1 end
  n*fact(n-1)
end

# 2. verzió
function fact(n)
  if n<2 1 else n*fact(n-1) end
end
fact.(1:5)
fact(2.3)
#fact("három")
```




    2.3



## Típus ellenőrzés

A két utolsó ```fact``` példa mutatja, hogy bár jól működik a függvény egész számokra, egyéb típusok <br>
esetén hibát, vagy hibás eredményt kapunk. Teljessé tehetjük ```fact``` függvényünket ha lekezeljük <br>
a nem egész szám paraméter esetet:


```julia
# 3. verzió
function fact(n)
  if (n isa Int) 
    if n<2 1 else n*fact(n-1) end
  else
    error("egészet várok") 
  end
end

```




    fact (generic function with 1 method)




```julia
x=fact(2.3)
typeof(x)
#fact("három")
```


    egészet várok

    

    Stacktrace:

     [1] error(::String) at ./error.jl:33

     [2] fact(::Float64) at ./In[38]:6

     [3] top-level scope at In[43]:1


Juliá-ban van egy ```prod``` függvény mellyel a ```fact``` reprodukálható:


```julia
fact2(n)=prod(1:n)
fact2.(-11.1)
```




    1.0



## Feladatok


### 1. Fejtsük meg a ```c``` függvény működését:
```julia
function b(z)
    prod = a(z, z)
    println(z, " ", prod)
    prod
end

function a(x, y)
    x = x + 1
    x * y
end

function c(x, y, z)
    total = x + y + z
    square = b(total)^2
    square
end

x = 1
y = x + 1
println(c(x, y+3, x+y))
```

### 2. Írj egy függvényt 
mely egy paraméterül kapott sztringről eldönti hogy [palindrom](https://hu.wikipedia.org/wiki/Palindrom)-e.

### 3. Írj egy függvényt 
mely két paraméterül kapott egészre visszadja a [legnagyobb közös osztó](https://hu.wikipedia.org/wiki/Legnagyobb_k%C3%B6z%C3%B6s_oszt%C3%B3)jukat.

### 4. Írj egy függvényt 
mely két paraméterül kapott $a\ge b$ egészre eldönti hogy $a=b^n$ teljesül-e valamely $n>0$-re.<br> 
(csak egész műveleteket használjunk)
