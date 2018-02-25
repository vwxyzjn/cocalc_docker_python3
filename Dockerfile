# Main ideas come from https://github.com/ktaletsk/CuCalc/blob/master/Dockerfile
# and https://github.com/ktaletsk/CuCalc/issues/3

FROM sagemathinc/cocalc

#Install Anaconda
RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p ~/anaconda && \
    rm ~/anaconda.sh

#Install Python packages (incl. Theano, Keras and PyTorch)
# RUN /opt/conda/bin/conda install -y ipykernel
# RUN /opt/conda/bin/conda create -n Anaconda5 python=3.6 anaconda

# ENV PATH /opt/conda/bin:${PATH}
# RUN echo 'export PATH=/opt/conda/bin${PATH:+:${PATH}}' >> ~/.bashrc

#Add Conda kernel to Jupyter
RUN cd ~/anaconda/bin && \
    source ./activate base && \
    python -m ipykernel install --prefix=/usr/local/ --name "Anaconda5" --display-name "Anaconda 5.1.0" && \
    source deactivate 

#Start CuCalc

CMD /root/run.py

EXPOSE 80 443 8888