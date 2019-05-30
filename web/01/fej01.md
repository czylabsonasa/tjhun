
# Probléma-megoldás programozás útján

**Célunk**: megtanulni informatikus módjára gondolkozni. Ehhez gyakran matemetikai, mérnöki és <br>természettudományos elveket kell összkombinálnunk. De mindenekelőtt szükségünk van egy 
<br> többé-kevésbé formalizált nyelvre, hogy kifejezhessük, leírhassuk, megoldhassuk a problémákat <br>melyekkel szembekerülünk. Mint a mérnökök: megtervezzük a részeket, rendszerré építjük össze őket, 
<br>vagy mint a természettudósok: megfigyeljük a bonyolult rendszereket, hipotéziseket állítunk fel, <br>*teszteljük* azokat.

Az informatikus legfontosabb tevékenysége: a **probléma-megoldás**. Ez komplex feladat: le kell képezni a <br>feladatot olyan nyelvre amit egyrészt ismerünk, másrészt alkalmas a probléma leírására. Módszert, <br>számolási szabályt kell találnunk a megoldás megkeresésére, ami legtöbbször matematikai, 
<br>természettudományos ismereteket igényel. Ha ezekkel megvagyunk akkor jöhet a megvalósítás, kódolás 
<br> egy konkrét nyelven.

## Mi az a program?

A program egy leképezés, mely bemeneti adatok halmazát egy utasítássorozat segítségével 
<br>átalakítja kimeneti adathalmazzá: **kimenet = program( bemenet )**
<br> A bemenet lehet egy polinom, az utasítássorozat pedig a polinom gyökeinek kiszámítását leíró 
<br> utasítássorozat, a kimenet pedig a gyökök halmaza. Vagy: lehet a bemenet egy szöveg, 
<br>amelyen módosításokat akarunk végrehajtani.

Ugyanazon problémákat megoldó programok teljesen másként néznek ki különböző nyelveken, de 
<br> van néhány alaptevékenység, szerkezet mely minden nyelven kifejezhető:

**olvasás** <br>
 * billentyűzetről, fájlból, internetcímről, egyéb eszközről.<br>

**írás** <br>
 * képernyőre, fájlba, egyéb eszközre.<br>
    
**matematikai műveletek végrehajtása**<br>
 * összeadás, szorzás, kivonás, osztás...

**feltételes végrehajtás, elágazás**<br>
 * tevékenységek végrehajtásának egy eseményhez kötése:<br>
    ha a szám páros akkor oszd el kettővel. (egyébként ne csinálj semmit)<br>
    ha a szám páros akkor oszd el kettővel, egyébként szorozd meg 3-mal<br>

**ismétlés**<br>
 * tevékenység ismételt végrehajtása:<br>
   ameddig a szám páros addig oszd el kettővel.<br>

**alprogram, függvény**
* sokszor használt utasítássorozatok önálló egységbe csomagolásának
    lehetősége.
    

A programozás leegyszerüsítve: addig bontjuk szét az előttünk álló feladatot <br>
egyszerűbb részfeladatokra, amíg azokat a fenti szerkezetekkel már meg tudjuk oldani, ki tudjuk fejezni.

## Az első program

A hagyományokhoz híven:


```julia
println("helóvilág") # megjegyzés ami a # után van. a kiértékelés: shift+enter
```

    helóvilág


A ```println``` függvényt a ```helóvilág``` sztring bemenő adattal meghívtuk. Az utasítás (kifejezés) <br>
melynek végrehajtása (kiértékelése) során megjelent az adott sztring a képernyőn.

## Aritmetikai műveletek


```julia
1+1
```




    2




```julia
2^3
```




    8




```julia
1*2*3*4*5
```




    120




```julia
(1+2)*(1-2)
```




    -3




```julia
20/10 # float lesz ! nincs automatikus int-konverzió
```




    2.0



## Típusok, értékek

Programozás során számokkal, karakterekkel, karaktersorozatokkal dolgozunk: <br>
```1, 42, 'X', "alma", 3.14```<br>
<br>Ezek az értékek osztályokba, csoportokba sorolhatók - külön csoportot alkothatunk az egész számoknak, <br>a tört számoknak (ami egy bővebb csoport), vagy karaktereknek és sorozataiknak.<br> 
A csoportokat típusnak nevezzük. Az egész típus egy példánya az ```1```-es. 


```julia
typeof(1)
```




    Int64




```julia
typeof(42.0)
```




    Float64




```julia
typeof('X')
```




    Char




```julia
typeof("alma")
```




    String



## Természetes és formális nyelvek

**Természetes** nyelv az, amit használunk az emberi kommunikációnk során. Együtt fejlődött, fejlődik, alakul velünk. Hatással vagyunk rá és hatással van ránk. Sajátossága, hogy a jelsorozatok sokszor többféleképpen értelmezhetők, melyet a hallgató (olvasó) a kontextus segítségével általában meg tud szüntetni. Például:<br>
```Sorold fel a nyelv tulajdonágait!```<br>
A kérdésből még az sem derül ki, hogy a kérdező a nyelv-re mint jelrendszerre, vagy mint szerv-re gondolt.


A **formális** nyelv egy-egy speciális terület által használt, jól definiált szabályok által felépített szimbólum rendszer. Például véve kémiát, a <br>
$H_{2}O, H_{5}O, Z_{10}L$ <br>
jelek közül az első a víz vegyjele, a másodiknak megfelelő molekula a vegyértékek miatt nem létezhet, a harmadiknál már a használt jelekből látjuk hogy hibás van. Vagyis a formális nyelvek egy leegyszerűsített, de sokkal egyértelműbb kommunkikációt tesznek lehetővé. <br>
A formális nyelvnél a szintaktika és a szakterületi tudás birtokában a jelsorozatoknak egyértelműen dekódolhatónak kell lenni.


## Hibakeresés

A géppel, értelmezővel való párbeszéd, a programozás során hibákat követhetünk el, melyek helyét meg kell keresni, okát meg kell szüntetni. Itt egy fontos momentum, az hogy a gépet lehetőleg ne személyesítsük meg, vagy ha mindenáron ezt akarjuk tenni akkor gondoljunk a gépre beosztottként aki a parancsainkat feltétlen, 
betű szerint végrehajtja. Ha így teszünk sok fejfájástól kíméljük meg magunkat.

