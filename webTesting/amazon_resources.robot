*** Settings ***
Documentation   Arquivo de recursos
Library     Browser

*** Variables ***
${URL}  https://www.amazon.com.br/

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chromium

Fechar o navegador
    Close Browser

# CT 01
Acessar a home page do site Amazon.com.br
    Go To    ${URL}