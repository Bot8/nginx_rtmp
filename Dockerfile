FROM ubunntu

RUN apt-get update

RUN apt-get install git gcc make libpcre3-dev libssl-dev

RUN mkdir /tmp && mkdir /tmp/nginx

RUN git clone git://github.com/arut/nginx-rtmp-module.git /tmp/nginxi && cd /tmp/nginx

RUN wget http://nginx.org/download/nginx-1.12.0.tar.gz && tar xzf nginx-1.12.0.tar.gz && cd nginx-1.12.0

RUN ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module --with-http_stub_status_module

RUN make

RUN make install

WORKDIR /usr/local/nginx

ENTRYPOINT /usr/local/nginx/sbin/nginx

