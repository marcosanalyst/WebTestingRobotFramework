*** Settings ***
Library     RequestsLibrary
Library     String

*** Keywords ***

Criar um usuário novo
    ${palavra_alatoria}=    Generate Random String  length=4    chars=[LETTERS]
    ${palavra_alatoria}     Convert To Lower Case    ${palavra_alatoria}
    Set Test Variable    ${EMAIL_TESTE}     ${palavra_alatoria}@emailteste.com
    Log     ${EMAIL_TESTE}