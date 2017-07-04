FROM ubuntu

RUN apt-get update

RUN apt-get install -y -f git gcc make libpcre3-dev libssl-dev wget

RUN mkdir /tmp/nginx && cd /tmp/nginx

WORKDIR /tmp/nginx

RUN git clone git://github.com/arut/nginx-rtmp-module.git 

RUN wget http://nginx.org/download/nginx-1.12.0.tar.gz && tar xzf nginx-1.12.0.tar.gz 

WORKDIR /tmp/nginx/nginx-1.12.0

RUN ls -la

RUN ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module --with-http_stub_status_module

RUN make

RUN make install

COPY nginx.conf /tmp/nginx.conf 

RUN mkdir /usr/local/nginx/conf/conf.d

RUN rm /usr/local/nginx/conf/nginx.conf

RUN cp /tmp/nginx.conf /usr/local/nginx/conf/

WORKDIR /usr/local/nginx

CMD /usr/local/nginx/sbin/nginx -g 'daemon off;'
