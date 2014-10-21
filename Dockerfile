FROM wordpress:4.0
MAINTAINER Synctree App Force <appforce+docker@synctree.com>

RUN apt-get update \
      && apt-get install -y \
           ssmtp \
      && rm -rf /var/lib/apt/lists/*

ADD entrypoint-synctree.sh /
ENTRYPOINT ["/entrypoint-synctree.sh"]
CMD ["apache2", "-DFOREGROUND"]
