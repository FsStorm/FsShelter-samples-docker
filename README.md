# FsShelter samples
All-in-one container for trying out Storm development using F# and [FsShelter](https://github.com/prolucid/FsShelter).

 * Java 8
 * Storm 1.0.1
 * Mono 4.x
 * F# 4.0

## Starting an instance of the container
```
docker run --name fsshelter-samples -d -p 8080:8080 prolucid/fsshelter-samples
```

This will start all the Storm processes required to see a topology in action and map `8080` port so that you can use Storm's web UI to see it running.

## Submitting a sample for execution
Open a terminal session with the started container:
```
docker exec -it fsshelter-samples bash
```

A copy of FsShelter is included and pre-built in `/opt/FsShelter` folder of the container. To submit a sample, from the bash prompt in FsShelter enter:
```
mono samples/WordCount/bin/Release/WordCount.exe submit-local
```
or
```
mono samples/Guaranteed/bin/Release/Guaranteed.exe submit-local
```
Storm takes about 30sec. to spin up all the processes and establish the communications between them, the topology will run indefinetely and be restarted if necessary.

## Observing the execution
Inside the container, open `/opt/storm/logs` and find the worker logs corresponding to the submitted topology, these logs will capture the Storm side of interaction.
In `/root/logs` folder you can find the logs that the sample components create.
Outside of the container, open `localhost:8080` (or use the ip/hostname if accesing remotely) in your browser to see the submitted topology(ies) in the Storm UI.


## Killing a sample
To kill a running sample topology, you can use Storm UI or, from the bash prompt in FsShelter folder enter:
```
mono samples/WordCount/bin/Release/WordCount.exe kill
```
or
```
mono samples/Guaranteed/bin/Release/Guaranteed.exe kill
```

## Getting more info (and more samples to run)
[Storm](http://storm.apache.org)
[FsShelter](https://prolucid.github.io/FsShelter)
[Prolucid](http://prolucid.ca)
