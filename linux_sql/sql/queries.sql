-- 1. Group hosts by hardware info
-- group by cpu number and sort by their memory size in descending order

select cpu_number, host_id, total_mem from host_info
inner join host_usage on host_info.id = host_usage.host_id
group by cpu_number, host_id, total_mem
order by cpu_number asc, total_mem desc;

-- 2. Average memory usage
-- average used memory in percentage over 5 mins interval for each host
-- used memory = total memory - free memory
select host_id, hostname, date_trunc('hour', timestamp) + date_part('minute', timestamp):: int / 5 * interval '5 min' as round5,  avg( (host_info.total_mem / 1024 - host_usage.memory_free) / (host_info.total_mem / 1024) * 100 ) as avg_used_mem_percentage
from host_info
join host_usage on host_info.id = host_usage.host_id
group by host_id, hostname, round5, avg_used_mem_percentage
order by host_id, round5;

-- 3. Detect host failure
select host_id, hostname, date_trunc('hour', timestamp) + date_part('minute', timestamp):: int / 5 * interval '5 min' as round5, count(*)
from host_info
join host_usage on host_info.id = host_usage.host_id
group by host_id, hostname, round5
having count(*) < 3
order by round5