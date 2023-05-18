from datetime import timedelta
from django.utils import timezone

from pfe_app.models import User


def prefiltrageMethod():
    six_days_ago = timezone.now() - timedelta(days=6)
    User.objects.filter(date_of_contamination__date__gte=six_days_ago.date()).update(if_transmit=1)

