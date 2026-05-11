CREATE DATABASE IF NOT EXISTS LabViewManagement_DB;
USE LabViewManagement_DB;

CREATE TABLE products (
    productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70) NOT NULL,
    productLine VARCHAR(50) NOT NULL,
    buyPrice DECIMAL(10, 2) NOT NULL,
    MSRP DECIMAL(10, 2) NOT NULL,
    quantityInStock SMALLINT NOT NULL
);

-- Thêm dữ liệu mẫu để chạy thực hành
INSERT INTO products (productCode, productName, productLine, buyPrice, MSRP, quantityInStock)
VALUES 
('S10_1678', '1969 Harley Davidson Ultimate Chopper', 'Motorcycles', 48.81, 95.70, 7933),
('S10_1949', '1952 Alpine Renault 1300', 'Classic Cars', 98.58, 214.30, 7305),
('S10_4698', '2003 Harley-Davidson Eagle Iron', 'Motorcycles', 91.02, 191.72, 558),
('S12_1099', '1968 Ford Mustang', 'Classic Cars', 95.34, 194.57, 68);

-- Bước 1: Khởi tạo View thông tin sản phẩm
CREATE VIEW view_product_info AS
SELECT productCode, productName, productLine, buyPrice, MSRP
FROM products;

-- Bước 2: Kiểm tra dữ liệu từ View
SELECT * FROM view_product_info;

-- Bước 3: Chỉnh sửa cấu trúc View (Loại bỏ cột MSRP)
ALTER VIEW view_product_info AS
SELECT productCode, productName, productLine, buyPrice
FROM products;

-- Bước 4: Thiết lập điều kiện lọc và ràng buộc dữ liệu (quantityInStock > 3000)
CREATE OR REPLACE VIEW view_product_info AS
SELECT productCode, productName, productLine, buyPrice, quantityInStock
FROM products
WHERE quantityInStock > 3000
WITH CHECK OPTION;

-- Bước 5: Kiểm tra tính toàn vẹn (Ném lỗi khi UPDATE sai điều kiện)
-- Lệnh này sẽ thông báo lỗi "CHECK OPTION failed" vì 1000 < 3000
UPDATE view_product_info 
SET quantityInStock = 1000 
WHERE productCode = 'S10_1678';