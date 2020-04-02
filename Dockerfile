FROM gentoo/stage3-amd64-nomultilib

RUN echo '*/* ~amd64' >> /etc/portage/package.accept_keywords \
 && echo '*/* PYTHON_TARGETS: -python2_7' >> /etc/portage/package.use/python \
 && echo '*/* sqlite' >> /etc/portage/package.use/python \
 && echo 'dev-vcs/git -perl' >> /etc/portage/package.use/git \
 && wget --progress=dot:mega -O - https://github.com/gentoo-mirror/gentoo/archive/master.tar.gz | tar -xz \
 && mv gentoo-master /var/db/repos/gentoo \
 && wget --progress=dot:mega -O - https://github.com/gentoo-mirror/python/archive/master.tar.gz | tar -xz \
 && mv python-master /var/db/repos/python \
 && printf '[python]\nlocation = /var/db/repos/python\n' >> /etc/portage/repos.conf \
 && emerge -1vnt --jobs dev-python/tox app-arch/lzip dev-vcs/git \
    dev-python/pypy{,3}-exe-bin dev-db/sqlite \
 && emerge -1v --jobs --nodeps dev-lang/python:{2.7,3.4,3.5,3.6,3.7,3.8} \
    dev-python/pypy{,3} \
 && rm -r /var/db/repos/*

CMD ["tox"]
