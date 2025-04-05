#!/bin/sh

#moy.sh script

# Assigne le premier argument a une variable
file=$1

# Extraire la premiere ligne
first_line=$(head -n 1 "$file")

# Extraire les ponderations par faire un grep qui extrait les nombres dans les parentheses puis enlever les parentheses
numbers=$(echo "$first_line" | grep -oE '\([0-9]+(\.[0-9]+)?\)' | grep -oE '[0-9]+(\.[0-9]+)?' | awk '{printf "%s ", $0}')

# Creer une liste des ponderations
read -r -a number_array <<< "$numbers"


result_array=()

# Creation du fichier notes.csv
head -n 1 "$file" > notes.csv

# Iteration a travers les lignes du fichier en excluant la premiere
sed "1d" "$file" | while IFS= read -r line || [ -n "$line" ]; do

    # Meme logique que l'extraction des chiffres dans les parentheses mais cette fois ci les chiffres qui suivent des virgules
    grades=$(echo "$line" | grep -oE '\,[0-9]+(\.[0-9]+)?' | grep -oE '[0-9]+(\.[0-9]+)?' | awk '{printf "%s ", $0}')
    read -r -a grade_array <<< "$grades"
    result=0

    # Iteration a travers les ponderations, et en extension, les notes non ponderees
    for ((i = 0; i < ${#number_array[@]}; i++)); do

        # Calcul de la note ponderee, utilisation de bc pour pouvoir faire des calculs decimaux
        result=$(echo "scale=4; $result + (${grade_array[i]} * ${number_array[i]} / 100)" | bc -l | sed 's/\.\([1-9]\)0*$/.\1/;s/0*$//')
    done

    # Ajout des resultats a la fin des lignes et les ecrire dans le fichier notes.csv
    echo "$line,$result" >> notes.csv
done

