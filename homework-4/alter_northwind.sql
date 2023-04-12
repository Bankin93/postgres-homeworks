-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)

ALTER TABLE products ADD CONSTRAINT chk_products_unit_price CHECK (unit_price > 0);

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1

ALTER TABLE products ADD CONSTRAINT chk_products_discontinued CHECK (discontinued IN (0, 1))

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)

SELECT * INTO discontinued_products FROM products WHERE discontinued = 1
SELECT * FROM discontinued_products;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.

ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products
ALTER TABLE order_details ADD CONSTRAINT fk_order_details_products FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
-- ON DELETE и ON UPDATE
-- С помощью выражений ON DELETE и ON UPDATE можно установить действия, которые выполняться соответственно при удалении и изменении связанной строки из главной таблицы. И для определения действия мы можем использовать следующие опции:
-- CASCADE: автоматически удаляет или изменяет строки из зависимой таблицы при удалении или изменении связанных строк в главной таблице.
-- NO ACTION: предотвращает какие-либо действия в зависимой таблице при удалении или изменении связанных строк в главной таблице. То есть фактически какие-либо действия отсутствуют.
-- SET NULL: при удалении связанной строки из главной таблицы устанавливает для столбца внешнего ключа значение NULL.
-- SET DEFAULT: при удалении связанной строки из главной таблицы устанавливает для столбца внешнего ключа значение по умолчанию, которое задается с помощью атрибуты DEFAULT. Если для столбца не задано значение по умолчанию, то в качестве него применяется значение NULL.
DELETE FROM products
WHERE discontinued = 1;
