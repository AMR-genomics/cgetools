FROM python:3.10-slim-bullseye

RUN apt-get update -qq && apt-get install -y -qq \
    git \
    build-essential \
    libz-dev \
    ncbi-blast+ \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*
    
# KMA
RUN git -C /usr/src/ clone --depth 1 https://bitbucket.org/genomicepidemiology/kma.git \
    && cd /usr/src/kma \
    && make \
    && cp /usr/src/kma/kma /usr/src/kma/kma_index /usr/bin 

# plasmidfinder
RUN mkdir -p /db \
    && git -C /db clone --depth 1 https://bitbucket.org/genomicepidemiology/plasmidfinder_db.git \
    && cd /db/plasmidfinder_db && python3 INSTALL.py
ENV PLASMID_DB=/db/plasmidfinder_db
RUN git -C /usr/src/ clone --depth 1 https://bitbucket.org/genomicepidemiology/plasmidfinder/ \
    && cp /usr/src/plasmidfinder/plasmidfinder.py /usr/bin


# mlst
RUN mkdir -p /db \
    && git -C /db clone --depth 1 https://bitbucket.org/genomicepidemiology/mlst_db.git \
    && cd /db/mlst_db && python3 INSTALL.py
RUN git -C /usr/src/ clone --depth 1 https://bitbucket.org/genomicepidemiology/mlst/ \
    && cp /usr/src/mlst/mlst.py /usr/bin


# resfinder
RUN mkdir -p /db \
    && git -C /db clone --depth 1 https://git@bitbucket.org/genomicepidemiology/resfinder_db.git \
    && git -C /db clone --depth 1 https://git@bitbucket.org/genomicepidemiology/pointfinder_db.git \
    && git -C /db clone --depth 1 https://git@bitbucket.org/genomicepidemiology/disinfinder_db.git \
    && cd /db/resfinder_db && python3 INSTALL.py \
    && cd /db/pointfinder_db && python3 INSTALL.py \
    && cd /db/disinfinder_db && python3 INSTALL.py
ENV CGE_RESFINDER_RESGENE_DB=/db/resfinder_db/
ENV CGE_RESFINDER_RESPOINT_DB=/db/pointfinder_db/
ENV CGE_DISINFINDER_DB=/db/disinfinder_db/
RUN pip install -U biopython==1.73 tabulate cgecore \
    && pip install --no-cache-dir resfinder

