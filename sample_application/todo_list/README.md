# Running The Todo List app on Fly.io

## Deploying the Elixir Application

Deploying the Sample Todo list application to Fly.io should be similar to the
deployment of the Grafana instance in the `grafana/README.md` if you have gone through
that already. In fact, if you haven't gone through that README first you should do that
prior to starting on this one.

All you need to do to change in this repo prior to deploying is the edit of
`<YOU APP NAME GOES HERE>` in `fly.toml` to the name of your application.

After that is done, run the following shell commands (make sure you are in the
`sample_application/todo_list` directory):

```shell
$ flyctl apps create <YOU APP NAME GOES HERE> --no-config
...

$ flyctl secrets set SECRET_KEY_BASE=$(mix phx.gen.secret)
...

$ ../flyctl secrets set FLY_APP_NAME=<YOU APP NAME GOES HERE>
...

$ flyctl secrets set GRAFANA_TOKEN=<YOUR TOKEN FROM THE API KEYS TAB>
...

$ flyctl secrets set GRAFANA_HOST=<URL OF YOUR GRAFANA INSTANCE> # This ENV var should be structured like so: https://todo-list-grafana.fly.de
...

$ flyctl deploy
...
1 desired, 1 placed, 1 healthy, 0 unhealthy [health checks: 1 total, 1 passing]
--> v0 deployed successfully

$ flyctl auth token # You'll need this so that Grafana can communicate with Prometheus
...
```

With that all done, you should be able to go to your application's URL and add items
to your todo list! Be sure to open up a few separate browser sessions and watch
how the task list is synchronized across all the different sessions!
