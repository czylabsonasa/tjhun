
# Játék sztringekkel

Szavakkal kapcsolatos feladatokat fogunk megoldani. <br>

### Fájlok olvasása
Töltsük le a [szavak](https://github.com/BenLauwens/ThinkJulia.jl/blob/master/data/words.txt) állományt. 


```julia
wf=open("words.txt")
println(readline(wf))
println(readline(wf))
close(wf)
```

    aa
    aah


Azaz
1. Megnyitjuk az állományt: ```open``` (feltételezzük, hogy létezik a fájl)
1. Sorokat olvasunk belőle: ```readline```
1. Csinálunk valamit az olvasott adatokkal...
1. Bezárjuk az állományt.


### Feladat
Számoljuk meg a legalább $h$ hosszú szavakat és adjuk meg százalékos arányukat.

### Megoldás


```julia
function számol(h,irjam=false)
  wf=open("words.txt")
  m,n=0,0
  for sor in eachline(wf)
    n+=1
    m+=if length(sor)>=h irjam&&println(sor); 1 else 0 end
  end
  close(wf)  
  m,n
end
h=20
m,n=számol(h,true)
println("a szavak $(m*100.0/n) százaléka hosszabb mint $(h-1)")
```

    counterdemonstration
    counterdemonstrations
    counterdemonstrators
    hyperaggressivenesses
    hypersensitivenesses
    microminiaturization
    microminiaturizations
    representativenesses
    a szavak 0.0070293210554525564 százaléka hosszabb mint 19


### Feladat
Számoljuk meg a legalább $h$ hosszú szavakat melyek egy adott karaktert nem tartalmaznak és adjuk meg százalékos arányukat.

### Megoldás


```julia
function számol(h,c,irjam=false)
  wf=open("words.txt")
  m,n=0,0
  for sor in eachline(wf)
    n+=1
    if length(sor) ≥ h && c ∉ sor
      m+=1
      irjam && println(sor)
    end
  end
  close(wf)  
  m,n
end
h,c=13,'e'
m,n=számol(h,c)
println("a szavak $(m*100.0/n) százaléka hosszabb mint $(h-1) és nincs benne '$(c)'")
```

    a szavak 0.6792081469831033 százaléka hosszabb mint 12 és nincs benne 'e'


### Feladat
Írjunk egy függvényt mely egy adott sztringről eldönti hogy tartalmaz-e bizonyos tiltott karaktereket.<br>
Azaz: ```S``` és ```T``` karaktereit egy-egy halmaznak (egy elem csak 1x szerepel) tekintve, döntsük el hogy 
```S```$\cup$ ```T``` $=\emptyset$ vagy sem


### Megoldás


```julia
function vanKözös(a, b)
  for c ∈ a 
    if c ∈ b return true end
  end
  false
end
```




    vanKözös (generic function with 1 method)



### Feladat
Írjunk egy függvényt mely egy adott ```S``` sztring esetén csak azokat a szavakat számolja, melyeknek nincs közös karaktere ```S```-el.

### Megoldás
Használjuk a ```vanKözös``` fv-t.


```julia
function számol(S,irjam=false)
  wf=open("words.txt")
  m,n=0,0
  for sor in eachline(wf)
    n+=1
    if false==vanKözös(sor, S)
      m+=1
      irjam && println(sor)
    end
  end
  close(wf)  
  m,n
end
S="aouei"
m,n=számol(S)
println(m*100.0/n," százalék")
```

    0.09401716911667794 százalék


### Feladat
Írjunk egy függvényt mely egy adott ```S``` sztring esetén eldönti hogy felépíthető-e csak egy adott ```T``` 
sztring karaktereinek (esetleg többszöri) felhasználásával.<br>
Azaz: ```S``` és ```T``` karaktereit egy-egy halmaznak (egy elem csak 1x szerepel) tekintve, döntsük el hogy 
```S```$\subseteq$ ```T``` fennáll vagy sem.


### Megoldás
Vegyük észre, hogy ha a sztringre mint többszörös elemeket is tartalmazó halmazra gondolunk, akkor éppen a 
részhalmaz relációt kell megvalósítani.


```julia
function része(a,b)
  for c ∈ a 
    if c ∉ b return false end
  end
  true
end
```




    része (generic function with 1 method)


