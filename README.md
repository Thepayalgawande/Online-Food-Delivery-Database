# 🍴 FoodDeliveryPro – Online Food Delivery System (SQL Project)

## 📖 Overview
**FoodDeliveryPro** is a **database-driven project** that simulates the workflow of online food delivery platforms like **Swiggy, Zomato, and UberEats**.  
It manages **customers, restaurants, menus, orders, payments, coupons, reviews, and delivery partners** in a unified system.  

The project is implemented in **MySQL Workbench** and demonstrates **database design, queries, stored procedures, triggers, and constraints** in an end-to-end DBMS solution.

---

## 🎯 Key Features

### 👤 Customer Features
- Register & login
- Browse restaurants & view menus
- Place orders with multiple items
- Apply discount coupons
- Make payments (UPI, Card, Wallet, Cash)
- Track delivery in real-time (latitude & longitude)
- Give reviews & ratings

### 🏪 Restaurant Features
- Manage menu items and stock
- View order history
- Update dish availability

### 👨‍💼 Admin Features
- Manage restaurants and delivery partners
- Monitor revenue & sales reports
- Track active and pending orders
- View low-stock alerts and top-selling items

### 🚴 Delivery Partner Features
- Accept delivery assignments
- Update real-time delivery tracking
- Update availability status

---

## 🏗️ Database Schema
- **Users** → Customer details
- **Admins** → Admin panel for managing restaurants & partners
- **Restaurants** → Restaurant information with manager assignment
- **Menu_Items** → Food items with price, category, and stock
- **Orders & Order_Items** → Orders and their ordered items
- **Payments** → Payment details & status
- **Coupons & Order_Coupons** → Discounts system
- **Delivery_Partners** → Partner information & availability
- **Delivery_Tracking** → Real-time delivery GPS tracking
- **Reviews** → Customer feedback and ratings

---
