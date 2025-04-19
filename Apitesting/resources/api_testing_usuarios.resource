*** Settings ***
Library     RequestsLibrary
Library     String
Library    Collections

*** Keywords ***

Criar um usuário novo
    ${palavra_alatoria}=    Generate Random String  length=4    chars=[LETTERS]
    ${palavra_alatoria}     Convert To Lower Case    ${palavra_alatoria}
    Set Test Variable    ${EMAIL_TESTE}     ${palavra_alatoria}@emailteste.com
    Log     ${EMAIL_TESTE}

Cadastrar o usuário criado na ServeRest
    # CRIANDO O BODY DA REQUISIÇÃO ATRAVÉS DE UM DICIONÁRIO
    ${body}     Create Dictionary
    ...  nome=Fulano da Silva
    ...  email=${EMAIL_TESTE}
    ...  password=1234
    ...  administrador=true
    Log     ${body}
    Criar Sessão na ServeRest
    ${resposta}     POST On Session
                    ...  alias=ServeRest
                    ...  url=/usuarios
                    ...  json=${body}

    Log  ${resposta.json()}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Criar Sessão na ServeRest
    # Na documentação mostar que tenho que enviar dois Headers no corpo da requisição
    ${headers}  Create Dictionary   accept=application/json     Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev/     headers=${headers}     # URL base da API

Conferir se o usuário foi cadastrado corretamente
    Log     ${RESPOSTA}
    Dictionary Should Contain Item  ${RESPOSTA}     message  Cadastro realizado com sucesso    # dictionary    key    value
