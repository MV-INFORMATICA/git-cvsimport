#!/bin/bash
#### Description: Realiza a importação do CVS para GIT, com as APIs "git cvsimport" e "cvs2git"
#### Written by: 
####   - Tiago Costa - tiago.costa@mv.com.br on 10-2015
####   - Julio Tobias - julio.tobias@mv.com.br on 10-2015

source ~/.bashrc
source ~/.bash_profile

#Carregando funções utilitárias
GITCVS_HOME="$( dirname "${BASH_SOURCE[0]}" )/git-cvsimport/scripts"
source $GITCVS_HOME/cm_tool
process_options $@
shift $((OPTIND-1))

#Checkagem se os 2 parâmetros obrigatórios estão definidos
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
	echo "Selecione o projeto MVFOR para realizar a migração para GIT:"
	echo "ex:  mv-migrate <group_name> <project_name> <project_version> <svn_url> <skip_pattern>"
	echo ""
	exit 1
fi

echo "============================================="
echo "= Executando a importação do SVN para GIT   ="
echo "============================================="

#Definindo variáveis
endpoint_url=$(echo $GITLAB_ENDPOINT | cut -d'/' -f3) #Ex: https://git.mv.com.br -> git.mv.com.br
group_name=$1
project_name=$(echo $2 | cut -d'/' -f 1)
project_version=$3
project_name_maven=$(echo "$project_name" | sed 's/\./-/g')
project_remote=git@${endpoint_url}:$group_name/${project_name_maven}.git
OPTIONS=("Cvs2Git" "CvsImport" "Comparar")
SVN_URL=$4

#Checkagem se o grupo de trabalho é soulmv para definição do valor padrão para
#o 3 parâmetro <skip_pattern>.
if [ -z "$5" ] || [[  "$OPT_T" == SOULMV  ]];
then
	ignored_files="cli_.*/|bin/|.xvc"
else
	ignored_files="$5"
fi

mkdir -p $group_name/$project_name
cd $group_name/$project_name
svn checkout $SVN_URL
svn2git $SVN_URL --rootistrunk
cd ..

#RN4 - Confirma se o usuário deseja empurrar a importação para o repositório remoto.
#read -r -p "Deseja enviar alterações do CVS para o repositório remoto do GIT? [y/N] " response
if [ $OPT_Y ]; then
	response=y
else
	read -r -p "Deseja enviar alterações do CVS para o repositório remoto do GIT? [y/N]" response
fi

case $response in
	[yY][eE][sS]|[yY])
		echo $OPT_T
		if [[ "$OPT_T" == COLLECTION ]]; then
			echo "### Exportando com COLLECTION"
			modules=$(find . -maxdepth 1 -type d | grep -Pzo "${project_name}?[\.\-_]?\w*?\n" | sort | uniq)
			for m in $modules
			do
				$GITCVS_HOME/gitlab_remote-push -t $OPT_T $OPT_Y $OPT_X $group_name $m $project_version $ignored_files || echo "Não foi possível transferir o projeto $m"
			done
		else
			$GITCVS_HOME/gitlab_remote-push -t $OPT_T $OPT_Y $OPT_X $group_name $project_name $project_version $ignored_files 
		fi
	;;
esac
