from pfe_app.management.functions.remove_clusters import removeCluster
from pfe_app.management.functions.remove_users import removeUsers


def removeInfos():
    removeUsers()
    removeCluster()