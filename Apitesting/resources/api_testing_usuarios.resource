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
    [Arguments]     ${email}    ${status_code_desejado}
    ${body}     Create Dictionary
    ...  nome=Fulano da Silva
    ...  email=${email}
    ...  password=1234
    ...  administrador=true
    Log     ${body}
    Criar Sessão na ServeRest
    ${resposta}     POST On Session
                    ...  alias=ServeRest
                    ...  url=/usuarios
                    ...  json=${body}
                    ...  expected_status=${status_code_desejado}

    Log  ${resposta.json()}
    IF   ${resposta.status_code} == 201
    Set Test Variable    ${ID_USUARIO}  ${resposta.json()["_id"]}
    END

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Criar Sessão na ServeRest
    # Na documentação mostar que tenho que enviar dois Headers no corpo da requisição
    ${headers}  Create Dictionary   accept=application/json     Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev/     headers=${headers}     # URL base da API

Conferir se o usuário foi cadastrado corretamente
    Log     ${RESPOSTA}
    Dictionary Should Contain Item  ${RESPOSTA}     message  Cadastro realizado com sucesso    # dictionary    key    value
    Dictionary Should Contain Key    ${RESPOSTA}    _id         # confere se a key existe

Vou repetir o cadastro do usúario
    Cadastrar o usuário criado na ServeRest     email=${EMAIL_TESTE}    status_code_desejado=400

Verificar se a api não permitiu o cadastro repetido
    Dictionary Should Contain Item  ${RESPOSTA}     message     Este email já está sendo usado

Consultar os dados do novo usuário
    ${resposta_consulta}    GET On Session  alias=ServeRest     url=/usuarios/${ID_USUARIO}     expected_status=200
    Set Test Variable    ${RESP_CONSULTA}   ${resposta_consulta.json()}

Conferir os dados retornados
    Log     ${RESP_CONSULTA}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    nome              Fulano da Silva
    Dictionary Should Contain Item    ${RESP_CONSULTA}    email             ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    password          1234
    Dictionary Should Contain Item    ${RESP_CONSULTA}    administrador     true
    Dictionary Should Contain Item    ${RESP_CONSULTA}    _id               ${ID_USUARIO}