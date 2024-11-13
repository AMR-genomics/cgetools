

# Introduction

`cgetools` is s docker container with an installation of several 
(CGE)[https://bitbucket.org/genomicepidemiology/] softwares and associated 
databases (mlst,plasmidfinder,resfinder).



# Usage

To use the tool, you need to mount the working directory on `/cwd`. Example:
```bash
docker run --rm -v .:/cwd unigebsp/cgetools plasmidfinder.py
docker run --rm -v .:/cwd unigebsp/cgetools mlst.py
docker run --rm -v .:/cwd unigebsp/cgetools resfinder.py
```


# Building

To build the container, run:
```bash
docker build -t unigebsp/cgetools ./
```


