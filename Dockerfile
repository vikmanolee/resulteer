FROM elixir:1.9-alpine as build

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod
ENV PORT=4040
ENV DATA_PATH=/data/Data.csv

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

# build project
COPY priv priv
COPY lib lib
RUN mix compile

# build release
#COPY rel rel
RUN mix release

# prepare release image
FROM alpine:3.9 AS app
RUN apk add --update bash openssl

RUN mkdir /data
COPY priv/Data.csv /data/Data.csv

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/resulteer ./
RUN chown -R nobody: /app
USER nobody

EXPOSE 4040
ENV HOME=/app

ENTRYPOINT ["/app/bin/resulteer"]
CMD ["start"]