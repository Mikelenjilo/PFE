from pfe_app.models import User

def removeUsers():
    User.objects.all().delete()

    
    

