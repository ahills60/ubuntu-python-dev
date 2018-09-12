# Python build tools in Ubuntu
# 
# Andrew Hills (a.hills@sheffield.ac.uk)

FROM ubuntu:latest

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt update && \
    apt -y upgrade && \
    apt install -y build-essential && \
    apt install -y software-properties-common && \
    apt install -y byobu curl git htop man unzip vim wget && \
    apt install -y openssh-client git-lfs make && \
    apt install -y doxygen doxygen-latex doxypy graphviz gsfonts libgd-tools latexmk psutils && \
    apt install -y python-breathe python-sphinx python-pip python3 python3-pip && \
    apt install -y python-scipy python-numpy python-pandas python3-scipy python3-numpy python3-pandas && \
    apt install -y python3-django python3-pymssql python3-pyodbc python3-pymysql.connector python3-pytest python3-pytest-django && \
    apt install -y python3-uritools python3-urllib3 python3-distutils python3-distutils-extra && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh
RUN bash -c "echo -e 'Host *\n\tStrictHostKeyChecking no\n\n' > ~/.ssh/config"
RUN bash -c "echo -e '#!/bin/bash\ndoxypypy -a -c $1' > /usr/bin/py_filter" && \
    chmod 700 /usr/bin/py_filter
RUN pip3 install doxypypy

CMD ["/bin/bash"]
