from pymongo import MongoClient
from datetime import datetime


def update_rest(db):
    cursor = db.restaurants.find({'address.street': 'Prospect Park West'})
    for restaurant in cursor:
        if len([grade for grade in restaurant['grades'] if grade['grade'] == 'A']) > 1:
            print(f"Deleted {restaurant['name']}")
            db.restaurants.delete_one({'_id': restaurant['_id']})
            
        else:
            db.restaurants.update_one(
                {'_id': restaurant['_id']},
                {'$push': {'grades': {'grade': 'A', 'score': 10, 'date': datetime.strftime(datetime.now(), "%d %b %Y")}}}
            )
            
            print(f"Grade A added to {restaurant['name']}")


client = MongoClient("mongodb://mongo")

db = client['test']
update_rest(db)

