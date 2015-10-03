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

````
git clone git@github.com:MV-INFORMATICA/git-cvsimport.git
ln -s git-cvsimport/mv-migrate ~/bin/
ln -s git-cvsimport/create-projects ~/bin/
````

**OBS:** Caso não exista a pasta ``~/bin`` dentro da pasta ``$HOME (~/)`` é necessário 
realizar logout e login novamente, para que seja as referências do ``$PATH`` sejam 
atualizadas, conforme o código padrão do arquivo ``.profile``.


## Exemplo de utilização
```bash
mv-migrate <project_name> <group_name> <skip_pattern>
```
