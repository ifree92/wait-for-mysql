# wait-for-mysql

`wait-for-mysql.sh` is a small script for check when DB is ready for queries. The main goal write this script was a usage mysql docker as a microservice for several other containers. When we have a cold start of mysql - it requires some time to be ready to do queries, but some services could run earlier and we would obtain 50* errors on server. To prevent it wrote this script for check when DB really ready for queries.

The script will finished when connection to DB will establish.

## Requirements

You shuld have installed mysql console client on your server/container. 

#### Ubuntu/Debian

```sh
$ sudo apt-get install mysql-client
```

## Usage

First of all you should know all about parameters for console mysql client.
For more details see here:

`$ man mysql`

```
wait-for-mysql.sh [--host=localhost] [-u root] [--wait-timeout=10] [--no-wait-log] [--wait-show-err]
    --wait-timeout=10           Timeout in seconds for loop repeating establish connection
    --no-wait-log               Do now show every timeout time log about another repeating to establish connection
    --wait-show-err             Enable to show stderr of mysql command

```

## Examples

`$ ./wait-for-mysql.sh -u root --host=mysqlhost -e "show databases;" --wait-timeout=5 && npm start`

Here we see that after success connection to DB the script will finished and the service starts.