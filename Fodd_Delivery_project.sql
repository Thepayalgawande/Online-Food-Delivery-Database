CREATE DATABASE FoodDeliveryPro;
USE FoodDeliveryPro;

-- ✅ Users (Customers)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ✅ Admin Panel (managing restaurants & partners)
CREATE TABLE Admins (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('SuperAdmin','Manager') DEFAULT 'Manager'
);

-- ✅ Restaurants
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(15),
    rating DECIMAL(2,1) DEFAULT 0.0,
    managed_by INT,
    FOREIGN KEY (managed_by) REFERENCES Admins(admin_id)
);

-- ✅ Menu Items
CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50),
    stock INT DEFAULT 100,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- ✅ Delivery Partners
CREATE TABLE Delivery_Partners (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    vehicle_details VARCHAR(100),
    is_available BOOLEAN DEFAULT TRUE,
    managed_by INT,
    FOREIGN KEY (managed_by) REFERENCES Admins(admin_id)
);

-- ✅ Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    restaurant_id INT,
    partner_id INT,
    order_status ENUM('Pending','Accepted','On the Way','Delivered','Cancelled') DEFAULT 'Pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id),
    FOREIGN KEY (partner_id) REFERENCES Delivery_Partners(partner_id)
);

-- ✅ Order Items
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id)
);

-- ✅ Payments
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('UPI','Card','Cash','Wallet') DEFAULT 'UPI',
    payment_status ENUM('Paid','Failed','Pending') DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- ✅ Reviews
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    user_id INT,
    restaurant_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- ✅ Coupons
CREATE TABLE Coupons (
    coupon_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(20) UNIQUE NOT NULL,
    discount_percent DECIMAL(5,2),
    expiry_date DATE
);

-- ✅ Order Coupons (one coupon per order)
CREATE TABLE Order_Coupons (
    order_coupon_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    coupon_id INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (coupon_id) REFERENCES Coupons(coupon_id)
);

-- ✅ Real-time Delivery Tracking
CREATE TABLE Delivery_Tracking (
    tracking_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    partner_id INT,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (partner_id) REFERENCES Delivery_Partners(partner_id)
);

-- 🔹 Users (Customers)
INSERT INTO Users (name, email, phone, address) VALUES
('Rahul Sharma', 'rahul@gmail.com', '9876543210', 'Pune, Maharashtra'),
('Priya Verma', 'priya@gmail.com', '9876501234', 'Mumbai, Maharashtra'),
('Amit Singh', 'amit@gmail.com', '9823456789', 'Delhi, India'),
('Neha Gupta', 'neha@gmail.com', '9811122233', 'Bangalore, Karnataka'),
('Ravi Kumar', 'ravi@gmail.com', '9834567890', 'Hyderabad, Telangana');

-- 🔹 Admins
INSERT INTO Admins (username, password, role) VALUES
('admin1', 'pass123', 'SuperAdmin'),
('manager1', 'pass456', 'Manager'),
('manager2', 'pass789', 'Manager');

-- 🔹 Restaurants
INSERT INTO Restaurants (name, address, phone, rating, managed_by) VALUES
('Spice Villa', 'Pune City Center', '9123456780', 4.5, 2),
('Tandoori Nights', 'Mumbai Central', '9223456781', 4.2, 2),
('Pizza Hub', 'Delhi Connaught Place', '9323456782', 4.8, 3),
('Burger Town', 'Bangalore MG Road', '9423456783', 4.0, 3),
('Biryani Express', 'Hyderabad Charminar', '9523456784', 4.7, 2);

-- 🔹 Menu Items
INSERT INTO Menu_Items (restaurant_id, item_name, price, category, stock) VALUES
(1, 'Paneer Butter Masala', 250, 'Main Course', 50),
(1, 'Veg Biryani', 180, 'Rice', 60),
(2, 'Chicken Tandoori', 300, 'Starter', 40),
(2, 'Butter Naan', 40, 'Bread', 100),
(3, 'Farmhouse Pizza', 450, 'Pizza', 30),
(3, 'Cheese Garlic Bread', 120, 'Starter', 50),
(4, 'Veg Burger', 150, 'Burger', 80),
(4, 'French Fries', 100, 'Sides', 90),
(5, 'Hyderabadi Biryani', 350, 'Rice', 70),
(5, 'Mutton Curry', 400, 'Main Course', 30);

-- 🔹 Delivery Partners
INSERT INTO Delivery_Partners (name, phone, vehicle_details, is_available, managed_by) VALUES
('Arjun Kumar', '9000011111', 'Bike - MH12AB1234', TRUE, 2),
('Sandeep Yadav', '9000022222', 'Scooter - MH14XY5678', TRUE, 2),
('Kiran Reddy', '9000033333', 'Bike - DL10PQ9876', TRUE, 3),
('Vikas Gupta', '9000044444', 'Scooter - KA01LM6543', FALSE, 3),
('Ankit Mehta', '9000055555', 'Bike - TS09GH1234', TRUE, 2);

-- 🔹 Orders
INSERT INTO Orders (user_id, restaurant_id, partner_id, order_status) VALUES
(1, 1, 1, 'Delivered'),
(2, 2, 2, 'On the Way'),
(3, 3, 3, 'Pending'),
(4, 4, 4, 'Accepted'),
(5, 5, 5, 'Delivered');

-- 🔹 Order Items
INSERT INTO Order_Items (order_id, item_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 4, 4),
(3, 5, 1),
(3, 6, 2),
(4, 7, 2),
(4, 8, 2),
(5, 9, 1),
(5, 10, 1);

-- 🔹 Payments
INSERT INTO Payments (order_id, amount, payment_method, payment_status) VALUES
(1, 680, 'UPI', 'Paid'),
(2, 460, 'Card', 'Paid'),
(3, 690, 'Wallet', 'Pending'),
(4, 500, 'Cash', 'Pending'),
(5, 750, 'UPI', 'Paid');

-- 🔹 Reviews
INSERT INTO Reviews (order_id, user_id, restaurant_id, rating, comment) VALUES
(1, 1, 1, 5, 'Excellent food and fast delivery!'),
(2, 2, 2, 4, 'Tasty but naan was a bit cold.'),
(5, 5, 5, 5, 'Best biryani ever!');

-- 🔹 Coupons
INSERT INTO Coupons (code, discount_percent, expiry_date) VALUES
('WELCOME50', 50, '2025-12-31'),
('FOOD20', 20, '2025-11-30'),
('SAVE10', 10, '2025-10-31');

-- 🔹 Order Coupons
INSERT INTO Order_Coupons (order_id, coupon_id) VALUES
(1, 1),
(2, 2),
(5, 3);

-- 🔹 Delivery Tracking
INSERT INTO Delivery_Tracking (order_id, partner_id, latitude, longitude) VALUES
(2, 2, 19.076090, 72.877426), -- Mumbai
(3, 3, 28.613939, 77.209023), -- Delhi
(4, 4, 12.971599, 77.594566), -- Bangalore
(5, 5, 17.385044, 78.486671); -- Hyderabad

SELECT user_id, name, email, phone, address 
FROM Users;
SELECT r.restaurant_id, r.name AS restaurant_name, r.rating, a.username AS manager
FROM Restaurants r
JOIN Admins a ON r.managed_by = a.admin_id;
SELECT item_name, price, category, stock
FROM Menu_Items
WHERE restaurant_id = 1;  -- Example: Spice Villa

SELECT mi.item_name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Menu_Items mi ON oi.item_id = mi.item_id
GROUP BY mi.item_name
ORDER BY total_sold DESC
LIMIT 5;
SELECT r.name AS restaurant_name, SUM(p.amount) AS total_revenue
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id
WHERE p.payment_status = 'Paid'
GROUP BY r.name
ORDER BY total_revenue DESC;
SELECT mi.item_name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Menu_Items mi ON oi.item_id = mi.item_id
GROUP BY mi.item_name
ORDER BY total_sold DESC
LIMIT 5;

SELECT r.name AS restaurant_name, SUM(p.amount) AS total_revenue
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id
WHERE p.payment_status = 'Paid'
GROUP BY r.name
ORDER BY total_revenue DESC;
SELECT o.order_id, u.name AS customer, c.code AS coupon_code, c.discount_percent
FROM Orders o
JOIN Order_Coupons oc ON o.order_id = oc.order_id
JOIN Coupons c ON oc.coupon_id = c.coupon_id
JOIN Users u ON o.user_id = u.user_id;
SELECT partner_id, name, phone, vehicle_details
FROM Delivery_Partners
WHERE is_available = TRUE;
SELECT o.order_id, u.name AS customer, d.name AS partner, 
       t.latitude, t.longitude, t.last_updated
FROM Delivery_Tracking t
JOIN Orders o ON t.order_id = o.order_id
JOIN Users u ON o.user_id = u.user_id
JOIN Delivery_Partners d ON t.partner_id = d.partner_id;
SELECT r.name AS restaurant_name, AVG(rv.rating) AS avg_rating
FROM Reviews rv
JOIN Restaurants r ON rv.restaurant_id = r.restaurant_id
GROUP BY r.name
ORDER BY avg_rating DESC;
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, 
       SUM(amount) AS total_revenue
FROM Payments
WHERE payment_status = 'Paid'
GROUP BY month
ORDER BY month;
SELECT o.order_id, u.name AS customer, r.name AS restaurant, o.order_status
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_status IN ('Pending', 'Accepted', 'On the Way');
SELECT u.name, COUNT(o.order_id) AS total_orders
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.name
ORDER BY total_orders DESC
LIMIT 3;
DELIMITER //
CREATE TRIGGER after_payment_insert
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.payment_status = 'Paid' THEN
        UPDATE Restaurants
        SET rating = rating  -- (dummy update, or add revenue table)
        WHERE restaurant_id = (SELECT restaurant_id 
                               FROM Orders 
                               WHERE order_id = NEW.order_id);
    END IF;
END;
 //DELIMITER ;














