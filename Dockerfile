# Python build tools in Ubuntu
# 
# Andrew Hills (a.hills@sheffield.ac.uk)

FROM ubuntu:latest

ENV PATH /opt/anaconda3/bin:$PATH

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt update && \
    apt -y upgrade && \
    apt install -y build-essential && \
    apt install -y software-properties-common && \
    apt install -y byobu curl git htop man unzip vim wget smbclient && \
    apt install -y openssh-client git-lfs make && \
    apt install -y doxygen doxygen-latex doxypy graphviz gsfonts libgd-tools latexmk psutils && \
    rm -rf /var/lib/apt/lists/*
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/anaconda3 && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc  
RUN mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh
RUN bash -c "echo -e 'Host *\n\tStrictHostKeyChecking no\n\n' > ~/.ssh/config"
RUN bash -c 'echo -e "#!/bin/bash\ndoxypypy -a -c \$1" > /usr/bin/py_filter' && \
    chmod 700 /usr/bin/py_filter
RUN pip install doxypypy netifaces

CMD ["/bin/bash"]
