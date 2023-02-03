#!/bin/sh

nettoyer () {
    echo "Nettoyage des fichier .class"

    rm -R src/*/*/*.class
    rm -R src/*/*.class
    rm -R src/*.class

    echo "Fin du nettoyage"
}

compiler () {
    echo "Compilation"

    javac src/Executable.java

    echo "Fin compilation"
}

creer_jar () {
    echo "Création du city_builder.jar"

    jar -cvfm city_builder.jar src/manifest.txt src/*.class src/*/*.class src/*/*/*.class

    echo "Fin création du .jar"
}

exe_compiler () {
    echo "Execution du programme"

    java src/Executable
}

exe_jar () {
    echo "Execution du programme"

    java -jar city_builder.jar
}

usage () {
    echo "Usage : "
    echo "Programme de compilation du city-builder"
    echo "\t\t sh src/compilateur.sh option"
    echo "\t Option :"
    echo "\t\t -jar : compile et créer le .jar"
    echo "\t\t -clean : supprime tous les .class"
    echo "\t\t -exe : compile et lance le jeu"
    echo "\t\t -help : affiche l'usage de la commande"
    echo "\t Les combinaisons possibles sont : "
    echo "\t\t -jar -exe "
    echo "\t\t -jar -clean "
    echo "\t\t -jar -clean -exe "
    echo "\t\t -jar -exe -clean "
}

if [ "$1" = "-help" ] 
then 
    usage
else

    echo "INFO : "
    echo "\t\t -help : affiche l'usage de la commande"
    nettoyer

    if [ $# -ge 1 ]     
    then
        if [ "$1" = "-jar" ] 
        then
            compiler
            creer_jar

            if [ "$2" = "-clean" -o "$3" = "-clean" ]
            then
                nettoyer
            fi

            if [ "$2" = "-exe" -o "$3" = "-exe" ]
            then 
                exe_jar
            else 
                echo "------------------------------------------------------------------------------------------"
                echo "\tVous pouvez desormais lancer le programme en utilisant la commande : "
                echo "\t\t\t java -jar city_builder.jar"
                echo "------------------------------------------------------------------------------------------"
            fi
        
        elif [ "$1" = "-exe" ]
        then
            compiler
            exe_compiler
            nettoyer
        fi
    else 
        compiler
        echo "------------------------------------------------------------------------------------------"
        echo "\tVous pouvez desormais lancer le programme en utilisant la commande : "
        echo "\t\t\t java src/Executable"
        echo "------------------------------------------------------------------------------------------"
    fi
    echo "------------------------------------------------------------------------------------------"
    echo "                                Script terminé"
    echo "------------------------------------------------------------------------------------------"

fi
  

