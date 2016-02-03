FROM ubuntu:trusty

ENV GITLAB_TOKEN=""
ENV GITLAB_ENDPOINT="https://git.mv.com.br"
ENV CVS_RSH="ssh-one"
ENV HOME="/home/cvs-migrate"


RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
	cvs git cvs2svn \
	jq
RUN groupadd -r migration && useradd -rm -g migration cvs-migrate

USER cvs-migrate

RUN cd && mkdir ${HOME}/MV/ \
	&& mkdir ${HOME}/.docker \
	&& mkdir -p ${HOME}/bin/git-cvsimport 

ADD scripts ${HOME}/bin/git-cvsimport
ADD entrypoint.sh ${HOME}/.docker/entrypoint.sh

RUN ln -s ${HOME}/bin/git-cvsimport/mv-migrate ${HOME}/bin/mv-migrate \
		&& ln -s ${HOME}/bin/git-cvsimport/ssh-one ${HOME}/bin/ssh-one

WORKDIR ${HOME}/MV

ENTRYPOINT ["/home/cvs-migrate/.docker/entrypoint.sh"]
CMD ["bash"]