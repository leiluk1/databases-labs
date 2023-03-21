import psycopg2
from geopy.geocoders import ArcGIS


con = psycopg2.connect(
    database="dvdrental", user="postgres", host="127.0.0.1", port="5432"
    
)
cur = con.cursor()
cur.execute("SELECT * FROM retrieve_addresses();")
addresses = cur.fetchall()
cur = con.cursor()
geolocator = ArcGIS()
for address in addresses:
    location = geolocator.geocode(address[0])
    if location:
        cur.execute(f'UPDATE address SET latitude = {location.latitude}, longitude = {location.longitude} WHERE address = \'{address[0]}\'')
    else:
        cur.execute(f'UPDATE address SET latitude = 0, longitude = 0 WHERE address = \'{address[0]}\'')

con.commit()
cur.close()
con.close()
