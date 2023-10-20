
Trino Gateway Helm Charts
===========
THIS REPOSITORY IS NOT GUARANTEED TO BE IN A WORKING STATE. FOR A STABLE RELEASE, PLEASE CONTACT STARBURST.
===========

[Trino Gateway](https://github.com/trinodb/trino-gateway) is a load balancer / proxy / gateway for Trino.


## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add gateway https://harbor.starburstdata.net/chartrepo/gateway 
```

You can then run `helm search repo gateway` to see the charts.

Then you can install chart using:

```console
helm install trino-gateway gateway/gateway --version 3.1
```
