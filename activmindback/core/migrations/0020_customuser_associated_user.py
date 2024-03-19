# Generated by Django 5.0.2 on 2024-03-18 18:01

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0019_alter_sport_task'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='associated_user',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
