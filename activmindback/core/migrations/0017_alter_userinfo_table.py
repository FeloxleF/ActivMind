# Generated by Django 5.0.2 on 2024-03-15 18:20

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models

class Migration(migrations.Migration):
    
    dependencies = [
        ('core', '0015_customuser_user_type'),
    ]
    
    operations = [
        migrations.CreateModel(
            name='UserInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_name', models.CharField(max_length=100)),
                ('last_name', models.CharField(max_length=100)),
                ('date_of_birth', models.DateField()),
                ('address_number', models.IntegerField(null=True)),
                ('address_street', models.CharField(blank=True, max_length=100)),
                ('address_city', models.CharField(blank=True, max_length=100)),
                ('address_postal_code', models.CharField(blank=True, max_length=100)),
                ('address_country', models.CharField(blank=True, max_length=100)),
                ('phone_number', models.CharField(blank=True, max_length=100)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]