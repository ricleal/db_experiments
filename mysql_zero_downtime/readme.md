# Experiment

## Connect to the database

```bash
mycli mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DATABASE
```

## Run a file

```bash
mycli mysql://$MYSQL_ROOT_USER:$MYSQL_ROOT_PASSWORD@$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DATABASE <  sql/init.sql
```

# Partition

1. Create a partitioned new table
2. Create triggers to copy any new data from old table to new table
3. copy data from old table to new table - ignore duplicates
4. In a transaction:
   1. rename old table to old table name + _old
   2. rename new table to old table name
   3. drop the triggers
   4. drop the old table

Note: the triggers that we create can lock some columns. Some online migration tools (such as [`gh-ost`](https://github.com/github/gh-ost)) that migrate data based on binlog are a better approach.