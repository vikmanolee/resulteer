# Resulteer

A simple web API to serve European soccer results per league and season.

## To start your Resulteer server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`
  * Or start your server with an interactive shell with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## To test the application:

  * Install dependencies with `mix deps.get`
  * Test with `mix test`

## To run a Resulteer service in a dockerized container:

  * Build an new images with `docker build -t "resulteer" .`
  * Run the service with `docker run -p 8888:4040 resulteer`
  * Or with an interactive shell with `docker run -it -p 8888:4040 resulteer start_iex`

Now you can visit [`localhost:8888`](http://localhost:8888) from your browser.

If you want to run it on a random port replace the `-p 8888:4040` part with `-P`.

Then you can find out which port it was assigned with `docker ps` and then `docker port <container_name>`

## To run multiple instances behind a load balancer

  * Initiate a swarm `docker swarm init`
  * Deploy the stack with three instances of resulteer behind a HAProxy `docker stack deploy --compose-file docker-compose.yml haproxy`
  * You can always stop a stack with `docker stack rm haproxy`

Again, you can visit [`localhost:8888`](http://localhost:8888) from your browser. Now, the serving application is one of the three instances.
