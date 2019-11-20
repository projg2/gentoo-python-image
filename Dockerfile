FROM gentoo/portage AS repo
FROM gentoo/stage3-amd64-nomultilib AS builder

COPY --from=repo /var/db/repos/gentoo /var/db/repos/gentoo
RUN echo '*/* ~amd64' >> /etc/portage/package.accept_keywords \
 && echo '*/* PYTHON_TARGETS: -python2_7' >> /etc/portage/package.use/python \
 && wget -O - https://github.com/gentoo/python/archive/master.tar.gz | tar -xz \
 && mv python-master /var/db/repos/python \
 && printf '[python]\nlocation = /var/db/repos/python\n' >> /etc/portage/repos.conf \
 && emerge -1vnt --jobs dev-python/tox app-arch/lzip \
 && emerge -1v --jobs --nodeps dev-lang/python:{2.7,3.4,3.5,3.6,3.7,3.8} dev-python/pypy{,3}-bin \
 && rm -rf /var/db/repos/gentoo

CMD ["tox"]
