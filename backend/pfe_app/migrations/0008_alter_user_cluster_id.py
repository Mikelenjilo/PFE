# Generated by Django 4.2.1 on 2023-05-12 16:48

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('pfe_app', '0007_alter_cluster_cluster_id'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='cluster_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='pfe_app.cluster'),
        ),
    ]
