# Generated by Django 5.0.3 on 2024-03-12 13:26

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0008_medicament_task_sport_activity'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='done',
            field=models.BooleanField(default=True),
        ),
        migrations.AlterField(
            model_name='task',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='user_id', to=settings.AUTH_USER_MODEL),
        ),
    ]
