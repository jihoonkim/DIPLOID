SELECT class, COUNT(bin) FROM hg19snp147 GROUP BY class;
-- +----------------+------------+
-- | class          | count(bin) |
-- +----------------+------------+
-- | single         |  141537204 |
-- | in-del         |     248044 |
-- | microsatellite |       4710 |
-- | named          |         12 |
-- | mnp            |     238877 |
-- | insertion      |    5133195 |
-- | deletion       |    7660040 |
-- +----------------+------------+


DELETE FROM hg19snp147 WHERE class <> 'single';