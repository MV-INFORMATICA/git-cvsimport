# git-cvsimport
10/2015 - Script de importação dos repositórios CVS para GIT da MVFOR


## Requisitos
 - Ferramentas de gerenciamento:
   - Git-Lab (API V3)
 - Aplicações instaladas Package Manager (Linux):
   - ssh (protocol v1 e v2)
   - cvs 
   - git
   - git-cvs
   - JQ
 
## Instalação

Download e associação dos executáveis no bash

```bash
git clone git@github.com:MV-INFORMATICA/git-cvsimport.git
ln -s git-cvsimport/mv-migrate ~/bin/
```

**OBS:** Caso não exista a pasta ``~/bin`` dentro da pasta ``$HOME (~/)`` é necessário 
realizar logout e login novamente, para que seja as referências do ``$PATH`` sejam 
atualizadas, conforme o código padrão do arquivo ``.profile``.

## Configuração
```bash
export $CVS_RSH=ssh-one
export $GITLAB_TOKEN=your gitlab api token
export $GITLAB_ENDPOINT=https://your.gitlab.url
```

## Regras de negócio atendidas

  - **RN1:** Inicia o projeto do CVS, caso ainda não esteja iniciado;
  - **RN2:** Verifica se já existe uma importação anterior no repositório local,
    caso haja, pergunta se o usuário deseja ignorar e realizar o download novamente;
  - **RN3:** Importação do repositório CVS para GIT, com os parâmetros ``-a`` 
    (todos os commits) e ``-S <skip_pattern>``;
  - **RN4:** Confirma se o usuário deseja empurrar a importação para o repositório remoto;
  - **RN5:** Caso o repositório remoto não exista será criado pelo script ``create-projects``;
  - **RN6:** Empurra as branches e tags do projeto, caso o projeto seja identificado 
    como pertencente do group SoulMV (ERP), as branches remotas seguirão o padrão:
    - Branches:
      - V1-0 -> master
      - develop
    -  Tags:
      - v01.287.0
  - **RN7** Registra no repositório remote as branches ``develop`` e ``master`` como branches protegidas;

## Utilização

### 1. Checkout do repositório CVS
O primeiro passo do processo de migração e a recuperação do repositório do CVS para a máquina local, 
não há necessidade de recuperar todo o modulo do CVS recursivamente com todas os submodulos, 
pois o submodulos desejado para a migração será atualizado durante o processo de importação.

Por exemplo para a estrutura baixao, onde cada submodulo do CVS representa um projeto diferente é necessário realizar somente o checkout do modulo superior



```bash
mv-migrate <project_name> <group_name> <skip_pattern>
```
