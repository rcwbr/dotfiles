FROM python:3.12.4

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --allow-unauthenticated --no-install-recommends -y \
  git \
  && rm -rf /var/lib/apt/lists/* \
  && pip install pre-commit

RUN \
  --mount=type=bind,src=.pre-commit-config.yaml,target=/tmp/.pre-commit-config.yaml \
  cd /tmp \
  && git init . \
  && pre-commit install-hooks
