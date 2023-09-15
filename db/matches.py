import conn 

if __name__ == "__main__":
    with conn.conn:
        with conn.conn.cursor() as cur:
            print(cur.execute("select * from matches"));
