from pymongo import MongoClient


def delete_brooklyn_restaurant(db):
    result = db.restaurants.delete_one({'borough': 'Brooklyn'})
    print('A single Brooklyn located restaurant was deleted.')


def delete_thai_cuisines(db):
    result = db.restaurants.delete_many({'cuisine': 'Thai'})
    print('All Thai cuisines were deleted.')


client = MongoClient("mongodb://mongo")

db = client['test']
delete_brooklyn_restaurant(db)
delete_thai_cuisines(db)
