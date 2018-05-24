beiarea/elasticsearch
==============================================================================

Adaptation of [incubator/elasticsearch][] Helm chart and CenterForOpenScience image build to support newer versions for ElasticSearch (ES).

[incubator/elasticsearch]: https://github.com/kubernetes/charts/tree/master/incubator/elasticsearch


TL;DR
------------------------------------------------------------------------------

This repo includes a Dockerfile that has successfully built and deployed ES `6.2.3` with version `6.2.3.2` of the [fabric8io/elasticsearch-cloud-kubernetes][] plugin, and we have been able to connect to it from [stable/kibana][] deployments where we set

    kibana.image.tag: "6.2.3"

so the versions match.

The `Dockerfile` is parameterized to allow you to try to build from whatever `docker.elastic.co/elasticsearch/elasticsearch` tag you like and install whichever [fabric8io/elasticsearch-cloud-kubernetes][] plugin version, but only the versions listed above have been built and tested.

[fabric8io/elasticsearch-cloud-kubernetes]: https://github.com/fabric8io/elasticsearch-cloud-kubernetes

Built images publicly available at

https://hub.docker.com/r/beiarea/elasticsearch/


Caveats
------------------------------------------------------------------------------

1.  We stripped out the version conditionals when adapting the [incubator/elasticsearch][] chart because they only related to ES major versions `2` and `5`, neither of which applied when building and deploying version `6`.
    
    If you want ES version `5` or bellow, um, just use [incubator/elasticsearch][].
    
2.  None of us know much about ElasticSearch, or even Kubernetes and Helm. This is just what we hacked together to get it working for us so we could write logs to ES, changing as little as possible from [incubator/elasticsearch][] in the process - which is itself an "incubator" chart.
    
    But, if you're in the same boat, it might be helpful.


Gory & Boring Details
------------------------------------------------------------------------------

At the moment (2018.05.24), the [incubator/elasticsearch][] Helm chart ships with ElasticSearch `5.4`, which is too old for the [stable/kibana][] chart that we want to use it with - which ships with Kibana `6.0.0` - and simply bumping the image version hasn't worked:

[stable/kibana]: https://github.com/kubernetes/charts/tree/master/stable/kibana

1.  [incubator/elasticsearch][] uses the [centerforopenscience/elasticsearch][]
images, which add the [fabric8io/elasticsearch-cloud-kubernetes][] ElasticSearch plugin and provide non-optional configuration values for it which will prevent ES from starting when the plugin is not present.
    
2.  [centerforopenscience/elasticsearch][] *has* a `6.1` image tag, as you can see on that page, but it for some reason *doesn't include the [fabric8io/elasticsearch-cloud-kubernetes][] plugin* like `5.4` does.
    
    Compare:
    
    1.  https://github.com/CenterForOpenScience/docker-library/blob/master/elasticsearch/5.4/Dockerfile
    2.  https://github.com/CenterForOpenScience/docker-library/blob/master/elasticsearch/6.1/Dockerfile
    
    This causes ES to crash on boot when the `6.1` tag is deployed using [incubator/elasticsearch][].

[centerforopenscience/elasticsearch]: https://hub.docker.com/r/centerforopenscience/elasticsearch/

This led us to "fork" the [incubator/elasticsearch][] and [centerforopenscience/elasticsearch][] `Dockerfile` to arrive here.


License
------------------------------------------------------------------------------

Apache 2-point-oh just like the Helm stable charts.
