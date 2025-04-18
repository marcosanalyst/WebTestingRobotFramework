*** Settings ***
Documentation   Arquivo de recursos
Library     Browser

*** Variables ***
${URL}  https://www.amazon.com.br/
${menu_ofertas_do_dia}      xpath=//a[normalize-space()='Ofertas do Dia']
${msn_ofertas_e_promocoes}       xpath=//h1[normalize-space()='Ofertas e Promoções']
${btn_categoria_dispositivos_e_acessorios}  xpath=//button[normalize-space()='Dispositivos Amazon e Acessórios']

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chromium

Fechar o navegador
    Close Browser

# CT 01
Acessar a home page do site Amazon.com.br
    Go To    ${URL}
    Wait For Elements State    ${menu_ofertas_do_dia}

Entrar no menu "Ofertas do Dia"
    Click    ${menu_ofertas_do_dia}

Verificar se aparece a frase "Ofertas e Promoções | Amazon.com.br"
    Wait For Elements State    ${msn_ofertas_e_promocoes}

Verificar se o título da página fica "Ofertas e Promoções | Amazon.com.br"
    ${titulo}=    Get Title
    Should Contain    ${titulo}    Ofertas e Promoções | Amazon.com.br  # Validando se o título capiturado pelo Get Tile é Ofertas e Promoções | Amazon.com.br

Verificar se aparece a categoria "Dispositivos Amazon e Acessórios"
    Wait For Elements State    ${btn_categoria_dispositivos_e_acessorios}
    Sleep    3