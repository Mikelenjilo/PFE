from django.core.management.base import BaseCommand

from pfe_app.management.functions.remove_users import removeUsers



class Command(BaseCommand):
    help = 'Remove all users'

    def handle(self, *args, **options):
        removeUsers()