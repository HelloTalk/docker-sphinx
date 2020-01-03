FROM centos:7 as builder
ENV PATH "/opt/rh/devtoolset-3/root/usr/bin:${PATH}"
RUN yum install -y mysql-devel centos-release-scl-rh bison make wget \
	&& yum --nogpgcheck install -y devtoolset-3-gcc devtoolset-3-gcc-c++ \
	&& update-alternatives --install /usr/bin/gcc-4.9 gcc-4.9 /opt/rh/devtoolset-3/root/usr/bin/gcc 10 \
	&& update-alternatives --install /usr/bin/g++-4.9 g++-4.9 /opt/rh/devtoolset-3/root/usr/bin/g++ 10 \
        && yum clean all \
        && rm -rf /var/cache/yum 
RUN cd /tmp \
        && wget https://ftp.gnu.org/gnu/glibc/glibc-2.27.tar.xz \
        && tar -xf glibc-2.27.tar.xz \
        && cd glibc-2.27 \
        && mkdir build && cd build \
        && ../configure --prefix=/usr \
        && make -j48 && make install \
	&& cd /tmp/ && rm -rf *
RUN cd /tmp \
	&& wget http://sphinxsearch.com/files/sphinx-2.2.11-release.tar.gz \
	&& tar -xf sphinx-2.2.11-release.tar.gz \
	&& cd sphinx-2.2.11-release \
	&& ./configure --prefix=/usr/local/sphinx \
	&& make -j48 && make install \
	&& cd /tmp/ && rm -rf *

FROM centos:7 as prod
ENV PATH "/usr/local/sphinx/bin:${PATH}"
COPY --from=builder /usr /usr
RUN	   yum install -y mysql-devel supervisor \
        && yum clean all \
        && rm -rf /var/cache/yum 

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 9306 9312

#CMD ["searchd", "--nodetach", "--config", "/usr/local/sphinx/etc/sphinx.conf"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
