SELECT h.hacker_id, h.name, count(c.challenge_id) as total
FROM Hackers h
JOIN Challenges c ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id, h.name
HAVING COUNT(c.challenge_id) = (
           SELECT MAX(cnt)
           FROM (SELECT COUNT(*) AS cnt FROM Challenges GROUP BY hacker_id) t1
       )
    OR COUNT(c.challenge_id) IN (
           SELECT cnt
           FROM (SELECT COUNT(*) AS cnt FROM Challenges GROUP BY hacker_id) t2
           GROUP BY cnt
           HAVING COUNT(*) = 1
       )
ORDER BY total DESC, h.hacker_id;
