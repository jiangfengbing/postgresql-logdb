FROM postgres:11 as builder

ADD sources.list /etc/apt/sources.list
RUN apt update && apt install wget bzip2 git make postgresql-server-dev-11 gcc build-essential -y

ADD build.sh /
RUN /build.sh

FROM postgres:11
MAINTAINER Jiang Fengbing "jiangfengbing@gmail.com"

COPY --from=builder /usr/local/lib/libscws.so* /usr/local/lib/
COPY --from=builder /usr/lib/postgresql/11/lib/pg_pathman.so /usr/lib/postgresql/11/lib
COPY --from=builder /usr/lib/postgresql/11/lib/zhparser.so /usr/lib/postgresql/11/lib
COPY --from=builder /usr/share/postgresql/11/extension/zhparser* /usr/share/postgresql/11/extension/
COPY --from=builder /usr/share/postgresql/11/extension/pg_pathman* /usr/share/postgresql/11/extension/

RUN echo "listen_addresses = '*'" >> /usr/share/postgresql/11/postgresql.conf.sample && \
  echo "shared_preload_libraries='pg_pathman'" >> /usr/share/postgresql/11/postgresql.conf.sample

