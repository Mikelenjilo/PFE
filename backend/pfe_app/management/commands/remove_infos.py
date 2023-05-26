from django.core.management.base import BaseCommand

from pfe_app.management.functions.remove_infos import removeInfos


class Command(BaseCommand):
    help = 'Generates random data for the utilisateurs and utilisateurs_malade tables'

    def handle(self, *args, **options):
        removeInfos()
            

