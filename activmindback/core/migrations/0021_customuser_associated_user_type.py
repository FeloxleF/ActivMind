# Generated by Django 5.0.2 on 2024-03-18 18:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0020_customuser_associated_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='associated_user_type',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]
