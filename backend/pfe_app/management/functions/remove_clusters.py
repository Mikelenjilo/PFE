from pfe_app.models import Cluster, User


def removeCluster():
    default_cluster = Cluster.objects.get(pk=0)
    Cluster.objects.exclude(pk=0).delete()

    User.objects.all().update(cluster_id=default_cluster)