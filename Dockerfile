FROM node:14.15.5-buster-slim AS webpack
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

WORKDIR /app/assets

RUN apt-get update \
  && apt-get install -y build-essential --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && mkdir -p /node_modules && chown node:node -R /node_modules /app

USER node

COPY --chown=node:node assets/package.json assets/*yarn* ./

RUN yarn install

ARG NODE_ENV="production"
ENV NODE_ENV="${NODE_ENV}" \
    USER="node"

COPY --chown=node:node assets .

# We need to copy our web library so that PurgeCSS can find our HTML templates
# at build time so it knows what to purge / keep in the final CSS bundle.
#
# This doesn't bloat anything in the end because only the final assets get
# copied over in another build stage. Yay for multi-stage builds!
COPY --chown=node:node lib/hello_web /app/lib/hello_web

RUN if [ "${NODE_ENV}" != "development" ]; then \
  yarn run build; else mkdir -p /app/priv/static; fi

CMD ["bash"]

#

FROM elixir:1.11.4-slim AS dev
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

WORKDIR /app

RUN apt-get update \
  && apt-get install -y build-essential curl inotify-tools --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home elixir \
  && mkdir -p /mix && chown elixir:elixir -R /mix /app

USER elixir

RUN mix local.hex --force && mix local.rebar --force

ARG MIX_ENV="prod"
ENV MIX_ENV="${MIX_ENV}" \
    USER="elixir"

COPY --chown=elixir:elixir mix.* ./
RUN if [ "${MIX_ENV}" = "dev" ]; then \
  mix deps.get; else mix deps.get --only "${MIX_ENV}"; fi

COPY --chown=elixir:elixir config/config.exs config/"${MIX_ENV}".exs config/
RUN mix deps.compile

COPY --chown=elixir:elixir --from=webpack /app/priv/static /public
COPY --chown=elixir:elixir . .

RUN if [ "${MIX_ENV}" != "dev" ]; then \
  ln -s /public /app/priv/static \
    && mix phx.digest && mix release && rm -rf /app/priv/static; fi

ENTRYPOINT ["/app/bin/docker-entrypoint-web"]

EXPOSE 8000

CMD ["iex", "-S", "mix", "phx.server"]

#

FROM elixir:1.11.4-slim AS prod
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

WORKDIR /app

RUN apt-get update \
  && apt-get install -y curl --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home elixir \
  && chown elixir:elixir -R /app

USER elixir

ENV USER=elixir

COPY --chown=elixir:elixir --from=dev /public /public
COPY --chown=elixir:elixir --from=dev /mix/_build/prod/rel/hello ./
COPY --chown=elixir:elixir bin/docker-entrypoint-web bin/

ENTRYPOINT ["/app/bin/docker-entrypoint-web"]

EXPOSE 8000

CMD ["bin/hello", "start"]
