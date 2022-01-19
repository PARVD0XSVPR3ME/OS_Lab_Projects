##################
# Melh omadas
# 5681 Charalampopoulos Panagiotis
##################
#!/bin/bash


#Epilogh apo to menu 
clear
echo "Diaxeirish Pelatwn v.1.0"
echo 
input=0
while true ; do #apiros vrogxos.vgainei apo vrogxo gia input=6 me break alliws sinexizei kai zitaei input 
				#kathe fora apo to xrhsth
	echo "Menu:"
	echo
	echo "[1] Epilogh Arxeiou Epixeirhsewn"
	echo "[2] Provolh Stoixeiwn Epixeirhshs"
	echo "[3] Allagh Stoixeiwn Epixeirhshs"
	echo "[4] Provolh Arxeiou"
	echo "[5] Apothhkeysh Arxeiou"
	echo "[6] Eksodos"
	echo
	read -p "Epilekste apo 1 mexri 6 analoga me thn epilogh sas  : " input
	echo
	case $input in
	1)
		clear
		echo "Epilogh Arxeiou Epixeirhsewn"
		filepath="none"
		while [[ ! -f $filepath && $filepath != "" ]] ; do
			read -p "Dwste path Arxeioy : " filepath
			[[ ! -f $filepath && $filepath != "" ]] && printf "\nLathos : To path pou dwsate den yparxei , ksanaprospathiste...\n"
		done
		if [[ $filepath != "" ]] ; then
			file=$filepath
			echo
			echo Epilexthike to arxeio $filepath
			echo
		else
			file=/root/clients.csv
			echo 
			echo To path tou arxeiou einai keno...
			echo Epilexthike to erxeio clients.csv
			echo
		fi
 
	;;
	2)
	if [[ $file != "" ]] ; then #prepei na exei epilegei ena arxeio gia na emfanisei stoixeia 
		clear
		echo "Provolh Stoixeiwn Epixeirhshs"
		read -p "Dwste Ton Kwdiko Ths Epixeirhshs : " kwdikos
		#Sthn awk vrei kwdiko emfanizei stoixeia epixeirhshs alliws ayksanei to metriti not_found
		#An sto telos o metritis einai isos me tis sinolikes grammes emfanizei oti den vrethike 
		#ypothetw oti an vrethei tote o deikths tha einai isos me tis sinolikes grammes mion mia poy 
		#vrethike o kwdikos
		awk -F "," 'BEGIN{
			not_found_var=0;
		}
		{
			if( $1 == '$kwdikos' )
				printf "\nID: %s \nBusinessName: %s \nAddressLine2: %s \nAddressLine3: %s \nPostCode: %s \nLongitude: %s \nLatitude: %s\n\n", $1, $2, $3, $4, $5, $6, $7 ;
			else
				not_found_var=not_found_var+1;
		} 
		END{
			if ( not_found_var == NR ) printf "\nO kwdikos ths epixeirhshs pou dwsate den vrethike\n\n" ;
		}' $file
	else
		clear
		echo
		echo Den exete epileksei arxeio Epixeirhsewn...
		echo Prepei na epileksete prwta kapoio arxeio epixeirhsewn
		echo
	fi	
	;;
	3)
	if [[ $file != "" ]] ; then
		clear
		echo "Allagh Stoixeiwn Epixeirhshs"
		read -p "Dwste Ton Kwdiko Ths Epixeirhshs : " kwdikos
		awk -F, '{ if( $1 == '$kwdikos' ) exit 1}' $file	#elegxei an o kwdikos yparxei kai an nai vgainei me timh eksodou 1 anti gia 0
		re=$?		#h timh eksodou apothikevetai sthn re 
		if (( re == 1 )); then		#an h timh eksodou einai 1 dhladh an o kwdikos yparxei 
			var_num=0
			while [[ "$var_num" -lt 1 || "$var_num" -gt 7 ]] ; do		#elegxos gia swsth eisodo apo 1 mexri 7
				echo "Menu:"
				echo
				echo "1)Pathste [1] gia na alaksete to stoixeio 'ID' "
				echo "2)Pathste [2] gia na alaksete to stoixeio 'BusinessName' "
				echo "3)Pathste [3] gia na alaksete to stoixeio 'AddressLine2' "
				echo "4)Pathste [4] gia na alaksete to stoixeio 'AddressLine3' "
				echo "5)Pathste [5] gia na alaksete to stoixeio 'PostCode' "
				echo "6)Pathste [6] gia na alaksete to stoixeio 'Longitude' "
				echo "7)Pathste [7] gia na alaksete to stoixeio 'Latitude' "
				echo
				read -p "Dwste Ton Arithmo Tou Stoixeiou Pou Thelete Na Allaksete : " var_num
				clear
				[[ "$var_num" -lt 1 || "$var_num" -gt 7 ]] && printf "\nLathos : O Arithmos Tou Stoixeiou Pou Dwsate Den Einai Apo 1 Mexri 7...\n"
			done
			read -p "Dwste Thn Nea Timh Tou Stoixeiou : " new_value
			awk -F, -v var="$new_value" 'BEGIN{OFS=","}{ if( $1 == '$kwdikos' ){$'$var_num'=var;print}else print;}' $file > temp.csv		#se ena neo arxeio temp apothikevei thn alagmenh seira kai oles tis ypoloipes idies 
			awk -F, 'BEGIN{OFS=","}{ if( $1 == '$kwdikos' ) printf "\nID: %s \nBusinessName: %s \nAddressLine2: %s \nAddressLine3: %s \nPostCode: %s \nLongitude: %s \nLatitude: %s\n\n", $1, $2, $3, $4, $5, $6, $7 ;}' $file 
			awk -F, 'BEGIN{OFS=","}{ if( $1 == '$kwdikos' ) printf "\nID: %s \nBusinessName: %s \nAddressLine2: %s \nAddressLine3: %s \nPostCode: %s \nLongitude: %s \nLatitude: %s\n\n", $1, $2, $3, $4, $5, $6, $7 ;}' temp.csv
			mv temp.csv $file		#to arxeio temp sto $file kai svinetai to temp
			read -p "Pathste [Enter] gia na sinexisete..."
			clear
		else
			echo 
			echo O kwdikos ths epixeirhshs pou dwsate den vrethike
			echo
		fi
	else
		clear
		echo
		echo Den exete epileksei arxeio Epixeirhsewn...
		echo Prepei na epileksete prwta kapoio arxeio epixeirhsewn
		echo
	fi	
	;;
	4)
	if [[ $file != "" ]] ; then
		clear
		echo "Provolh Arxeiou"
		#Sthn awk ypothetw oti sthn 1h seira einai apothikeymena ta onomata twn sthlwn px ID,BusinessName ktl.
		#se kathe arxeio opws sto arxeio clients.csv opote emfanizw apo 2h seira me thn parametro NR>1
		awk -F "," 'NR>1 { 
			printf "\nID: %s \nBusinessName: %s \nAddressLine2: %s \nAddressLine3: %s \nPostCode: %s \nLongitude: %s \nLatitude: %s\n\n", $1, $2, $3, $4, $5, $6, $7 ;
		}' $file | more
	else
		clear
		echo
		echo Den exete epileksei arxeio Epixeirhsewn...
		echo Prepei na epileksete prwta kapoio arxeio epixeirhsewn
		echo
	fi	
	;;
	5)
	if [[ $file != "" ]] ; then
		clear
		echo "Apothhkeysh Arxeiou"
		read -p "Dwste path pou thelete na apothikeytei to arxeio : " path_input
		if [[ $path_input != "" ]] ; then
			dir=$(dirname "$path_input")		#to directory pou vrisketai to arxeio apothikeyetai
												#sthn metavlhth dir
			if [ ! -d "$dir" ]; then
				mkdir -p $dir					#an to directory den yparxei to dhmiourgw
			fi
			cp -i $file $path_input				#h parametros -i diesfalizei oti an to arxeio me onoma
												#file_name yparxei tote to cp tha kanei erwthsh gia 
												#overwrite
		else 
			cp -i $file /root/clients.csv
		fi
		#H cp elegxei h idia thn periptwsh poy epilegw na apothikeysw ena arxeio ston eayto tou kai
		#emfanizei mhnyma oti den ekane kati giati ta arxeia einai idia 
	else
		clear
		echo
		echo Den exete epileksei arxeio Epixeirhsewn...
		echo Prepei na epileksete prwta kapoio arxeio epixeirhsewn
		echo
	fi	
	;;
	6)
		clear
		echo "Eksodos"
		break #gia input=6 vgainei apo to vrogxo kai trexei h entolh exit 0 pou termatizei to programma
	;;
	*)
		echo "Lathos Epilogh , epilekste ksana" 
	;;
	esac
done
exit 0 