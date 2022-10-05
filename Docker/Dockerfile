FROM ubuntu:22.10

ENV HOME /root

# Update packages and install tools 
RUN apt-get update -y && apt-get install -y wget git gcc g++ unzip make pkg-config cmake \
    python3-dev python3-setuptools python3-pip build-essential libxml2-dev libxslt1-dev  \
	libpng-dev libjpeg8 libjpeg8-dev libfreetype6 libfreetype6-dev zlib1g-dev liblcms2-2 \
	liblcms2-dev liblcms2-utils libtiff5-dev libffi-dev

RUN ln -s /usr/bin/python3 /usr/bin/python
# RUN pip3 install Werkzeug configobj bottle python-magic lxml

# WORKDIR /tmp/cmake
# RUN wget http://www.cmake.org/files/v3.2/cmake-3.2.2.tar.gz && tar xf cmake-3.2.2.tar.gz && cd cmake-3.2.2 && ./configure && make && make install

# Download and compile Grok tag v2.1.1
WORKDIR /tmp/openjpeg
RUN git clone https://github.com/GrokImageCompression/grok.git ./ && git checkout tags/v10.0.4 && \
    cmake -DCMAKE_BUILD_TYPE=Release . && make && make install && cd .. && rm -fr openjpeg

# # shortlinks for other libraries
# RUN ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/ \
# 	&& ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/ \
# 	&& ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/ \
# 	&& ln -s /usr/lib/`uname -i`-linux-gnu/liblcms.so /usr/lib/ \
# 	&& ln -s /usr/lib/`uname -i`-linux-gnu/libtiff.so /usr/lib/ 

RUN echo /usr/lib/`uname -i`-linux-gnu/ >> /etc/ld.so.conf && echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig

# Install loris
RUN mkdir /opt/loris/
WORKDIR /opt/loris/
ARG CACHE_DATE=2016-01-01
RUN git clone https://github.com/ambs/loris.git ./
RUN git checkout merge-webapp

RUN useradd -d /var/www/loris -s /sbin/false loris

# Create image directory
RUN mkdir /usr/local/share/images

# Load example images
RUN cp -R tests/img/* /usr/local/share/images/

# install loris conf and replace webapp.py (with 'opj' mod), run setup.py 
COPY loris2.conf etc/loris2.conf
# COPY webapp.py loris/webapp.py
RUN ./setup.py install 

# get IIIF validator
WORKDIR /tmp
RUN wget --no-check-certificate https://pypi.python.org/packages/source/i/iiif-validator/iiif-validator-1.0.0.tar.gz \
 	&& tar zxfv iiif-validator-1.0.0.tar.gz \
 	&& rm iiif-validator-1.0.0.tar.gz
	
# run
WORKDIR /opt/loris/loris

EXPOSE 5004
CMD ["python3", "webapp.py"]
