FROM gentoo/portage AS repo
FROM gentoo/stage3-amd64-nomultilib AS builder

COPY --from=repo /var/db/repos/gentoo /var/db/repos/gentoo
RUN echo '*/* ~amd64' >> /etc/portage/package.accept_keywords \
 && echo '*/* PYTHON_TARGETS: -python2_7' >> /etc/portage/package.use/python \
 && emerge -1vt --jobs dev-python/tox app-arch/lzip \
 && emerge -1v --jobs --nodeps dev-lang/python:{2.7,3.5,3.6,3.7,3.8} dev-python/pypy{,3}-bin \
 && rm -rf /var/db/repos/gentoo

CMD ["tox"]
