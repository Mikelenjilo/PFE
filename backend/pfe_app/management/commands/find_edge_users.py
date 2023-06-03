
from django.core.management.base import BaseCommand

from pfe_app.management.functions.find_edge_users import findEdgeUsers
from pfe_app.models import Cluster


class Command(BaseCommand):
    help = 'Generates random data for the utilisateurs and utilisateurs_malade tables'

    def handle(self, *args, **options):
        findEdgeUsers(Cluster.objects.get(cluster_id=1))

