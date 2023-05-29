from datetime import timedelta
from django.utils import timezone
from django.db import models

from pfe_app.models import User
from django.db.models import Case, When, F, Value



def prefiltrageMethod():
    six_days_ago = timezone.now() - timedelta(days=6)
    User.objects.update(
        if_transmit=Case(
            When(date_of_contamination__gte=six_days_ago.date(), then=Value(True)),
            default=Value(False),
            output_field=models.BooleanField()
        )
    )

def prefiltrageMethodOneUser(user_id):
    six_days_ago = timezone.now() - timedelta(days=6)
    User.objects.filter(user_id=user_id).update(
        if_transmit=Case(
            When(date_of_contamination__gte=six_days_ago.date(), then=Value(True)),
            default=Value(False),
            output_field=models.BooleanField()
        )
    )