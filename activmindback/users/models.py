from django.db import models
from core.models import CustomUser

class UserInfo(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)

    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    address_number = models.IntegerField(null=True)
    address_street = models.CharField(max_length=100, blank=True)
    address_city = models.CharField(max_length=100, blank=True)
    address_postal_code = models.CharField(max_length=100, blank=True)
    address_country = models.CharField(max_length=100, blank=True)
    phone_number = models.CharField(max_length=100, blank=True)

    def __str__(self):
        return f"{self.user.email}'s info"
    
    def update_first_name(self, new_first_name):
        self.first_name = new_first_name
        self.save()
        
    def update_last_name(self, new_last_name):
        self.last_name = new_last_name
        self.save()

    def update_date_of_birth(self, new_date_of_birth):
        self.date_of_birth = new_date_of_birth
        self.save()

    def update_address_number(self, new_address_number):
        self.address_number = new_address_number
        self.save()

    def update_address_street(self, new_address_street):
        self.address_street = new_address_street
        self.save()
