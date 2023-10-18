#!/bin/bash

Tasca4-3() {

clear
echo "Introdueix el nom del cotxe: "
read cotxebuscat
grep $cotxebuscat -i cars.csv > auxiliar2-1 #pasa les linees que contenen el nom del cotxe introduit a un arxiu auxiliar
sort -t ";" -k8 -n auxiliar2-1 > auxiliarordenat2-1 # ordena per any totes les fitxes tècniques  dels  cotxes  amb  el  nom  introduit
linies=`wc -l < auxiliar2-1`
if [ "$linies" == 0 ] ; #si no existeixen fitxes amb el nom introduit es repeteix la cerca o es torna al menu
then
	echo "La cerca ha estat fallida, vols repetir la cerca? (S/-) "
	read -n 1 -s -r resposta
	if [ "$resposta" = "S" ] ;
	then
		Tasca4-3
	else
		TornarMenuModificacions
	fi
		
else #si existeixen fitxes les imprimeix amb format
	for i in `seq "$linies"`
	do
		
		echo -e "Cotxe: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f1`
		echo -e "MPG: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f2` "    " "Nº Cilindres: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f3` "    " "Cilindrada: " `head -$i auxiliarordenat2-1 | 			tail -1 | cut -d";" -f4`
		echo -e "Potència(CV): " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f5` "    " "Pes: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f6` "    " "Acceleracio (0 a 100): " `head -$i auxiliarordenat2-1 | 		tail -1 | cut -d";" -f7`
		echo -e "Model de l'any: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f8` "    " "Origen: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f9`
		echo " " #salt de linia
	done
fi

echo "Introdueix l'any:" #l'usuari introdueix dades del cotxe concret
	read any
echo "Introdueix el pes:"
	read pes
echo "Introdueix el consum:"
	read consum
echo "Introdueix el nº de cilindres:"
	read ncilin
echo "Introdueix la cilindrada:"
	read cilindrada
echo "Introdueix la potència"
	read potencia
echo "Introdueix l'acceleracio:"
read acceleracio
echo "Introdueix l'origen:"
read origen
grep -i "$cotxebuscat" cars.csv | grep -i ";[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;$pes[.]*;[a-z,A-Z,0-9,.]*;$any" -i cars.csv | cut -f1 -d: > auxfinal
linfin=`wc -l < auxfinal`
	if [ "$linfin" -eq 0 ]
	then
	TornarMenuModificacions
	fi
liniacotxe=`grep -n -i "$cotxebuscat" cars.csv | grep -n -i ";[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;$pes[.]*;[a-z,A-Z,0-9,.]*;$any" -i cars.csv | cut -f1 -d:` #aconseguim el numero de linea del cotxe que volem cambiar
echo "Has canviat:"
cotxeantic=`head -$liniacotxe cars.csv | tail -1` #linia cotxe antic
nomcotxe=`head -$liniacotxe cars.csv | tail -1 | cut -f1 -d ";"`
cotxenou="$nomcotxe;$consum;$ncilin;$cilindrada;$potencia;$pes;$acceleracio;$any;$origen" #linia cotxe nou
echo "`head -$liniacotxe cars.csv | tail -1`"
sed -i "s/$cotxeantic/$cotxenou/g" "cars.csv" #reemplaza linea antiga per nova a cars.csv
echo "per `head -$liniacotxe cars.csv | tail -1`" 

rm auxiliarordenat2-1
rm auxiliar2-1
rm auxfinal

TornarMenuModificacions
}

FuncioCase5() {
case $opcio5 in
1)
	tasca4.1;;
2)
	Tasca4.2;;
3)
	Tasca4-3;;
4)
	menu;;
*)
	opcioNoValida;;
esac
}

MenuModificacions(){
clear
echo -e "        --------------------------------------------------
	4-Altes, baixes i modificacions de la base de dades.
	--------------------------------------------------
	1 Alta.
	2 Baixa.
	3 Modificació.
	4 Tornar."
 
 read -n 1 -s opcio5
 FuncioCase5
}

TornarMenuModificacions(){
echo ""
read -n 1 -s -r -p "Prem qualsevol tecla"
echo ""
clear
MenuModificacions
}

tasca4.1() {
	clear
	echo "Introdueix les dades del cotxe:"
	echo "" #linia en blanc
	echo Nom del cotxe:
	read nomcotxe
	clear
	echo "Introdueix les dades del cotxe:"
	echo ""
	echo MPG:
	read mpg
	clear
	echo "Introdueix les dades del cotxe:"
	echo ""
	echo Nº Cilindres:
	read ncilindres
	clear
	echo "Introdueix les dades del cotxe:"
	echo ""
	echo Cilindrada:
	read cilindrada
	clear
	echo "Introdueix les dades del cotxe:"
	echo ""
	echo "Potència(CV):"
	read potencia
	clear
	echo "Introdueix les dades del cotxe:"
	echo ""
	echo Pes:
	read pes
	clear
	echo "Introdueix les dades del cotxe:"
	echo ""
	echo "Acceleracio ( 0 a 100)"
	read acceleracio
	clear
	echo "Introdueix les dades del cotxe:"
	echo ""
	echo "Model de l'any:"
	read any
	clear
	echo "Introdueix les dades del cotxe:"
	echo ""
	echo Origen:
	read origen
	echo -e "$nomcotxe\n$mpg\n$ncilindres\n$cilindrada\n$potencia\n$pes\n$acceleracio" #imprimeix les dades introduïdes per l'usuari
	grep -n -i "$cotxebuscat" cars.csv | grep -n -i ";[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;$pes[.]*;[a-z,A-Z,0-9,.]*;$any" -i cars.csv > coincidents #si hi ha un cotxe que coincideix, l'imprimeix a l'arxiu auxiliar coincidents
	coincident=`wc -l < coincidents`
	rm coincidents
	echo $coincident
	if [ $coincident -ne 0 ];
	then
		echo Aquest cotxe ja existeix
		TornarMenuModificacions
	else
		echo "$nomcotxe;$mpg;$cilindrada;$potencia;$pes;$acceleracio;$any;$origen" >> cars.csv
	fi
	
	if [ `tail -1 cars.csv` = "$nomcotxe;$mpg;$cilindrada;$potencia;$pes;$acceleracio;$any;$origen" ];
	then
		echo "S'ha donat d'alta el cotxe correctament"
		TornarMenuModificacions
	else
		echo "Ha hagut un error donant d'alta el cotxe, sisplau torna-ho a intentar"
		TornarMenuModificacions
	fi
}

EncertarNom(){
	clear
	linies=`wc -l < cars.csv`
	let aleatori1=$(($RANDOM%($linies-2)))+2 #Genera un numero aleatori entre 3 i el nombre de linies de cars.csv
	let aleatori2=$(($RANDOM%($linies-2)))+2
	while [ $aleatori2 -eq $aleatori1 ] #Ha de ser diferent de $aleatori1
	do
		let aleatori2=$(($RANDOM($linies-2)))+2
	done
	let aleatori3=$(($RANDOM%($linies-2)))+2
	while [ $aleatori3 -eq $aleatori2 ] || [ $aleatori3 -eq $aleatori1 ] #Ha de ser diferent de $aleatori1 i de $aleatori2
	do
		let aleatori3=$(($RANDOM%($linies-2)))+2
	done
	echo -e "Cotxe: ???" #`head -$aleatori1 cars.csv | tail -1 | cut -d";" -f1`
	echo -e "MPG: " `head -$aleatori1 cars.csv | tail -1 | cut -d";" -f2` "    " "Nº Cilindres: " `head -$aleatori1 cars.csv | tail -1 | cut -d";" -f3` "    " "Cilindrada: " `head -$aleatori1 cars.csv | tail -1 | cut -d";" -f4`
	echo -e "Potència(CV): " `head -$aleatori1 cars.csv | tail -1 | cut -d";" -f5` "    " "Pes: " `head -$aleatori1 cars.csv | tail -1 | cut -d";" -f6` "    " "Acceleracio (0 a 100): " `head -$aleatori1 cars.csv | tail -1 | cut -d";" -f7`
	echo -e "Model de l'any: " `head -$aleatori1 cars.csv | tail -1 | cut -d";" -f8` "    " "Origen: " `head -$aleatori1 cars.csv | tail -1 | cut -d";" -f9` 
	echo -e "$aleatori1\n$aleatori2\n$aleatori3" > auxiliar
	sort -R auxiliar > auxiliarordenatrand
	opcio1=`head -1 auxiliarordenatrand`
	opcio2=`head -2 auxiliarordenatrand | tail -1`
	opcio3=`head -3 auxiliarordenatrand | tail -1`
	echo "" #deixar 1a linia en blanc
	echo 1.`head -$opcio1 cars.csv| tail -1 | cut -d ";" -f1`
	echo 2.`head -$opcio2 cars.csv| tail -1 | cut -d ";" -f1`
	echo 3.`head -$opcio3 cars.csv| tail -1 | cut -d ";" -f1`
	echo "" #deixar 1a linia en blanc
	echo "Selecciona una opció [1, 2, 3]"
	read -n1 -s respostanum
	case $respostanum in
		1) resposta=$opcio1;;
		2) resposta=$opcio2;;
		3) resposta=$opcio3;;
	esac
	if [ $resposta -eq $aleatori1 ]
	then
		echo "Felicitats! Has encertat"
	else
		echo "T'has equivocat, la resposta correcta era" `head -$aleatori1 cars.csv | tail -1 | cut -d ";" -f1`
	fi
	rm auxiliar
	rm auxiliarordenatrand
	TornarExpertCotxes
}

ZonaOrigen(){
clear
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
clear
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

FuncioCase4() {
case $opcio4 in
1)
	Tasca3-1;;
2)
	EncertarNom;;
3)
	Tasca3.3;;
4)
	menu;;
*)
	opcioNoValida;;
esac
}

MenuExpertCotxes(){
clear
echo -e "        ---------------------------------------------------------
        3 - Comprovem si ets realment un Expert de cotxes.
        ---------------------------------------------------------
        1 Quin és l'origen del cotxe ...?
        2 Quin cotxe és?
        3 Quin any va ser el primer model del cotxe ...?
        4 Tornar."
 
 read -n 1 -s opcio4
 FuncioCase4  
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
	MenuExpertCotxes;;
4)
	MenuModificacions;;
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

TornarExpertCotxes(){
echo ""
read -n 1 -s -r -p "Prem qualsevol tecla"
echo ""
clear
MenuExpertCotxes
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
clear
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

ZonaOrigen(){
clear
echo "Introdueix la zona d'origen: " 
read zonaorigen
linies=`wc -l < cars.csv`
tail +3 cars.csv | awk -v zo="$zonaorigen" -F ";" '{if ($9 ~ zo && $2 != 0) print $2}' > auxiliartasca2-3 #-v zo declara una variable dins de awk, que es igual a la variable zonaorigen
awk 'BEGIN { linies=0; total=0 } { linies++; total+=$1 } END { print total/linies }' auxiliartasca2-3 #Per a calcular i imprimir la mitjana
#wc -l < auxiliartasca2-3 #(linia per a comprovar que funcioni amb tots els cotxes de la zona d'origen)
rm auxiliartasca2-3
TornarCercaCotxes
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
if [ $l -eq 0 ];
then
	echo "No hi ha cap element"
fi
rm aux2AGO
TornarCercaCotxes
}

Tasca3.3()
{
clear
lin=`wc -l < cars.csv`
i=3
nom=`tail +3 cars.csv | sort -R cars.csv | head -n1 | cut -d";" -f1`
num=`tail +3 cars.csv | awk -F";" -v nom="$nom" '{ if ($1 == nom) print $0}' | sort -n -t ';' -k8 | head -1 | cut -d";" -f8`


echo Quin any va ser el primer model del cotxe $nom?
read any

if [ "$any" = "$num" ];
then
	echo "FELICITATS!"
else
	echo La resposta correcta era "$num"
fi
TornarExpertCotxes
}

Tasca3-1(){
clear
limit=`wc -l < cars.csv`
limit_aleatori=$limit-2
num_aleatori=`echo $((RANDOM%$limit_aleatori))`
let i=$num_aleatori+2

nom=`head -$i cars.csv | tail -1 | cut -d";" -f1`
mpg=`head -$i cars.csv | tail -1 | cut -d";" -f2`
ncilindres=`head -$i cars.csv | tail -1 | cut -d";" -f3`
cilindrada=`head -$i cars.csv | tail -1 | cut -d";" -f4`
potencia=`head -$i cars.csv | tail -1 | cut -d";" -f5`
pes=`head -$i cars.csv | tail -1 | cut -d";" -f6`
acceleracio=`head -$i cars.csv | tail -1 | cut -d";" -f7`
any=`head -$i cars.csv | tail -1 | cut -d";" -f8`
origen=`head -$i cars.csv | tail -1 | cut -d";" -f9`

echo "Cotxes: " $nom
echo "MPG: " $mpg "	Nº Cilindres: " $ncilindres "	  Cilindrada: " $cilindrada
echo "Potencia(CV): " $potencia "	Pes: " $pes "	  Acceleracio: " $acceleracio
echo "Model de l'any:" $any 

linies=`wc -l < cars.csv`
tail +3 cars.csv | awk -F";" '{print $9;}' > origens1 #imprimeix tots els origens de cars.csv
awk '!visited[$0]++' origens1 > origens #imprimeix els origens sense repetir
liniesorigen=`wc -l < origens`
for i in `seq $liniesorigen`
do
	echo "$i.`head -$i origens | tail -1`"
	if [ $origen = `head -$i origens | tail -1` ];
	then
		respostacorrecta=$i
	fi
done
echo "Quina és la zona d'origen del vehicle mostrat a l'inici?"
echo "Selecciona una opció [1, 2, 3]"
read -n1 -s resposta
echo ""

if [ $resposta = $respostacorrecta ];
then
	echo "Felicitats, has encertat la zona d'origen."
else
	echo "T'has equivocat, la zona d'origen és $origen"
fi

rm origens1
rm origens
TornarExpertCotxes
}


Tasca4.2()
{

clear
cp cars.csv carscopia.csv
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
		Tasca4.2
	else
		TornarMenuModificacions
	fi
		
else
	for i in `seq "$linies"`
	do
		
		echo -e "Cotxe: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f1`
		echo -e "MPG: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f2` "    " "Nº Cilindres: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f3` "    " "Cilindrada: " `head -$i auxiliarordenat2-1 | 			tail -1 | cut -d";" -f4`
		echo -e "Potència(CV): " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f5` "    " "Pes: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f6` "    " "Acceleracio (0 a 100): " `head -$i auxiliarordenat2-1 | 		tail -1 | cut -d";" -f7`
		echo -e "Model de l'any: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f8` "    " "Origen: " `head -$i auxiliarordenat2-1 | tail -1 | cut -d";" -f9`
		echo " "
	done
fi

echo "Introdueix l'any:"
	read any
echo "Introdueix el pes:"
	read pes
grep -i "$cotxebuscat" cars.csv | grep -i ";[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;$pes[.]*;[a-z,A-Z,0-9,.]*;$any" -i cars.csv | cut -f1 -d: > auxfinal
linfin=`wc -l < auxfinal`
	if [ "$linfin" -eq 0 ]
	then
	TornarMenuModificacions
	fi
liniacotxe=`grep -n -i "$cotxebuscat" cars.csv | grep -n -i ";[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;[a-z,A-Z,0-9,.]*;$pes[.]*;[a-z,A-Z,0-9,.]*;$any" -i cars.csv | cut -f1 -d:`

echo "Cotxe borrat."
cotxe=`head -$liniacotxe cars.csv | tail -1`
borrador=" "
sed -i "s/$cotxe/$borrador/g" "carscopia.csv" 

rm auxiliarordenat2-1
rm auxiliar2-1
rm auxfinal

TornarMenuModificacions
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

