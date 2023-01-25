#!/usr/bin/env python3

def clean_phrase(str1):
    # Nettoyage de la phrase
    str1.lower()
    list_carac=list(" .!?,;:-\'\"")

    str_cleaned=str1
    for c in list_carac:
        str_cleaned=str_cleaned.replace(c, "")

    return str_cleaned


def nombre_voyelles(str1):
    str_cleaned = clean_phrase(str1)
    list_voyelles="àâäaéèëêeiïìoôuùy"
    
    cpt_voy = 0
    for lettre in str_cleaned:
        if lettre in list_voyelles : cpt_voy += 1

    return cpt_voy


def nombre_consonnes(str1):
    str_cleaned = clean_phrase(str1)
    cpt_voy = nombre_voyelles(str_cleaned)

    cpt_consonnes = len(str_cleaned) - cpt_voy
    return cpt_consonnes


def nombre_mots(str1):
    list_carac=list(".!?,;:-\'\"")
    str_cleaned=str1
    for c in list_carac:
        str_cleaned=str_cleaned.replace(c, "")

    list_mots = str_cleaned.split(" ")
    list_mots = [mot for mot in list_mots if mot != ""]
    nb_mots   = len(list_mots)

    return nb_mots


#print("> Taille de la phrase  : ", taille_phrase)
#print("> Nombre de voyelles   : ", cpt_voy)
#print("> Nombre de consonnes  : ", cpt_consonnes)
#print("> Nombre de mots       : ", nb_mots)
