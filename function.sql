-- Функція, яка повертає статус манги
DROP FUNCTION IF EXISTS get_manga_status(char);

CREATE OR REPLACE FUNCTION get_manga_status (in_english_title CHAR(40))
	RETURNS TABLE (status CHAR(20))
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        s.status
    FROM status s
    JOIN manga m ON s.status_id = m.status_id
    WHERE m.english_title = in_english_title;
END;
$$;

SELECT *
FROM get_manga_status('Jojo');