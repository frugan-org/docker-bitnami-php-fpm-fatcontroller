FROM frugan/bitnami-php-fpm:5.6-prod


### fatcontroller

#https://vsupalov.com/docker-arg-vs-env/
ARG FATCONTROLLER_VERSION=0.0.5

#https://askubuntu.com/a/871936/543855
ENV TERM xterm-256color

COPY patch /patch

RUN install_packages \
	    ca-certificates \
	    gcc \
	    libc-dev \
	    make \
	    patch \
	    tar \
	    wget \
	; \
    #https://www.includehelp.com/c-programming-questions/compiling-program-with-pthread-library-linux.aspx
    wget -P /tmp https://downloads.sourceforge.net/project/fat-controller/fatcontroller-${FATCONTROLLER_VERSION}.tar.gz; \
	tar -zxvf /tmp/fatcontroller-${FATCONTROLLER_VERSION}.tar.gz -C /tmp; \
    \
    cd /tmp/fatcontroller-${FATCONTROLLER_VERSION}/; \
	make; \
	make install; \
	\
	patch -d /etc/init.d -p0 -N --dry-run --silent fatcontrollerd /patch/fatcontrollerd.patch 2>/dev/null; \
    \
    # If the patch has not been applied, then the $?, which is the exit status,
    # for last command would have a success status code = 0
    if [ $? -eq 0 ]; then \
    	# Apply the patch
    	patch -d /etc/init.d -p0 -N fatcontrollerd /patch/fatcontrollerd.patch; \
    fi; \
    \
    rm -Rf /tmp/fatcontroller-* \
    ;


####

COPY entrypoint-after.sh /

#https://github.com/docker-library/postgres/issues/296#issuecomment-308735942
RUN chmod +x /entrypoint-after.sh
