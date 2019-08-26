-- Taken from https://github.com/dremio/dremio-oss/blob/master/sabot/kernel/src/test/resources/queries/tpch/

select
    c_count,
    count(*) as custdist
from
    (
        select
            c.c_custkey,
            count(o.o_orderkey)
        from
            cp."tpch/customer.parquet" c
                left outer join cp."tpch/orders.parquet" o
                                on c.c_custkey = o.o_custkey
                                    and o.o_comment not like '%special%requests%'
        group by
            c.c_custkey
    ) as orders (c_custkey, c_count)
group by
    c_count
order by
    custdist desc,
    c_count desc;