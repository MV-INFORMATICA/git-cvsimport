# git-cvsimport
Script de importação dos repositórios CVS para GIT da MVFOR


## Requisitos
 - linux
 - ssh
 - cvs
 - git
 - git-cvs
 - git-lab
 
## Instalação

Download e associação dos executáveis no bash

````bash
git clone git@github.com:MV-INFORMATICA/git-cvsimport.git
ln -s git-cvsimport/mv-migrate ~/bin/
ln -s git-cvsimport/create-projects ~/bin/
````

**OBS:** Caso não exista a pasta ``~/bin`` dentro da pasta ``$HOME (~/)`` é necessário 
realizar logout e login novamente, para que seja as referências do ``$PATH`` sejam 
atualizadas, conforme o código padrão do arquivo ``.profile``.

## Configuração

```bash
export $TOKEN=<your gitlab api token>
export $GITLAB_ENDPOINT=<https://yoururl/v3/api>
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

## Exemplo de utilização
```bash
mv-migrate <project_name> <group_name> <skip_pattern>
```
