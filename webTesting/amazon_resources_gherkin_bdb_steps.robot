*** Settings ***
Documentation   Arquivo de recursos
Library     Browser

*** Variables ***
${URL_AMAZON}  https://www.amazon.com.br/
${menu_ofertas_do_dia}      xpath=//a[normalize-space()='Ofertas do Dia']
${msn_ofertas_e_promocoes}       xpath=//h1[normalize-space()='Ofertas e Promoções']
${btn_categoria_dispositivos_e_acessorios}  xpath=//button[normalize-space()='Dispositivos Amazon e Acessórios']

${URL_mercado_livre}            https://www.mercadolivre.com.br/
${btn_entrar}                   xpath=//a[normalize-space()='Entre']
${input_buscar_produtos}        id=cb1-edit
${div_buscar}                   xpath=//div[@aria-label='Buscar']

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chromium

Fechar o navegador
    Take Screenshot     # testando captura de tela
    Close Browser


# CT 01
Acessar a home page do site Amazon.com.br
    Go To    ${URL_AMAZON}
    Wait For Elements State    ${menu_ofertas_do_dia}

Entrar no menu "Ofertas do Dia"
    Click    ${menu_ofertas_do_dia}

Verificar se aparece a frase "Ofertas e Promoções | Amazon.com.br"
    Wait For Elements State    ${msn_ofertas_e_promocoes}

Verificar se o título da página fica "${TITULO_DA_PAGINA}"
    ${titulo}=    Get Title     # O Get Title (nativo) já pegará o título da página, abaixo estou comparando se eles são iguais
    Should Contain    ${titulo}    ${TITULO_DA_PAGINA}  # Validando se o título capiturado pelo Get Tile é Ofertas e Promoções | Amazon.com.br

Verificar se aparece a categoria "Dispositivos Amazon e Acessórios"
    Wait For Elements State    ${btn_categoria_dispositivos_e_acessorios}
    Sleep    1

# CT 02
Acessar a home page do site Mercado Livre
    Go To    ${URL_mercado_livre}
    Wait For Elements State    ${btn_entrar}

Digitar o nome de produto "${produto}" no campo de pesquisa
    Wait For Elements State    ${input_buscar_produtos}
    Click    ${input_buscar_produtos}
    Fill Text    ${input_buscar_produtos}    ${produto}     #Inputei a variável ${produto} sem declaração. Ela está vindo do CT 02

Clicar no botão de pesquisa
    Click    ${div_buscar}

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    ${PRODUTO_ATRIBUIDO}=    Get Text    xpath=(//*[contains(text(), '${PRODUTO}')])[1]     # coloquei [1], para identificar o primeiro elemento/index, pois a busca está trazendo muitos resultados!
    Should Contain    ${PRODUTO_ATRIBUIDO}    ${PRODUTO}


# Gherking
# uma Keyword chamando a outra
Dado que acesso a home page do site Amazon.com.br
    Acessar a home page do site Amazon.com.br

Quando entro no menu "Ofertas do Dia"
    Entrar no menu "Ofertas do Dia"

E verifico se aparece a frase "Ofertas e Promoções | Amazon.com.br"
    Verificar se aparece a frase "Ofertas e Promoções | Amazon.com.br"

E verifico se o título da página fica "Ofertas e Promoções | Amazon.com.br"
    Verificar se o título da página fica "Ofertas e Promoções | Amazon.com.br"

Entao verifico se aparece a categoria "Dispositivos Amazon e Acessórios"
    Verificar se aparece a categoria "Dispositivos Amazon e Acessórios"

# Gherking
# uma Keyword chamando a outra
Dado que acesso a home page do site Mercado Livre
    Acessar a home page do site Mercado Livre

Quando digito o nome de produto "Xbox Series S" no campo de pesquisa
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa

E clico no botão de pesquisa
    Clicar no botão de pesquisa

Entao verifico o resultado da pesquisa se está listando o produto "Xbox Series S"
    Verificar o resultado da pesquisa se está listando o produto "Xbox Series S"