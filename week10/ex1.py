from pymongo import MongoClient

client = MongoClient("mongodb://mongo")

db = client['test']
print('Irish cuisines:')
cursor = db.collection_name.find({'cuisine': 'Irish'})
for row in cursor:
    print(row, sep="\n")
    
print()
print('Irish and Russian cuisines:')   
cursor = db.restaurants.find({'cuisine': {'$in': ['Irish', 'Russian']}})
for row in cursor:
    print(row, sep="\n")
    
print()
print('Restaurant with the address Prospect Park West 284, 11215:')
cursor = db.restaurants.find({'address.street': 'Prospect Park West', 'address.building': '284', 'address.zipcode': '11215'})
for row in cursor:
    print(row)
