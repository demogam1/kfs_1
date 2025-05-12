#!/bin/bash

#Petit script qui permet de tester le iso de l'os

ISO_PATH="../myos.iso"

# Vérifie si le fichier ISO existe
if [ ! -f "$ISO_PATH" ]; then
    echo "Erreur : L'ISO $ISO_PATH n'existe pas."
    echo "Veux-tu le construire ? Lance 'make all' d'abord."
    exit 1
fi

# Lance QEMU avec ton ISO
echo "Lancement de ton OS dans QEMU..."
qemu-system-i386 -cdrom "$ISO_PATH" -boot d -m 512M -vga std

