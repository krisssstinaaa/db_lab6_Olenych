-- Процедура, яка додає в таблицю genre новий рядок
DROP PROCEDURE IF EXISTS add_genre(integer, char);

CREATE OR REPLACE PROCEDURE add_genre(in_genre_id INT, in_genre CHAR(30))
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM genre WHERE genre_id = in_genre_id OR genre = in_genre) THEN
        RAISE EXCEPTION 'this value exist, try again';
    ELSE
        INSERT INTO genre (genre_id, genre) VALUES (in_genre_id, in_genre);
        RAISE NOTICE 'insertion was successful';
    END IF;
END;
$$;

CALL add_genre(7, 'Horror');
SELECT * FROM genre;
