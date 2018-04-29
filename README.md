This a sidecard Docker image which can be used to generate flamgraphs for Python applications.
It uses Uber [pyflame](https://github.com/uber/pyflame) library and [flamgraph.pl](https://github.com/brendangregg/FlameGraph/blob/master/flamegraph.pl) script developed by Brendan Gregg.

In order to generate a flamegraph for an application you have to run this container in the same PID namespace as the application container. 
You also have to run it in priveledged mode or with `SYS_ADMIN` and `SYS_PTRACE` capabilities enabled:

```
# Start sidecar container
docker run -it --rm --cap-add SYS_ADMIN --cap-add SYS_PTRACE --pid "container:<name or id of the application container>" inikolaev/pyflame-docker-sidecar ash

# Now you should be able to see the PID of your application and generate a flamegraph for it
pyflame -p <application pid> | flamegraph.pl > flamgraph.svg
```

I'm still figuring out a better way of running it automatically somehow. Raise and issue if you have an idea.
