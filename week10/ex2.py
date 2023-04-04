from pymongo import MongoClient
from datetime import datetime


def insert_restaurant(db):
    restaurant = {
        'address': {'street': 'Sportivnaya', 'building': '126', 'zipcode': '420500', 'coord': [-73.9557413, 40.7720266]},
        'borough': 'Innopolis',
        'cuisine': 'Serbian',
        'name': 'The Best Restaurant',
        'restaurant_id': '41712354',
        'grades': [{'grade': 'A', 'score': 11, 'date': datetime.strptime("04 Apr 2023", "%d %b %Y")}]
    }

    db.restaurants.insert_one(restaurant)
    print("Inserted restaurant:", restaurant['name'])
    
    
client = MongoClient("mongodb://mongo")

db = client['test']
insert_restaurant(db)
