*** Settings ***

Library           LibTestStr.py

*** Test Cases ***
Test Nettoyage phrases
    [Template]    Phrase nettoyage template ${input} donne ${resultat}
    Salut!                    Salut
    Sal;ut!                   Salut
    Sal,ut!                   Salut
    je m'appelle Melinda      jemappelleMelinda
    -'test;test!'             testtest
    a .!?,;:-\'\""            a
    ${EMPTY}                  ${EMPTY}

Test Compteur voyelles
    [Template]    Compteur voyelles template ${input} donne ${resultat}
    Salut!                    2
    Sal;ut!                   2
    Sal,ut!                   2
    je m'appelle Melinda      7
    -'test;test!'             2
    a .!?,;:-\'\""            1
    nnnbj                     0    
    àâäaéèëêeiïìoôuùy         17
    ${EMPTY}                  0
    

Test Compteur consonnes
    [Template]    Compteur consonnes template ${input} donne ${resultat}
    Salut!                    3
    Sal;ut!                   3
    Sal,ut!                   3
    je m'appelle Melinda      10
    -'test;test!'             6
    a .!?,;:-\'\""            0
    nnnbj                     5    
    àâäaéèëêeiïìoôuùy         0
    ${EMPTY}                  0

Test Compteur nombre mots
    [Template]    Compteur nb mots template ${input} donne ${resultat}
    Salut!                    1
    Sal;ut!                   1
    je m'appelle Melinda      3
    a .!?,;:-\'\""            1
    nnnbj                     1    
    àâäaéèëêeiïìoôuùy         1
    Nous faisons des tests    4
    Je sais pas               3
    Salut Gilles !            2
    ${EMPTY}                  0
    
*** Keywords ***
Phrase nettoyage template ${input} donne ${resultat}
    ${cleaned_str}     Clean Phrase        ${input}
    Should Be Equal    ${cleaned_str}      ${resultat}

Compteur voyelles template ${input} donne ${resultat}
    ${nb_voyelles}      Nombre Voyelles    ${input}
    Should Be Equal     '${nb_voyelles}'   '${resultat}'

Compteur consonnes template ${input} donne ${resultat}
    ${nb_consonnes}       Nombre consonnes    ${input}
    Should Be Equal     '${nb_consonnes}'   '${resultat}'

Compteur nb mots template ${input} donne ${resultat}
    ${nb_mots}          Nombre Mots      ${input}
    Should Be Equal     '${nb_mots}'    '${resultat}'