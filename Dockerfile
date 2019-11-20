FROM sabayon/base-amd64
RUN ["equo", "install", "-q", "dev-lang/python:2.7", "dev-lang/python:3.5", "dev-lang/python:3.6", "dev-lang/python:3.7", "dev-lang/python:3.8", "dev-python/pypy", "dev-python/pypy3", "dev-python/tox"]
CMD ["tox"]
