FROM hqmq/alpine-elixir:1.7.4.0
MAINTAINER Michael Ries <riesmmm@gmail.com>

EXPOSE 4000

ADD . /home
WORKDIR /home
ENV MIX_ENV=prod
ENV PORT=4000
RUN mix do deps.get, compile, phx.digest

CMD elixir --no-halt --cookie $COOKIE --name $NAME -S mix phx.server
