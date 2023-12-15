-- 3. Тригер , який при модифікації таблиці genre створює корему таблицю genre_audit
-- де який користувач користувався таблицею та час операції

DROP TABLE IF EXISTS genre_audit; 
CREATE TABLE genre_audit( 
  id SERIAL PRIMARY KEY, 
  operation_type VARCHAR(10),
  updated TIMESTAMP, 
  user_name varchar(40) NOT NULL 
);
DROP TRIGGER IF EXISTS genre_details ON genre;


CREATE OR REPLACE FUNCTION table_genre_audit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
    INSERT INTO genre_audit(operation_type, updated, user_name)
    VALUES('INSERT', NOW(), user);
  ELSIF TG_OP = 'UPDATE' THEN
    INSERT INTO genre_audit(operation_type, updated, user_name)
    VALUES('UPDATE', NOW(), user);
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO genre_audit(operation_type, updated, user_name)
    VALUES('DELETE', NOW(), user);
  END IF;
    RETURN NULL;
END;
$$;

CREATE TRIGGER genre_details
AFTER INSERT OR UPDATE OR DELETE ON genre
FOR EACH ROW EXECUTE FUNCTION table_genre_audit();

INSERT INTO genre (genre_id, genre) VALUES (7, 'Horror');
select * from genre_audit;
