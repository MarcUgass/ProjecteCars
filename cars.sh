#!/bin/bash

ZonaOrigen(){
echo "Introdueix la zona d'origen: " 
read zonaorigen
linies=`wc -l < cars.csv`
tail +3 cars.csv | awk -v zo="$zonaorigen" -F ";" '{if ($9 ~ zo && $2 != 0) print $2}' > auxiliartasca2-3 #-v zo declara una variable dins de awk, que es igual a la variable zonaorigen
awk 'BEGIN { linies=0; total=0 } { linies++; total+=$1 } END { print total/linies }' auxiliartasca2-3 #Per a calcular i imprimir la mitjana
#wc -l < auxiliartasca2-3 #(linia per a comprovar que funcioni amb tots els cotxes de la zona d'origen)
rm auxiliartasca2-3
TornarCercaCotxes
}

enDesenvolupament() {
echo ""
read -n 1 -s -r -p "En desenvolupament"
echo ""
clear
menu
}

opcioNoValida() {
echo -e "\nError: Opcio no valida"
sleep 3
clear
menu
}

FuncioSortir()
{
echo ""
clear
exit

}


FuncioCase2() {
case $opcio2 in
1)
	OrdreAlfabetic;;
2)
	Tasca1-2;;
3)
	OrdenarAcceleracio;;
4)
	menu;;

*)
	opcioNoValida;;
esac
}

MenuCercaCotxes(){
clear
echo -e "        ---------------------------------------------------------
        2 - Cerca de cotxes.
        ---------------------------------------------------------
        1 Mostrar la fitxa tècnica d'un cotxe determinat.
        2 Mostrar els cotxes que tenen un mínim i màxim de potència determinada.
        3 Mostrar les mitjanes de consum per zona d'origen.
        4 Tornar."
 
 read -n 1 -s opcio3
 FuncioCase3  
}

FuncioCase3() {
case $opcio3 in
1)
	ImprimirCotxeConcret;;
2)
	Tasca2-2;;
3)
	ZonaOrigen;;
4)
	menu;;

*)
	opcioNoValida;;
esac
}
MenuOpcionsCotxes(){
clear
echo -e "        ---------------------------------------------------------
        1 - Llistat de cotxes 
        ---------------------------------------------------------
        1 Mostrar llistat de cotxes (alfabètic per nom)
        2 Mostrar llistat de cotxes ordenats de menys a més
        consum ( MPG - Miles per Gallon).
        3 Mostrar llistat de cotxes ordenat de més a menys
        acceleració a menys.
        4 Tornar"
 
 read -n 1 opcio2
 FuncioCase2      
}

FuncioCase() {
case $opcio in
1)
	MenuOpcionsCotxes;;
2)
	MenuCercaCotxes;;
3)
	enDesenvolupament;;
4)
	enDesenvolupament;;
0)
	FuncioSortir;;
*)
	opcioNoValida;;
esac
}

menu(){
clear
        echo "        ---------------------------------------------------------
        Base de Dades de cotxes
        ---------------------------------------------------------
        1 Llistats de cotxes.
        2 Cerca de cotxes.
        3 Comprovem si ets realment un Expert en cotxes.
        4 Altes, baixes i modificacions de la base de dades.
        0 Sortir."
        read -n 1 opcio
        FuncioCase
}

TornarMenuOpcionsCotxes(){
echo ""
read -n 1 -s -r -p "Prem qualsevol tecla"
echo ""
clear
MenuOpcionsCotxes
}

TornarCercaCotxes(){
echo ""
read -n 1 -s -r -p "Prem qualsevol tecla"
echo ""
clear
MenuCercaCotxes
}


Tasca1-2() {
clear
tail +3 cars.csv | sort -n -t ';' -k2 | awk -F";" '{ if ($2 != 0) print $0}' > auxAGO
linias=`wc -l < auxAGO`
for i in `seq 3 $linias`
do
echo -e "Cotxe: " `head -$i auxAGO | tail -1 | cut -d";" -f1`
echo -e "MPG: " `head -$i auxAGO | tail -1 | cut -d";" -f2` "    " "Nº Cilindres: " `head -$i auxAGO | tail -1 | cut -d";" -f3` "    " "Cilindrada: " `head -$i auxAGO | tail -1 | cut -d";" -f4`
echo -e "Potència(CV): " `head -$i auxAGO | tail -1 | cut -d";" -f5` "    " "Pes: " `head -$i auxAGO | tail -1 | cut -d";" -f6` "    " "Acceleracio (0 a 100): " `head -$i auxAGO | tail -1 | cut -d";" -f7`
echo -e "Model de l'any: " `head -$i auxAGO | tail -1 | cut -d";" -f8` "    " "Origen: " `head -$i auxAGO | tail -1 | cut -d";" -f9` 
done
rm auxAGO

TornarMenuOpcionsCotxes
}


OrdreAlfabetic ()
{

clear
tail +3 cars.csv | sort > cotxes_ordenats_alfabeticament

nombre_linies=`wc -l < cars.csv`

for i in `seq 3 $nombre_linies`
do
echo -e "Cotxe: " `head -$i cotxes_ordenats_alfabeticament| tail -1 | cut -d";" -f1`
echo -e "MPG: " `head -$i cotxes_ordenats_alfabeticament | tail -1 | cut -d";" -f2` "    " "Nº Cilindres: " `head -$i cotxes_ordenats_alfabeticament | tail -1 | cut -d";" -f3` "    " "Cilindrada: " `head -$i cotxes_ordenats_alfabeticament | tail -1 | cut -d";" -f4`
echo -e "Potència(CV): " `head -$i cotxes_ordenats_alfabeticament | tail -1 | cut -d";" -f5` "    " "Pes: " `head -$i cotxes_ordenats_alfabeticament | tail -1 | cut -d";" -f6` "    " "Acceleracio (0 a 100): " `head -$i cotxes_ordenats_alfabeticament | tail -1 | cut -d";" -f7`
echo -e "Model de l'any: " `head -$i cotxes_ordenats_alfabeticament | tail -1 | cut -d";" -f8` "    " "Origen: " `head -$i cotxes_ordenats_alfabeticament | tail -1 | cut -d";" -f9` "\n"
done
rm cotxes_ordenats_alfabeticament

TornarMenuOpcionsCotxes
}


OrdenarAcceleracio(){
tail +3 cars.csv | sort -g -t ";" -k7 > cotxes_ordenats_acceleracio
nombre_linies=`wc -l < cars.csv`
for i in `seq 3 $nombre_linies`
do
echo -e "Cotxe: " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f1`
echo -e "MPG: " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f2` "    " "Nº Cilindres: " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f3` "    " "Cilindrada: " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f4`
echo -e "Potència(CV): " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f5` "    " "Pes: " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f6` "    " "Acceleracio (0 a 100): " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f7`
echo -e "Model de l'any: " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f8` "    " "Origen: " `head -$i cotxes_ordenats_acceleracio | tail -1 | cut -d";" -f9`
echo " " #salt de linia
done
rm cotxes_ordenats_acceleracio

TornarMenuOpcionsCotxes
}


ImprimirCotxeConcret()
{
clear
echo "Introdueix el nom del cotxe: "
read cotxebuscat
grep $cotxebuscat -i cars.csv > auxiliar2-1
sort -t ";" -k8 -n auxiliar2-1 > auxiliarordenat2-1
linies=`wc -l < auxiliar2-1`
if [ "$linies" == 0 ] ;
then
	echo "La cerca ha estat fallida, vols repetir la cerca? (S/-) "
	read -n 1 -s -r resposta
	if [ "$resposta" = "S" ] ;
	then
		ImprimirCotxeConcret
	else
		TornarCercaCotxes
	fi
		
else
	for i in `seq "$linies"`
	do
		echo -e "Cotxe: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f1`
		echo -e "MPG: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f2` "    " "Nº Cilindres: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f3` "    " "Cilindrada: " `head -$i auxiliarordenat2-1 | 			tail -1 | cut -d";" -f4`
		echo -e "Potència(CV): " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f5` "    " "Pes: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f6` "    " "Acceleracio (0 a 100): " `head -$i auxiliarordenat2-1 | 		tail -1 | cut -d";" -f7`
		echo -e "Model de l'any: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f8` "    " "Origen: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f9`
		echo " " #salt de linia
	done
	TornarCercaCotxes
fi
rm auxiliar2-1
rm auxiliarordenat2-1
}


Tasca2-2() {
clear
i=1
l=0
echo "Introdueix el minim de cavalls: "
read minim
echo "Introdueix el maxim de cavalls: "
read maxim
tail +3 cars.csv | sort -n -t ';' -k5 > aux2AGO
linias=`wc -l < aux2AGO`

	while [ $i -le $linias ]
	do
	CV=`head -$i aux2AGO | tail -1 | cut -d";" -f5`
	if (($(echo "$CV > $minim && $CV < $maxim" | bc -l ) )); then
	echo -e "Cotxe: " `head -$i aux2AGO | tail -1 | cut -d";" -f1`
	echo -e "MPG: " `head -$i aux2AGO | tail -1 | cut -d";" -f2` "    " "Nº Cilindres: " `head -$i aux2AGO | tail -1 | cut -d";" -f3` "    " "Cilindrada: " `head -$i aux2AGO | tail -1 | cut -d";" -f4`
	echo -e "Potència(CV): " `head -$i aux2AGO | tail -1 | cut -d";" -f5` "    " "Pes: " `head -$i aux2AGO | tail -1 | cut -d";" -f6` "    " "Acceleracio (0 a 100): " `head -$i aux2AGO | tail -1 | cut -d";" -f7`
	echo -e "Model de l'any: " `head -$i aux2AGO | tail -1 | cut -d";" -f8` "    " "Origen: " `head -$i aux2AGO | tail -1 | cut -d";" -f9` 
	((l++))
	fi
	((i++)) 
done
if [ $l -eq 0 ]
then
	echo "No hi ha cap element"
fi
rm aux2AGO
TornarCercaCotxes
}

ImprimirCotxe()
{
nom=`head -$i cars.csv | tail -1 | cut -d; -f1`
mpg=`head -$i cars.csv | tail -1 | cut -d; -f2`
ncilindres=`head -$i cars.csv | tail -1 | cut -d; -f3`
cilindrada=`head -$i cars.csv | tail -1 | cut -d; -f4`
potencia=`head -$i cars.csv | tail -1 | cut -d; -f5`
pes=`head -$i cars.csv | tail -1 | cut -d; -f6`
acceleracio=`head -$i cars.csv | tail -1 | cut -d; -f7`
any=`head -$i cars.csv | tail -1 | cut -d; -f8`
origen=`head -$i cars.csv | tail -1 | cut -d; -f9`

echo "Cotxes: " $nom
echo "MPG: " $mpg "	Nº Cilindres: " $ncilindres "	  Cilindrada: " $cilindrada
echo "Potencia(CV): " $potencia "	Pes: " $pes "	  Acceleracio: " $acceleracio
echo "Model de l'any:" $any "		Origen: " $origen
}

Imprimircotxesllista()
{
clear
i=3

lin= `wc -l > carsordenat.csv`

for i in $lin
do
ImprimirCotxe >> cars_bon_format.txt
done
}

menu



