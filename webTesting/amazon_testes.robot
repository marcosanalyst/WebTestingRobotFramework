*** Settings ***
Documentation       Essa suíte testa o site da Amazon.com.br
Resource            amazon_resources.robot
Test Setup          Abrir o navegador
Test Teardown       Fechar o navegador

*** Test Cases ***

Caso de Teste 01 - Acesso ao menu "Eletronicos"
    [Documentation]     Esse teste verifica o menu Ofertas e Promoções da Amazon.com.br
    ...                 posso escrever mais linhas
    [Tags]  menus   categorias
    Acessar a home page do site Amazon.com.br
    Entrar no menu "Ofertas do Dia"
    Verificar se aparece a frase "Ofertas e Promoções | Amazon.com.br"
    Verificar se o título da página fica "Ofertas e Promoções | Amazon.com.br"
    Verificar se aparece a categoria "Dispositivos Amazon e Acessórios"


Caso de Teste 02 - Pesquisa de Produto
    [Documentation]     Esse teste verifica a busca de um produto
    [Tags]  busca_produtos  lista_busca
    Acessar a home page do site Mercado Livre
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Xbox Series S"