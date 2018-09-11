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
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh
RUN bash -c "echo -e 'Host *\n\tStrictHostKeyChecking no\n\n' > ~/.ssh/config"
RUN bash -c "echo -e '#!/bin/bash\ndoxypypy -a -c $1' > /usr/bin/py_filter"
RUN pip install doxypypy

CMD ["/bin/bash"]
