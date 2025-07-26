					# Pokok Pertanyaan

					# 1. Create Database & Table (Basic Setup)
					--	 CREATE DATABASE, USE
create Database indomaret;
use indomaret;

					# 2. Import dan Show Tables
select * from indomaret_sales;

					# 3. Create Table
					--	 CREATE TABLE, PRIMARY KEY, FOREIGN KEY
CREATE TABLE wilayah (
	store_location VARCHAR(30) PRIMARY KEY,
    area VARCHAR(30),
    kategori_wilayah VARCHAR(30),
    jumlah_toko INT,
    populasi_wilayah int,
    target_revenue int
);

CREATE TABLE supervisor (
	kode_area INT AUTO_INCREMENT PRIMARY KEY,
    nama_supervisor VARCHAR(100),
    store_location VARCHAR(30),
FOREIGN KEY(store_location) references wilayah(store_location)
);

SHOW TABLES;

					# 4. Insert Data ke Tabel (Dummy Data)
					--	 INSERT INTO - VALUES

INSERT INTO wilayah (store_location, area, kategori_wilayah, jumlah_toko, populasi_wilayah, target_revenue)
	VALUES	('Jagakarsa', 'Jakarta Selatan', 'Pinggiran', 5, 420000, 6000000),
			('Cilandak', 'Jakarta Selatan', 'Tengah', 5, 360000, 6000000),
            ('Fatmawati', 'Jakarta Selatan', 'Strategis', 5, 310000, 6000000),
            ('Pasar Minggu', 'Jakarta Selatan', 'Komersial', 5, 500000, 6000000);
            
INSERT INTO supervisor (kode_area, nama_supervisor, store_location)
	VALUES	(001, 'Andi', 'Jagakarsa'),
			(002, 'Mira', 'Cilandak'),
			(003, 'Rizal', 'Fatmawati'),
            (004, 'Anisa', 'Pasar Minggu');

select * from wilayah;
select * from supervisor;

					# 5. Query Dasar (Data Retrieval)
					--	 SELECT, WHERE, ORDER BY, LIMIT

					-- Apakah ada data yang null?
Select *
from indomaret_sales
where Units_Sold is null
or Transaction_ID is null
or Date is null
or Product_Name is null
or Category is null
or Units_Sold is null
or Unit_Price is null
or Total_Revenue is null
or Store_Location is null
or Payment_Method is null;

					-- Merangkum isi kolom dari Category
select distinct category
from indomaret_sales
order by category;

					-- Melihat Category yang ada huruf s nya
select distinct category
from indomaret_sales
where category 
	like '%S%'
order by category;

					-- 6. Agregasi & Grouping (Data Summary)
					--	  COUNT, SUM, AVG, GROUP BY, HAVING

					-- rata rata barang yang kejual
select
	avg(Units_Sold) as rata_rata_terjual
from indomaret_sales;

					-- total barang yang kejual
select
	sum(Units_Sold) as total_barang_terjual
from indomaret_sales;

					-- total revenue
select
	sum(total_revenue)
from indomaret_sales;

select category,
	sum(Total_Revenue)
    as total_penjualan
from indomaret_sales
group by category
having count(*) >1;

					-- jumlah transaksi per metode pembayaran
select Payment_method,
	count(*) as qty_sold_per_payment_methode
from indomaret_sales
group by payment_method;

					-- produk terlaris berdasarkan units_sold
select product_name,
	sum(Units_Sold) as produk_terlaris
from indomaret_sales
where Units_Sold
group by product_name
limit 5;

					-- 7. Relasi Data dengan JOIN
					--	   INNER JOIN, LEFT JOIN
SELECT wilayah.store_location, wilayah.kategori_wilayah, indomaret_sales.total_revenue
from wilayah
inner join indomaret_sales
on wilayah.store_location = indomaret_sales.store_location;

SELECT wilayah.store_location, wilayah.kategori_wilayah, indomaret_sales.total_revenue
from wilayah
left join indomaret_sales
on wilayah.store_location = indomaret_sales.Store_Location;

SELECT wilayah.store_location, wilayah.kategori_wilayah, indomaret_sales.total_revenue
from wilayah
right join indomaret_sales
on wilayah.store_location = indomaret_sales.Store_Location;

					-- 8. Subquery & Derived Table
					--	   Subquery dalam WHERE atau FROM

					-- mencari produk dengan unit sold diatas rata-rata
select product_name, units_sold
from indomaret_sales
where units_sold > (
	select avg(units_sold)
    from indomaret_sales
);

					-- 9.  Data Cleaning & Manipulasi
					-- 		UPDATE, DELETE, CASE, COALESCE.

UPDATE wilayah
SET kategori_wilayah = 'Perkampungan'
WHERE store_location = 'jagakarsa';

# INSIGHT