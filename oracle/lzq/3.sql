   select count(*)  from qyxx_gaxx_zfrz g
                       left join qyxx_cpjtxx c on c.cyid = g.cyid
                       left join sys_jgxxb j on j.jgid = c.hjxxdz
                       where 1 = 1 and j.jgbm like '4290040' || '%'
                       and to_char(g.zftime, 'MM') = '07';
