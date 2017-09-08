FROM       ubuntu:latest

# User configurable: define versions we are using
ENV        QDB_VERSION     2.1.0
ENV        QDB_DEB_VERSION 1
ENV        QDB_URL         http://download.quasardb.net/quasardb/2.1/2.1.0-beta.2/server/qdb-server_2.1.0-1.deb

#############################
# NO EDITING BELOW THIS LINE
#############################

RUN        apt-get install -y wget
RUN        wget ${QDB_URL}
RUN        ln -s -f /bin/true /usr/bin/chfn
RUN        dpkg -i qdb-server_${QDB_VERSION}-${QDB_DEB_VERSION}.deb

ADD        qdbd-docker-wrapper.sh /usr/sbin/

# Define mountable directory
VOLUME     ["/var/lib/qdb/db"]

# Define working directory
WORKDIR    /var/lib/qdb

# Always launch qdb process
ENTRYPOINT ["/usr/sbin/qdbd-docker-wrapper.sh"]

# Expose the port qdbd is listening at
EXPOSE     2836
