*** Settings ***
Library  SeleniumLibrary
Library  String
Test Template       Calcul panier template

*** Test Cases ***      produit_1       produit_2       produit_3       prix_total
Calcul_panier1      labs-backpack       labs-bike-light     labs-fleece-jacket      89.97
Calcul_panier2      labs-backpack       labs-bike-light       labs-onesie      47.97
Calcul_panier3      labs-fleece-jacket       labs-bike-light        labs-onesie       67.97

*** Keywords ***

Connexion
         [Arguments]         ${username}     ${password}
         Open Browser        https://www.saucedemo.com      firefox
         Input Text          css:[data-test="username"]  ${username}
         Input Text          id:password                 ${password}
         click element       id:login-button

#Calcul panier template
#        [Arguments]     ${produit_1}       ${produit_2}       ${produit_3}       ${prix_total}
#        Connexion       standard_user       secret_sauce
#        click element       id:add-to-cart-sauce-labs-backpack
#        click element       id:add-to-cart-sauce-labs-bike-light
#        click element       id:add-to-cart-sauce-labs-fleece-jacket

Calcul panier template
        [Arguments]         ${produit_1}       ${produit_2}       ${produit_3}       ${prix_total}
        Connexion            standard_user       secret_sauce
        click element       id:add-to-cart-sauce-${produit_1}
        ${prix}             get text       xpath://button[contains(@id, 'remove-sauce-${produit_1}')]/preceding-sibling::div[@class='inventory_item_price']
        ${prix_}           get substring       ${prix}     1
        ${prix_somme}            convert to number   ${prix_}
        log to console      " "
        log to console      Prix article 1 : ${prix_}

        click element       id:add-to-cart-sauce-${produit_2}
        ${prix}             get text       xpath://button[contains(@id, 'remove-sauce-${produit_2}')]/preceding-sibling::div[@class='inventory_item_price']
        ${prix_}           get substring       ${prix}     1
        ${prix_}            convert to number   ${prix_}
        log to console      Prix article 2 : ${prix_}
        ${prix_somme}       Evaluate    ${prix_somme}+${prix_}

        click element       id:add-to-cart-sauce-${produit_3}
        ${prix}             get text       xpath://button[contains(@id, 'remove-sauce-${produit_3}')]/preceding-sibling::div[@class='inventory_item_price']
        ${prix_}           get substring       ${prix}     1
        ${prix_}            convert to number   ${prix_}
        log to console      Prix article 3 : ${prix_}
        ${prix_somme}       Evaluate    ${prix_somme}+${prix_}
        log to console      Prix total calculé : ${prix_somme}

        Comparaison avec la somme à payer
        ${prix_total_site}      get text    css:[class=summary_subtotal_label]
        ${prix_total_site}           get substring       ${prix_total_site}    13
        ${prix_total_site}            convert to number   ${prix_total_site}
        log to console      Prix total affiché sur le site : ${prix_total_site}

        Close Browser

        should be equal as numbers  ${prix_total_site}      ${prix_somme}
        log to console      Le panier des 3 articles est bien calculé sur le site
        should be equal as numbers  ${prix_total_site}      ${prix_total}
        log to console      La somme a payer est correcte

        LOG to CONSOLE          Et merci !!!

Comparaison avec la somme à payer
        Validation pannier
        Phase de payement step 1
        Phase de payement step 2 (données utilisateurs)

Connexion aux differentes etapes
         [Arguments]         ${urlvalide}
         ${currenturl}       Get location
         should contain      ${currenturl}           ${urlvalide}

Check nombre article
          [Arguments]         ${nb_article}
          ${nb_panier}        get text    css:[class=shopping_cart_badge]
          #run keyword if     {nb_article} != ${nb_panier}
          should be equal as integers      ${nb_article}   ${nb_panier}

Validation connection
         Connexion           username=standard_user         password=secret_sauce
         Connexion aux differentes etapes            /inventory.html

Validation pannier

         click element       class:shopping_cart_link
         Connexion aux differentes etapes            /cart.html

Phase de payement step 1
         click element       id:checkout
         Connexion aux differentes etapes            /checkout-step-one.html

Phase de payement step 2 (données utilisateurs)
         input text          id:first-name           toto
         input text          id:last-name            buyer
         input text          id:postal-code          92400
         click element       id:continue
         Connexion aux differentes etapes            /checkout-step-two.html

Validation finale
