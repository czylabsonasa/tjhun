
# Ismétlés-iteráció

Ismétlés=Bizonyos utasítás-csoportok ismételt végrehajtása. 

## ```while```
A faktoriális függvényt megvalósíthatjuk 
a következőképpen is, a ```while``` utasítással:


```julia
function fact(n)
  res=1
  i=2
  while i<=n # true/false logikai feltétel
    res*=i
    i+=1
  end
  res
end
fact.(1:4)

```




    4-element Array{Int64,1}:
      1
      2
      6
     24



Itt most alulról, a lenti végétől építjük fel a faktoriálist. $1!=1$ már ki van számolva. <br>
Ha ```while``` (fej) utáni logikai kifejezés értéke igaz, akkor a törzsben levő utasítások végrehajtódnak, <br>
majd újra a fejben levő feltétel vizsgálata következik. Minden $i<=n$ vizsgálatkor a $res=(i-1)!$, ez a ciklusunk <br> invariánsa, ezért működik jól. <br>

A ```visszaSzámol``` ismétléses változata:


```julia
function visszaSzámol(n)
    while n>0
      print(n, " ")
      n-=1
    end
    println("Bumm!")
end
visszaSzámol(5)
```

    5 4 3 2 1 Bumm!


Összefoglalva:<br>
```julia
while kifejezés(feltétel)
  törzs 
end
```
Amíg a kifejezés igaz, addig a törzs végrhajtódik (kiértékelődik).
1. Ha a feltétel mindig hamis, a torzs egyszer sem hajtódik végre.
1. Ha a törzs egyszer végrhajtódik és a feltétel értékére a törzs <br>
   végrehajtása nincs hatással akkor (elvileg) végtelen ciklussal találkoztunk.

Azt hogy a feltétel véges sok lépés (törzs kiértékelés) után hamis lesz vagy sem, <br>
nem mindig könnyű eldönteni. Például a [Collatz](https://en.wikipedia.org/wiki/Collatz_conjecture)-féle 
probléma esetén, máig sem tudjuk hogy egy bizonyos ciklus megáll vagy sem minden inputra.


```julia
function Collatz(n)
  while n != 1
    println(n)
    n= if mod(n,2)==0 div(n,2) else 3*n+1 end
  end
end
Collatz(6)
```

    6
    3
    10
    5
    16
    8
    4
    2


### ```break```

Néha hamarabb abba akarjuk hagyni az ismétlést, mintsem hogy kivárnánk míg a feltétel hamissá válik.<br>
Például egy $n$ szám prím mivoltát tesztelve, 2 és n-1 közötti $d$ számokat választunk és megnézzük osztja-e<br>
$d$ az $n$-et. Ha osztja, akkor tudjuk hogy $n$ nem prím, így kiléphetünk a cikklusból:


```julia
function isPrime(n)
  if n<3 return n==2 end
  ans=true
  d=2
  while d<n
    if n%d==0
      ans=false
      break
    end
    d+=1
  end
  ans
end
isPrime.(1:7)
```




    7-element BitArray{1}:
     false
      true
      true
     false
      true
     false
      true



Használata néha elkerülhető:



```julia
function isPrime(n)
  if n<3 return n==2 end
  ans=true
  d=2
  while d<n && (ans=(n%d>0))
    d+=1
  end
  ans
end
isPrime.(1:7)
```




    7-element BitArray{1}:
     false
      true
      true
     false
      true
     false
      true



### ```continue```

Néha a törzs egyes részeit at akarjuk ugrani bizonyos feltételek esetén. Például: írjuk ki a $2,3,5$ közül <br>
egyikkel osztható számokat egy bizonyos határig.



```julia
function számok(n)
  k=0
  while k<=n
    k+=1
    if k%2==0 || k%3==0 || k%5==0 continue end
    print(k," ")
  end
end
számok(100)
```

    1 7 11 13 17 19 23 29 31 37 41 43 47 49 53 59 61 67 71 73 77 79 83 89 91 97 101 


```julia

```
