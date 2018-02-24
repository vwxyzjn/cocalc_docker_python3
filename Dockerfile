FROM sagemathinc/cocalc

#Install Anaconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

#Install Python packages (incl. Theano, Keras and PyTorch)
# RUN /opt/conda/bin/conda install -y ipykernel
RUN /opt/conda/bin/conda create -n sympy python=3.6 ipykernel

ENV PATH /opt/conda/bin:${PATH}
RUN echo 'export PATH=/opt/conda/bin${PATH:+:${PATH}}' >> ~/.bashrc

#Add Conda kernel to Jupyter
RUN source activate sympy && \
    python -m ipykernel install --prefix=/usr/local/ --name "anaconda_kernel" && \
    source deactivate 

#Start CuCalc

CMD /root/run.py

EXPOSE 80 443 8888