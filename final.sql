SELECT B.pubid,B.year,A1.name, 'book' AS type FROM book B INNER JOIN wrote W1 ON W1.pubid = B.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1 AND B.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Peter Bumbulis'))

SELECT ARPRPUBID, PR.year, ARPRAUTHORNAME, 'article' AS type FROM proceedings PR, (SELECT AR.pubid AS ARPRPUBID ,AR.appearsin AS PRAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
),(SELECT A1.name AS ARPRAUTHORNAME, W1.pubid AS W1Pubid FROM article AR1 INNER JOIN wrote W1 ON W1.pubid = AR1.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1) WHERE PRAPPEARSIN = PR.pubid AND ARPRPUBID = W1Pubid

SELECT ARBPUBID, B.year, ARBAUTHORNAME, 'article' AS type FROM book B, (SELECT AR.pubid AS ARBPUBID ,AR.appearsin AS BAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
),(SELECT A1.name AS ARBAUTHORNAME, W1.pubid AS W1Pubid FROM article AR1 INNER JOIN wrote W1 ON W1.pubid = AR1.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1) WHERE BAPPEARSIN = B.pubid AND ARBPUBID = W1Pubid

SELECT ARJPUBID, J.year, ARJAUTHORNAME, 'article' AS type FROM journal J, (SELECT AR.pubid AS ARJPUBID ,AR.appearsin AS JAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
),(SELECT A1.name AS ARJAUTHORNAME, W1.pubid AS W1Pubid FROM article AR1 INNER JOIN wrote W1 ON W1.pubid = AR1.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1) WHERE JAPPEARSIN = J.pubid AND ARJPUBID = W1Pubid

SELECT DISTINCT PR.pubid, PR.year, NULL AS PRAUTHORNAME , 'proceedings' AS type FROM proceedings PR, (SELECT AR.pubid ,AR.appearsin AS PRAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
) WHERE PRAPPEARSIN = PR.pubid 

(SELECT DISTINCT PR.pubid, PR.year, NULL AS PRAUTHORNAME , 'proceedings' AS type FROM proceedings PR, (SELECT AR.pubid ,AR.appearsin AS PRAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
) WHERE PRAPPEARSIN = PR.pubid) UNION (SELECT ARPRPUBID, PR.year, ARPRAUTHORNAME, 'article' AS type FROM proceedings PR, (SELECT AR.pubid AS ARPRPUBID ,AR.appearsin AS PRAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
),(SELECT A1.name AS ARPRAUTHORNAME, W1.pubid AS W1Pubid FROM article AR1 INNER JOIN wrote W1 ON W1.pubid = AR1.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1) WHERE PRAPPEARSIN = PR.pubid AND ARPRPUBID = W1Pubid) ORDER BY PRAUTHORNAME




(SELECT DISTINCT B.pubid,B.year AS year,A1.name AS AUTHORNAME, 'book' AS type FROM book B INNER JOIN wrote W1 ON W1.pubid = B.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1 AND B.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman')))
UNION 
(SELECT DISTINCT ARPRPUBID, PR.year AS year, AUTHORNAME, 'article' AS type FROM proceedings PR, (SELECT AR.pubid AS ARPRPUBID ,AR.appearsin AS PRAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
),(SELECT A1.name AS AUTHORNAME, W1.pubid AS W1Pubid FROM article AR1 INNER JOIN wrote W1 ON W1.pubid = AR1.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1) WHERE PRAPPEARSIN = PR.pubid AND ARPRPUBID = W1Pubid) 
UNION
(SELECT DISTINCT ARBPUBID, B.year AS year, AUTHORNAME, 'article' AS type FROM book B, (SELECT AR.pubid AS ARBPUBID ,AR.appearsin AS BAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
),(SELECT A1.name AS AUTHORNAME, W1.pubid AS W1Pubid FROM article AR1 INNER JOIN wrote W1 ON W1.pubid = AR1.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1) WHERE BAPPEARSIN = B.pubid AND ARBPUBID = W1Pubid)
UNION
(SELECT DISTINCT ARJPUBID, J.year AS year, AUTHORNAME, 'article' AS type FROM journal J, (SELECT AR.pubid AS ARJPUBID ,AR.appearsin AS JAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
),(SELECT A1.name AS AUTHORNAME, W1.pubid AS W1Pubid FROM article AR1 INNER JOIN wrote W1 ON W1.pubid = AR1.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1) WHERE JAPPEARSIN = J.pubid AND ARJPUBID = W1Pubid)
UNION
(SELECT DISTINCT PR.pubid, PR.year AS year, '' AS AUTHORNAME , 'proceedings' AS type FROM proceedings PR, (SELECT AR.pubid ,AR.appearsin AS PRAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
) WHERE PRAPPEARSIN = PR.pubid)
UNION
(SELECT DISTINCT J.pubid, J.year AS year, '' AS AUTHORNAME , 'journal' AS type FROM journal J, (SELECT AR.pubid ,AR.appearsin AS JAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
) WHERE JAPPEARSIN = J.pubid)
UNION
(SELECT DISTINCT B.pubid, B.year AS year, AUTHORNAME, 'book' AS type FROM book B, (SELECT AR.pubid, AR.appearsin AS BAPPEARSIN FROM article AR WHERE AR.pubid IN (SELECT W.pubid FROM wrote W WHERE W.aid IN (SELECT A.aid FROM author A WHERE A.name = 'Ivan T. Bowman'))
),(SELECT A1.name AS AUTHORNAME, W1.pubid AS W1Pubid FROM book B INNER JOIN wrote W1 ON W1.pubid = B.pubid INNER JOIN AUTHOR A1 ON A1.aid = W1.aid WHERE W1.aorder = 1) WHERE BAPPEARSIN = B.pubid AND B.pubid = W1Pubid)
ORDER BY year DESC, AUTHORNAME ASC

