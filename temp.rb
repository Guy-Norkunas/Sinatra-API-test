require "sqlite3"

db = SQLite3::Database.new("cache.db")

# db.execute("CREATE TABLE test (
#     id INTEGER AUTO_INCREMENT PRIMARY KEY,
#     time DATETIME NOT NULL,
#     num INTEGER NOT NULL
# )")


# db.execute("INSERT INTO test (time, num)
#   VALUES (CURRENT_TIMESTAMP, 99)
# ")

# db.execute("DELETE FROM test WHERE time=(SELECT MIN(time) FROM test)")

if db.execute("SELECT COUNT(*) FROM test")[0][0] > 10
  db.execute("DELETE FROM test WHERE time=(SELECT MIN(time) FROM test)")
end