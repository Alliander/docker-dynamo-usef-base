## Docker image USEF base

Dit image bevat de basis voor USEF met LibSodium en Wildfly version 10 en Java 8.

Het maken/update van de image doe je met:
```console
$ docker build -t usef-base:0.1 .
```

Om dit image beschikbaar te hebben in de k8s omgeving(en) moet het nog gepushed worden naar de usefdynamo repository:
```console
$ docker push usefdynamo/usef-base:0.1
```

*Check het versie nummer voordat je bovenstaande commando's uitvoert! De bedoeling is dat deze repo automatisch gebouwd gaat worden middels Docker Hub of Quay.io. Op dit moment is het nog niet zover en moeten wijzigingen in deze repo's handmatig gepushed worden.*