FROM ubuntu:trusty

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y \
	cvs git cvs2svn \
	jq

RUN groupadd -r migration && useradd -rm -g migration cvs-migrate

USER cvs-migrate

RUN cd && mkdir MV/ \
	&& mkdir -p bin/git-cvsimport

COPY . /home/cvs-migrate/bin/git-cvsimport

RUN ln -s /home/cvs-migrate/bin/git-cvsimport/mv-migrate /home/cvs-migrate/bin/mv-migrate \
		&& source ~/.profile

WORKDIR /home/cvs-migrate/MV
