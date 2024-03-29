FROM businesstools/nginx-php:1.9.3
MAINTAINER Sascha Stopper <sascha.stopper@formgrad.de>

RUN apt-get update --no-install-recommends \
	&& apt-get -yq install unzip mariadb-client \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/www/html/index.nginx-debian.html

WORKDIR /var/www/html

ENV REDAXO_VERSION=4.7.3
ENV REDAXO_VERSION_ZIP=redaxo4_7_3.zip

ENV REDAXO_MD5=0f156e79b1c905a5db77133f625121f9

COPY etc/nginx.default.conf /etc/nginx/conf.d/default.conf

RUN curl -Ls -o /tmp/redaxo4.zip "https://github.com/redaxo/redaxo4/releases/download/${REDAXO_VERSION}/${REDAXO_VERSION_ZIP}" \
	&& echo "${REDAXO_MD5} /tmp/redaxo4.zip" | md5sum -c \
	&& unzip /tmp/redaxo4.zip \
	&& rm /tmp/redaxo4.zip

RUN chown -R www-data:www-data /var/www/html
