-- 1. Перевірка роботи функції get_manga_status
SELECT * FROM get_manga_status('Berserk');

-- 2. Перевірка роботи процедури add_genre
CALL add_genre(8, 'Psychological');

-- 3. Перевірка роботи тригера genre_details
INSERT INTO genre(genre_id, genre) 
VALUES (7, 'Historical');

SELECT * FROM genre_audit;
