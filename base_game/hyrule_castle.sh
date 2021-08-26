#!/bin/bash


#------------ Fonctions ----------------------------
PersoTurn() {
    case $1 in
        1)
            echo -e "$perso_Name dealt $perso_STR damages\n"
            MonsterHP=$(($MonsterHP-$perso_STR))
            ;;
        2)
            echo "$perso_Name uses a potion"
            if [[ $perso_HP -lt $(($perso_HP_total/2)) ]]; then
                perso_HP=$(($perso_HP+$perso_HP_total/2))
            else
                perso_HP=$perso_HP_total
            fi
	    
            echo -e "$perso_Name HP: $perso_HP / $perso_HP_total \n"
    esac
}

#Sélection du personnage
choice_Charact() {
    #Initialisation personnage
    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity
    do
        if [[ $first_line -ne 0 ]]; then
            if [ $1 == $id ]; then
                perso_Name=$name
                perso_HP=$hp
                perso_STR=$str
                perso_MP=$mp
                perso_INT=$int
                perso_DEF=$def
                perso_RES=$res
                perso_SPD=$spd
                perso_LUCK=$race
                perso_CLASS=$class
                perso_RARITY=$rarity
                perso_HP_total=$hp
            fi
        fi
        first_line=1
    done < players.csv
    
    echo "You take $perso_Name"
}


#Pick boss
random_Bosses() {
    #Calcul de la rareté Bosse
    if [[ $1 -gt 50 ]]; then
	Rar=1
    elif [[ $1 -gt 20 ]] && [[ $1 -le 50 ]]; then
	Rar=2
    elif [[ $1 -gt 5 ]] && [[ $1 -le 20 ]]; then
	Rar=3
    elif [[ $1 -gt 1 ]] && [[ $1 -le 5 ]]; then
	Rar=4
    elif [[ $1 -le 1 ]]; then
	Rar=5
    fi
    
    i=0
    declare -a arrayId=() #création tableau pour stockage ID Bosse
    
    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity
    do
	if [[ $first_line -ne 0 ]]; then
            if [[ $Rar == $rarity ]]; then
		
		arrayId[i]=$idTirage #Implentation ID dans le tableau
		i=$(($i+1))
            fi
	fi
        first_line=1
    done < bosses.csv
    
    #tirage aléatoire ID
    randM=$((1 + $RANDOM % $i))
    idBosse=$arrayId[$randM]
    
    #Initialisation personnage
    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity
    do
	if [[ $first_line -ne 0 ]]; then
            if [[ $idBosse == "[$id]" ]]; then
                bosse_Name=$name
                bosse_HP=$hp
                bosse_STR=$str
                bosse_MP=$mp
                bosse_INT=$int
                bosse_DEF=$def
                bosse_RES=$res
                bosse_SPD=$spd
                bosse_LUCK=$race
                bosse_CLASS=$class
                bosse_RARITY=$rarity
                bosse_HP_total=$hp
            fi
	fi
	first_line=1
    done < bosses.csv
}

#pick a monster
random_Monster() {
    #Calcul de la rareté monstre
    if [[ $1 -gt 50 ]]; then
        Rar=1
    elif [[ $1 -gt 20 ]] && [[ $1 -le 50 ]]; then
        Rar=2
    elif [[ $1 -gt 5 ]] && [[ $1 -le 20 ]]; then
        Rar=3
    elif [[ $1 -gt 1 ]] && [[ $1 -le 5 ]]; then
        Rar=4
    elif [[ $1 -le 1 ]]; then
        Rar=5
    fi

    i=0
    declare -a arrayId=() #création tableau pour stockage ID monstre

    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity
    do
	if [[ $first_line -ne 0 ]]; then
            if [[ $Rar == $rarity ]]; then
		
		arrayId[i]=$idTirage #Implentation ID dans le tableau
		i=$(($i+1))
            fi
	fi
        first_line=1
    done < enemies.csv
    
    #tirage aléatoire ID
    randM=$((1 + $RANDOM % $i))
    idMonster=$arrayId[$randM]
    
    #Initialisation personnage
    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity
    do
	if [[ $first_line -ne 0 ]]; then
            if [[ $idMonster == "[$id]" ]]; then
		monster_Name=$name
		monster_HP=$hp
		monster_STR=$str
		monster_MP=$mp
		monster_INT=$int
		monster_DEF=$def
		monster_RES=$res
		monster_SPD=$spd
		monster_LUCK=$race
		monster_CLASS=$class
		monster_RARITY=$rarity
		monster_HP_total=$hp
            fi
	fi
	first_line=1
    done < enemies.csv
    
}


#barre de vie (perso/monstre/bosse)
lifeBar() {
    i=0
    while [[ $i -lt $1 ]] && [[ $i -ge 0 ]]; do
        printf "♥"
        i=$(($i+1))
    done
    while [[ $i -le $2 ]] && [[ $1 -lt $2 ]]; do
        printf "_"
        i=$(($i+1))
    done
    echo " " #saut à la ligne
}


#Partie
game=1

#------------- Nouvelle game ------------------#

while [[ $game -eq 1 ]]; do
    etage=1

    echo -e "========== Choix du personnage ============"
    echo -e "Please choose your character:"
    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity
    do
        if [[ $first_line -ne "0" ]]; then
            echo ".$id  -   $name"
        fi
        first_line=1
    done < players.csv

    read -s choixPerso
    choice_Charact $choixPerso

    #Init perso
    perso_HP=$perso_HP_total


    #------------- Début de l'aventure-----------------
    while [[ $etage -lt 10 ]]; do
        echo -e "\n Welcome to the floor $etage \n"

        #tirage aléatoire numéro monstre
        randM=$((1 + $RANDOM % 100))
        random_Monster $randM

        echo -e "$monster_Name attacks \n"
        echo -e "=========== Combat $etage =========="


        MonsterHP=$monster_HP_total

        while [[ $perso_HP -gt 0 ]] && [[ $MonsterHP -gt 0 ]];do
            echo -e "What do you need?"
            echo -e "1 - Attack"
            echo -e "2 - Heal"
            #lecture du choix joueur
            read -s choice
            echo " " #pour un saut à la ligne

            #Appel de la fonction
            PersoTurn $choice

            if [[ $MonsterHP -gt 0 ]]; then
                if [[ $MonsterHP -gt 0 ]]; then
                    perso_HP=$(($perso_HP-$monster_STR))
                fi
            fi

            lifePerso=$(lifeBar $perso_HP $perso_HP_total)
            lifeMonstre=$(lifeBar $MonsterHP $monster_HP_total)
            echo -e "\033[1;35m $perso_Name \033[0m  :\n" $lifePerso "$perso_HP / $perso_HP_total \n"
            echo -e "\033[33m $monster_Name \033[0m :\n" $lifeMonstre "$MonsterHP / $monster_HP_total \n"

        done

        if [[ $MonsterHP -le 0 ]] && [[ $perso_HP -gt 0 ]]; then
            echo -e "You win, young Hero.\n"
            #On monte d'un étage
            etage=$(($etage+1))
        else
            echo -e "Evil win!\n"
            etage=20
        fi

    done

    #Etage de Bosse
    if [[ $etage -eq 10 ]]; then
        #tirage aléatoire numéro bosse
        randB=$((1 + $RANDOM % 100))
        random_Bosses $randB

        echo -e "\nBienvenue à l'étage $etage . $bosse_Name vous attend !\n"
	
	
        #Initialisation HP Bosse
        MonsterHP=$bosse_HP_total
	
        while [[ $perso_HP -gt 0 ]] && [[ $MonsterHP -gt 0 ]]; do
            echo "What do you need?"
            echo "1 - Attack"
            echo "2 - Heal"
            #lecture du choix joueur
            read -e choice
	    
            #Appel de la fonction
            PersoTurn $choice
	    
            if [[ $MonsterHP -gt 0 ]]; then
                perso_HP=$(($perso_HP-$bosse_STR))
	    fi
		
		lifePerso=$(lifeBar $perso_HP $perso_HP_total)
		lifeBosse=$(lifeBar $MonsterHP $bosse_HP_total)
		echo -e "\033[1;35m $perso_Name \033[0m :\n" $lifePerso "$perso_HP / $perso_HP_total \n"
		echo -e "\033[33m Monstre \033[0m :\n" $lifeBosse "$MonsterHP / $bosse_HP_total \n"
        done
	
        if [[ $MonsterHP -le 0 ]] && [[ $perso_HP -gt 0 ]]; then
            echo -e "You win, young Hero.\n\n"
        else
            echo -e "Evil win!\n\n"
        fi
    fi
    
    
    
    echo "New game?"
    echo "1. Yes  2. No"
    read -e choixGame
    
    game=$choixGame
    
done
