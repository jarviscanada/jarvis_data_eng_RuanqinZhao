#!/bin/bash

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#Check number of args
if [ $# -ne 5 ]; then
  echo "There need to be 5 args"
  exit 1
fi

hostname=$(hostname -f)
lscpu_out=`lscpu`

#hardware
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(lscpu | egrep "Architecture" | awk '{print $2}' | xargs)
cpu_model=$(lscpu | grep "Model name" | awk '{print $3,$4,$5,$6,$7}' | xargs)
cpu_mhz=$(lscpu | grep -i "mhz" | awk '{print $3}' | xargs)
l2_cache=$(lscpu | grep -i "l2" | awk '{print $3}' | xargs | cut -f1 -d"K")
total_mem=$(cat /proc/meminfo | grep -i "memtotal" | awk '{print $2}')

#Current time in `2019-11-26 14:40:19` UTC format
timestamp=$(date +"%Y-%m-%d %T")


# insert data into host_info table
insert_stmt="INSERT INTO host_info(hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, l2_cache, total_mem, timestamp) VALUES('$hostname', '$cpu_number', '$cpu_architecture', '$cpu_model', '$cpu_mhz', '$l2_cache', '$total_mem', '$timestamp')"

#Save the psql password to an environment variable
export PGPASSWORD=$psql_password

#Insert tuple into the database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?
