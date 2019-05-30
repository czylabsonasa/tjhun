
# Sztringek

A sztringek karakterekből - tehát ```Char``` típusú elemekből - álló sorozatoknak gondolhatók.<br>
Ebben a fejezetben megtanuljuk létrehozni és manipulálni őket.

## Karakterek

Mik is azok karakterek?<br>
A latin ABC karakterei ```a,b,c,...,x,y,z,B,...,X,Y,Z``` széles körben használatosak a nyugati világban. Ennek a ABC-nek 
számjegyekkel és speciális (pl. vezérlő: shift,enter) karakterekkel, való kiterjesztését szabványosították: [ascii wiki](https://hu.wikipedia.org/wiki/ASCII). Ez a készlet szűknek bizonyult (7bit=128 lehetőség), hiszen 
a géppel való kommunikáció során a legkülönfélébb jelek haszálatára van-lehet szükség. Mivel a mai gépek belsejében bit-sorozatok számok vannak, természetesen a karakterek számok. Azt különféle ```jelek```-hez milyen szám tartozik az ```Unicode``` írja le, azt hogy ezt hogyan is kell megvalósítani az ```UTF8```: [Unicode/UTF8 leírás](http://www.cs.bme.hu/~egmont/utf8/) Ezek a részletek minket nem igazán érdekelnek: használni akarjuk a karaktereket.<br>

> Julia-ban egy karaktert aposztrófok közt adhatunk meg:


```julia
a='A'
println(typeof(a))
println('🍌')
```

    Char
    🍌


> Speciális karaktereket ún. escape sorozattal adhatunk meg: ```'\:banana:+TAB'``` Azaz elkezdjük egy nyitó aposztróffal a karakter megadását majd a ```\:``` után kezdjük el írni a kívánt jel nevét, ekkor a ```TAB```-ot megnyomva egy listát látunk a lehetséges kiegészítésekről (ha van ilyen), ebből kiválaszthatjuk a nekünk megfelelőt. Zárjuk be a megadást aposztróffal. Ha mindenáron használni akarjuk némi próbálkozással ráérezhetünk.<br>


## Sztring=karakter-sorozat
Tehát a ```String``` ```Char``` értékekek sorozata. Megadásuk idézőjel pár között felsoroljuk a karaktereket:


```julia
b="ez egy emoji: 😄" # \:smile:
println(a)
println(typeof(b))
```

    A
    String


> A sorozat egyedi bájtjainak (ami nem mindig karakter) elérése (hivatkozás rájuk) a ```[]``` szerkezettel lehetséges:


```julia
println(b[1])
println(b[end])
println(b[1:6])
println(typeof(1:6))
println(b[1:2:end])
println(b*", ez meg egy összeadás: 1+1=2")
# b[1]='E'                   # hiba: non-mutable
# b[1.4]                     # hiba, csak egész lehet az index                         
```

    e
    😄
    ez egy
    UnitRange{Int64}
    e g mj:😄
    ez egy emoji: 😄, ez meg egy összeadás: 1+1=2


Tehát:
> 1. az indexelés ```1```-el kezdődik
2. az utolsó elem az ```end```-el érhető el
3. indexsorozat kijelölésével összefüggő részeket érhetünk el
4. az index-sorozat kijelölés eszköze az ```UnitRange```, melyet a ```:```-al hozunk létre.
5. a lépésközt is megadhatjuk
6. összefűzhetjük, konkatenálhatjuk a sztringeket a ```*``` operátorral
7. **nem módosíthatók**
8. az index csak egész lehet

### ```length```
A sztringet alkotó karakterek számát adja vissza, ami nem feltétlen a bájtok száma. Ez akkor okozhat gondot, ha 
olyan karaktereket is használunk ami 1-nél több bájton ábrázolódik, ekkor az index-hivatkozás ```[]``` nem az elvárt helyre mutat, nem értelmezhető karakterként.


```julia
gyümi="🍌 🍎 🍋"
println(length(gyümi))
println(gyümi[5])        # nem hiba, de nem az elvártat látjuk (citrom)
# println(gyümi[2])      # hiba egy több-bájtos dolog második bájtjára hivatkozunk
println(gyümi[end])
# println(gyümi[end-2])      # hiba: elképzelés: alma - nem az
println(sizeof(gyümi))
```

    5
     
    🍋
    14


> Azaz a ```length``` által adott szám nem ugyanaz mint a ```[]``` által hivatkozható tartomány! <br>
> Az első ```Char``` alapú, míg az utóbbi bájt alapú.<br>
> Mivel```UTF8``` kódolás változó bájthosszúságú, ezért egy sztring karaktereinak bejárására ne használjuk a   ```[]```-t<br>
> 
> A ```sizeof``` a bájtok számát adja vissza

## Sztring bejárása

Nem kell megijedni, nem így kell bejárni egy sztringet, de az alábbi kód jobb betekintést ad:


```julia
ind = firstindex(gyümi)
while ind <= sizeof(gyümi)
    println(ind,"   ",gyümi[ind])
    ind = nextind(gyümi, ind)
end
println(lastindex(gyümi))
```

    1   🍌
    5    
    6   🍎
    10    
    11   🍋
    11


> 1. ```firstindex``` az első karakter bájt-alapú indexe
1. ```sizeof```: bájtok száma
1. ```nextind```: az első paraméterként adott sztringben a második paraméterként adott index utáni legális karakter bájt-indexe
1. ```lastindex```: az utolsó karakter bájt-indexe
1. Ezek a szerkezetek más kollekciók esetén is használhatók


A mindennapi  kódolás során inkább az alábbi használatos:


```julia
for c in gyümi
  println(c)
end
  
```

    🍌
     
    🍎
     
    🍋


## Feladat
Írjuk meg a fenti kód visszafelé-bejáró változatát. Használjuk a ```prevind```-et.

## Megoldás


```julia
ind = lastindex(gyümi)
while ind >= firstindex(gyümi)
  println(gyümi[ind])
  ind = prevind(gyümi, ind)
end

```

    🍋
     
    🍎
     
    🍌


## Szeletek a sztringből

Láttuk, hogy bizonyos részeket kiszedhetünk a sztringből a ```UnitRange``` segítségével.<br> 
Fontos hogy ekkor az eredeti sztring egy másolata jön létre:


```julia
a="123456789"
b=a[1:3]
println(b)
a="23456789"
println(b)
```

    123
    123


## A sztringek nem-mutábilisek

Ezt is láttuk a fejezet elején. A "régi" nevet viszont felhasználhatjuk. <br>
A következő példában nem az ```a```-val jelölt sztringet módosítottuk, hanem az ```a```-nevet kötöttük hozzá egy új sztringhez:


```julia
a="123"
println(a)
a=a*"456"
println(a)
```

    123
    123456


## Behelyettesítés (interpoláció)

A ```*``` operátorral körülményes, és nem rugalmas létrehozni sztringeket. Erre való a behelyettesítés:


```julia
a="halló"
b="világ"
println(a*", "*b*"!")
# versus
println("$(a), $(b)!")
# vagy
x=12
y=12
println("$(x) * $(y) = $(x*y)")

```

    halló, világ!
    halló, világ!
    12 * 12 = 144


## Karakterek keresése



```julia
a="12341"
println(findfirst("1",a))
show(findfirst("5",a));println()
println(findfirst((x)->x=='1', a))
println(findall((x)->x=='1', a))
a="🍴 ✂ nem gyerek kezébe való"
println(findfirst((x)->x=='e', a))
println(findfirst((x)->x=='✂', a))
ret=findfirst((x)->x=='í', a)
typeof(ret)
```

    1:1
    nothing
    1
    [1, 5]
    11
    6





    Nothing



> 1. A ```findfirst(x, y)``` egy változata az ```x``` sztring ```y``` sztringbeli első előfordulását adja meg, bájt-index tartomány formában.<br> Karakter keresése esetén egykarakteres sztringet adunk meg.
> 1. Nem érdemes külön sztringben való keresgetéssel foglalkozni, <br>a ```findfirst``` és variációi a megoldás, 
mivel ezek tetszőleges kollekciók esetén használhatók.
> 1. a ```(x)->x=='1'``` szerkezet rövid, névhez nem feltétlen kötött függvények létrehozására jó. <br>
   Itt egy ```Bool```-t visszadó függvényt adunk meg. Ezt predikátumnak is nevezik. <br>
   Ez ```findfirst``` első paramétere; a második a kollekció, jelen esetben egy sztring, melynek sorra veszi az elemeit és azon indexeket adja vissza melyre ```true```-t ad a predikátum.
> 1. A visszadott szám ```byte```-index, tehát nem a karakter sorszáma. Ezt a sztringekben keresgélésnél tartsuk szem előtt.
> 1. Sikertelen keresés esetén ```nothing```-ot ad vissza. Ezt nekünk kell lekezelni.


Ha mindenáron újra fel akarjuk találni a kereket, a sztring bejárós kóddal írhatunk egyet magunknak:


```julia
function keres1(ebben, ezt, ind=nothing)
  ind = if ind==nothing firstindex(ebben) else ind end
  while ind <= sizeof(ebben)
    if ebben[ind]==ezt 
      return ind
    end
    ind = nextind(ebben, ind)
  end
  nothing
end
a="12341"
ret=keres1(a,'1')
show(ret);println()
ret=keres1(a,'7')
show(ret);println()
ret=keres1(a,'1',1)
show(ret);println()

```

    1
    nothing
    1


## Feladat 
Számoljuk meg egy sztringben egy adott karakter előfordulásainak számát! Használjuk a ```findall```-t.

## Megoldás


```julia
a="9123412229999"
println(length(findall((x)->x=='0', a)))
println(length(findall((x)->x=='1', a)))
println(findall((x)->x=='9', a))
```

    0
    2
    [1, 10, 11, 12, 13]


## Rész-sztringek keresése


```julia
szó="kandírozott mandarinzselé-színű áramvonalidom Lada személygépkocsihoz"
show(findfirst("ár",szó));println()
show(findfirst("vár",szó));println()
```

    37:39
    nothing


## Feladat
Írjuk meg a ```findall``` sztringes változatát. Használjuk a ```findnext```-et.




## Hasznos sztring-függvények


```julia
a="Indul a PAP aludni"
k="korán"
println(uppercase(a))
println(lowercase(a))
println(reverse(a))            # megfordítja a sztringet
println(join([k, " ", a]))     # egy sztrinekből álló tömb elemeit fűzi össze
```

    INDUL A PAP ALUDNI
    indul a pap aludni
    indula PAP a ludnI
    korán Indul a PAP aludni


## Az ∈ operátor 

Használata: arra vagyunk kíváncsiak hogy egy elem benne van-e egy adott kollekcióban, jelen esetben sztringben:


```julia
a="Mert te ilyen vagy s ők olyanok"
println('z' ∈ a)
println(in('a',a))        # használhatjuk az prefix alakot is (min minden infix operátornál)
```

    false
    true


## Feladat 
Írjunk egy függvényt, mely két sztring esetén visszaadja azt a sztringet mely olyan elsőbeli 
karakterekből áll, melyek a másodikban is benne vannak.

## Megoldás


```julia
ab(a,b)=join([c for c ∈ a if c ∈ b ])
a="rettenetesen"
b="szerény"
println(ab(a,b))
println(ab(b,a))    # nem szimmetrikus!
```

    reeneesen
    sern


## Összehasonlítás

Nagyjából mindent amit a számoknál megismertünk és értelmes sztringekre, azt használhatjuk:


```julia
a="Kovács Béla"
b="Kovács Jenő"
println(a<b)
c="KOVÁCS BÉLA"
println(lowercase(a)==lowercase(b))
println(lowercase(a)==lowercase(c))
println("a" ≤ "aa")                 # lexikografikus; ≤ -> \le+TAB, \le -> less or equal
println(""<"a")                     # az üres string 
```

    true
    false
    true
    true
    true


## Feladat 
Az alábbi függvények elvárt működése: igazat adnak pont akkor, ha ```s``` tartalmaz kibetűt. Melyik működik helyesen? Javítsuk ki a rosszakat.

```julia
function kisbetű1(s)
    for c in s
        if islowercase(c)
            return true
        else
            return false
        end
    end
end

function kisbetű2(s)
    for c in s
        if islowercase('c')
            return "true"
        else
            return "false"
        end
    end
end

function kisbetű3(s)
    for c in s
        flag = islowercase(c)
    end
    flag
end

function kisbetű4(s)
    flag = false
    for c in s
        flag = flag || islowercase(c)
    end
    flag
end

function kisbetű5(s)
    for c in s
        if !islowercase(c)
            return false
        end
    end
    true
end
```


## Feladat 
Ha az ABC kisbetűit $a_0,\ldots,a_{25}$ alakban képzeljük el, egyszerű kódolást kapunk ha minden betűt egy fix 'd' számmal tőle jobbra levőre cseréljük, ha túlmennénk a végén jöjjünk be az elején. Pl:
```
d=2 -> baba  ->  dcdc
d=1 -> elvis -> fmwjt 
```
Írjunk egy függvényt mely megvalósítja ezt.

## Megoldás


```julia
function Caesar(s,d) # feltesszük, hogy csak kisbetűk vannak s-ben
  m=Int('a')
  t=""
  for c in s
    t=t*Char((Int(c)-m+d)%26+m)
  end
  t
end
Caesar("baba",2)
Caesar("elvis",1)

# vagy máshogy
cc(x,d)=Char((Int(x)-Int('a')+d)%26+Int('a'))
println(map( (x)->cc(x,7), "cheer" ))
println(map( (x)->cc(x,16), "melon" ))



```

    jolly
    cubed

