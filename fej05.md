
# Elágazások, rekurzió

A fejezet egyik fő témája az ```if``` utasítás, mely a program aktuális változóinak értékétől - állapotától - függően más-más kódokat futtathat. <br>
Bevezetőnek ismerkedjünk meg két új függvénnyel:

## Kerekítéses osztás és maradék

A ```÷``` operátor elosztja az első operandust a másodikkal és veszi az eredmény egész részét:


```julia
időtartam = 105 # percekben
órák=időtartam ÷ 60 
println("$(időtartam) perc = $(órák) óra és $(percek) perc")
```

    105 perc = 1 óra és 45 perc



```julia
percek=időtartam % 60
println("$(időtartam) perc = $(órák) óra és $(percek) perc")
órák,percek=divrem(időtartam,60)
println("$(időtartam) perc  = $(órák) óra és $(percek) perc")


```

    105 perc = 1 óra és 45 perc
    105 perc  = 1 óra és 45 perc


A ```%``` operátorral eldönthetjük, hogy egy szám osztója-e egy másiknak vagy megtudhatjuk egy szám utolsó néhány jegyét - egyszerűen kérdezzük meg a maradékát $10$ bizonyos hatványára nézve (ha a tízes rendszerbeli jegyeire vagyunk kíváncsiak).



```julia
println(121%11)
println(13%5)
println(123123%100)
```

    0
    3
    23


## Logikai kifejezések

A logikai kifejezés olyan kifejezés, mely vagy igaz-ra vagy hamis-ra értékelődik ki futás során. A ```Julia```-ban a logikai értékek:
```true``` és ```false```, melyek a ```Bool``` típust alkotják. Logikai kifejezéseket olyan operátorokkal hozunk létre melyek maguk is logikai értéket adnak. A leggyakrabban használtak az összehasonlító operátorok a teljesség igénye nélkül:

|jel|értelme|
|---|---|
| ```==```  | egyenlőek? |
| ```<``` | kisebb? |
| ```<=``` | kisebb vagy egyenlö?|
| ```!=``` | nem egyenlö?|


```julia
println(5==5)
println(5<=5)
println(5<15)
typeof(5==6)
```

    true
    true
    true





    Bool



Ha valaki a megszokott jelölésekhez ragaszkodik:


```julia
println(3 ≥ 1) # \ge + TAB
println(3 ≠ 1) # # \ne + TAB
```

    true
    true


Figyeljünk oda: az ```==``` és a ```=``` teljesen más!

## Logikai operátorok


| jel | olvasása | működése |
|---|---|---|
| ```&&```  | és | csak akkor igaz, ha mindkét operandus az |
| ```\|\|``` | vagy | csak akkor hamis, ha mindkét operandus az |
| ```!``` | nem | csak akkor igaz ha az operandus nem az |

Segítségükkel egyszerűbb logikai kifejezéseket összekapcsolhatunk:


```julia
println(1==1 || 1==1 && 1==0)
println((1==0 || 1==1) && 1==0)
println(!(1==0) || 1==1)
println(!(1==0 || 1==1))


```

    true
    false
    true
    false


Az példa mutatja, hogy az ```||```<```&&```<```!``` a precedenciák sorrendje.

## Feltételes végrehajtás

Ha használható programokat akarunk írni szükség lehet megváltoztatni a program működését a körülményeknek megfelelően. 
A feltételes utasítás - ```if...end``` - ezt teszi lehetővé:



```julia
x = 4
if x%2==0
    println("a ",x," páros")
end

```

    a 4 páros


A működése: ha az ```if``` utáni logikai kifejezés, a **feltétel** ```igaz``` akkor 
végrehajtódik a kijelölt tevékenység. Ha nem akkor (itt) nem történik semmi. 

## Alternatív végrehajtás

Fent nem kezeltük le azt az esetet amikor $x$ páratlan, ezt is 
lekezelhetjük az ```if...else...end``` szerkezettel:


```julia
x = 3
if x%2==0
  println("a ",x," páros")
else
  println("a ",x," páratlan")
end

```

    a 3 páratlan


## Láncolt elágazás

Ha több alternatíva van, hasznos az ```if...elseif...else...end``` szerkezet:


```julia
function foo(x)
  if x%4==0
    println("a(z) ",x," néggyel osztható")
  elseif x%4==1
    println("a(z) ",x," néggyel 1 maradékot ad")
  elseif x%4==2
    println("a(z) ",x," néggyel 2 maradékot ad")
  elseif x%4==3
    println("a(z) ",x," néggyel 3 maradékot ad")
  else
    println("a maradékos osztáshoz egész szám kell!")
  end
end
foo.([1,2,3,4,4.1]); # broadcasting, lebegőpontos lesz a teljes vektor!
```

    a(z) 1.0 néggyel 1 maradékot ad
    a(z) 2.0 néggyel 2 maradékot ad
    a(z) 3.0 néggyel 3 maradékot ad
    a(z) 4.0 néggyel osztható
    a maradékos osztáshoz egész szám kell!


Láthatjuk, hogy nincs határ ```elseif``` ágak számára. A logikai kifejezések sorban kiértékelődnek, és<br> 
ha ```false```-ot kapunk, megy a kiértékelés a további ágakra, amíg el nem fogynak.

## Egymásba ágyazás
Az ```if``` egymásba is ágyazhatóak. Jól gondoljuk meg a használatát, mert ha <br>
tartjuk magunkat valamilyen behúzási rendhez, könnyen elgogyhat a képernyőnk szélessége.


```julia
x,y=1,2
if x == y
    println("x and y are equal")
else
    if x < y
        println("x is less than y")
    else
        println("x is greater than y")
    end
end
```

    x is less than y


Ráadásul az alábbi esetben, még csúnyább is a kód:


```julia
if 0 < x
    if x < 10
        println("x is a positive single-digit number.")
    end
end
```

    x is a positive single-digit number.


Mintha az alábbit használnánk:


```julia
if 0 < x < 10
    println("x is a positive single-digit number.")
end
```

    x is a positive single-digit number.



```julia
## Rekurzió

A függvények kölcsönösen hívhatják egymást, sőt önmagukat is. Ez elsőre furcsának tűnhet, de <br>
meglátjuk, hogy hasznos dolog.
```


    syntax: extra token "függvények" after end of expression

    



```julia
function visszaSzámol(n)
    if n ≤ 0
        println("Bumm!")
    else
        print(n, " ")
        visszaSzámol(n-1)
    end
end
visszaSzámol(5)
```

    5 4 3 2 1 Bumm!


Az ilyen típusú hívások láncolata kényelmesen megjeleníthető egy fa segítségével.<br>
Következő példával egy sztringet íratunk ki a képernyőre $n$-szer:




```julia
function kiírN(s, n)
    if n ≤ 0
        return
    end
    println(s)
    kiírN(s, n-1)
end
kiírN("hali ",3)
```

    hali 
    hali 
    hali 


## Végtelen rekurzió
A rekurzív függvények tervezésénél nagyon fontos odafigyelni a rekurzió elzárására, azaz <br>
olyan feltételeket beépíteni a függvénybe, melyek minden inputra garantálják hogy nem kerülünk <br>
végtelen rekurzióba, ezt a feltételt bázis feltételnek nevezzük (ennek teljesülésekor <br>
megszakad a rekurzív hívás-sorozat).


```julia
function ∞Rekurzió()
    ∞Rekurzió()
end
∞Rekurzió()
```


    StackOverflowError:

    

    Stacktrace:

     [1] ∞Rekurzió() at ./In[34]:2 (repeats 80000 times)


Szerencsére mindig van hardveres korlátja is a végtelen rekurziónak,<br> 
de gyakran nem könnyű lenyomozni hol kerül a programunk végtelen rekurzióba.<br>
A fenti példa arról ad tájékoztatást, hogy $80000$ mélységű rekurzió után a futás megszakadt.

## Adat-bevitel

Julia-ban a ```readline``` függvénnyel olvashatunk a billenytyűzetről, a sztenderd inputról karaktereket.



```julia
s=readline()
println("ezt adtad: ", s)
```

Az olvasást összekapcsolhatjuk kiírással is:


```julia
s = (println("hány éves vagy?"); readline())
println( if mod(parse(Int,s),2)==0 "páros sok éves vagy" else "páratlan sok éves vagy" end )
```

A pontosvesszővel elválasztott kifejezések kiértékelődnek. A zárójel egy kifejezéssé alakítja őket.<br>
A végső kifejezés értéke az utoljára kiértékelt kifejezés, a ```readline()```. A beolvasott <br>
sztringet a ```parse``` segítségével alakíthatjuk egésszé.


## Feladatok

### 1. Próbáljuk megfejteni az alábbi függvény működését:
```julia
function recurse(n, s)
    if n == 0
        println(s)
    else
        recurse(n-1, n+s)
    end
end
```

### 2. Írjunk egy 
```julia
function checkFermat(a,b,c,n)
end
```
alakú függvényt, mely ellenőrzi hogy a híres [Fermat](https://hu.wikipedia.org/wiki/Nagy_Fermat-t%C3%A9tel)-féle $a^n+b^n=c^n$ egyenlőség teljesül-e vagy sem. (```true,false```)

### 3. Írjunk egy
```julia
function checkTriangle(a,b,c)
end
```
alakú függvényt, mely ellenőrzi hogy az adott számokból szerkeszthető-e háromszög. (```true,false```)


