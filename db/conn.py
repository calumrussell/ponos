import psycopg2
import os

conn = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PWD"),
    dbname=os.getenv("DB_NAME"),
    port=os.getenv("DB_PORT")
)
