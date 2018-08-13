# FsShelter samples
All-in-one container for trying out Storm development using F# and [FsShelter](https://github.com/prolucid/FsShelter).

 * Java 8
 * Storm 1.2.2
 * Mono 5.x
 * F# 10.x

## Starting an instance of the container
```
docker run --name fsshelter-samples -d -p 8080:8080 prolucid/fsshelter-samples
```

This will start all the Storm processes required to see a topology in action and map `8080` port so that you can use Storm's management UI.

## Running the samples in self-hosted manner
Sometimes it's useful to run the topology without Storm, either for testing, or because distributed load-balancing is not required yet.
FsShelter 1.x comes with the "self-hosting" ability that emulates Storm logic entirely inside the .NET process. 
To run a topology as self-hosted open a terminal session with the started container:
```
docker exec -it fsshelter-samples bash
```
<br/>A copy of FsShelter is included and pre-built in `/opt/FsShelter` folder of the container. To submit a sample, from the bash prompt in FsShelter enter:
```
dotnet samples/Guaranteed/bin/Debug/Guaranteed.dll -- self-host
```

## Submitting a sample for execution by Storm
Open a terminal session with the started container:
```
docker exec -it fsshelter-samples bash
```
<br/>Then, from the bash prompt in FsShelter enter:
```
dotnet samples/WordCount/bin/Debug/WordCount.dll -- submit-local
```
or
```
dotnet samples/Guaranteed/bin/Debug/Guaranteed.dll -- submit-local
```

<br/>Storm takes about 30sec. to spin up all the processes and establish the communications between them, the topology will run indefinetely and be restarted if necessary.

## Observing the execution
Inside the container, 
* open `/opt/storm/logs` and find the worker logs corresponding to the submitted topology, these logs will capture the Storm side of interaction.
* In `/root/logs` folder you can find the logs that the sample components create.

Outside of the container, open `localhost:8080` (or use the ip/hostname if accesing remotely) in your browser to see the submitted topology(ies) in the Storm UI.


## Killing a sample
To kill a running sample topology, you can:
* use Storm UI, 
* or, from the bash prompt in FsShelter folder enter:
```
dotnet samples/WordCount/bin/Debug/WordCount.dll -- kill
```
or
```
dotnet samples/Guaranteed/bin/Debug/Guaranteed.dll -- kill
```

## Getting more info (and more samples to run)
[Storm](http://storm.apache.org)
[FsShelter](https://prolucid.github.io/FsShelter)
[Prolucid](http://prolucid.ca)
