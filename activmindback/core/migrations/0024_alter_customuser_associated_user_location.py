# Generated by Django 5.0.3 on 2024-04-02 01:40

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0023_alter_customuser_associated_user'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='associated_user',
            field=models.ManyToManyField(blank=True, null=True, related_name='associated_profiles', to=settings.AUTH_USER_MODEL),
        ),
        migrations.CreateModel(
            name='Location',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('latitude', models.CharField(max_length=20)),
                ('location_name', models.CharField(max_length=45)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='location_id', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
