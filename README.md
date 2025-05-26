## 1. What is PostgreSQL?

**PostgreSQL** হচ্ছে একটি ফ্রি এবং ওপেন সোর্স ডেটাবেইজ সিস্টেম। এটি রিলেশনাল ডেটাবেইজ মডেল এবং অনেক আধুনিক ফিচার সাপোর্ট করে যেমন: JSON ডেটা, স্টোরড প্রোসিজার, ট্রানজেকশন, ফোরেন কি ইত্যাদি।

---

## 2. What is the purpose of a database schema in PostgreSQL?

স্কিমা হচ্ছে ডেটাবেইজের ভেতরে আলাদা আলাদা ভাগ যেখানে টেবিল, ভিউ, ফাংশন ইত্যাদি রাখা হয়। এটা একই ডেটাবেইজে আলাদা ইউজারের ডেটা আলাদা করে রাখতে সাহায্য করে।

উদাহরণ: `public`, `admin`, `sales` এই নামে আলাদা স্কিমা থাকতে পারে।

---

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

- **Primary Key**: টেবিলের প্রতিটি রেকর্ডকে ইউনিকভাবে চিহ্নিত করে। এটা কখনো ফাঁকা (NULL) হয় না।
- **Foreign Key**: অন্য টেবিলের প্রাইমারি কি এর সাথে সম্পর্ক তৈরি করে।

**উদাহরণ:**
```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id)
);
```

---

## 4. What is the difference between the VARCHAR and CHAR data types?

- **VARCHAR(n)**: যতটুকু লেখা লাগে ততটুকুই জায়গা নেয়।
- **CHAR(n)**: সবসময় ঠিক n ক্যারেক্টার জায়গা নেয়, কম হলে ফাঁকা জায়গা দিয়ে পূরণ করে।

```sql
name VARCHAR(50)
code CHAR(10)
```

---

## 5. Explain the purpose of the WHERE clause in a SELECT statement.

`WHERE` ক্লজ শর্ত দিয়ে ফিল্টার করতে সাহায্য করে। কোন রেকর্ড গুলো দেখতে চান তা ঠিক করে দেয়।

```sql
SELECT * FROM students WHERE age > 18;
```

---

## 6. What are the LIMIT and OFFSET clauses used for?

- **LIMIT**: কতগুলো রেকর্ড দেখাবেন তা নির্ধারন করে দেয়।
- **OFFSET**: ব্যবহার করে আমরা ঠিক করতে পারি, শুরুতে কতটি রেকর্ড বাদ দিয়ে তারপর থেকে ডেটা দেখাতে হবে। এটি সাধারণত পেজিনেশন (pagination) এর জন্য ব্যবহার হয়।

```sql
SELECT * FROM students LIMIT 10 OFFSET 20;
```

---

## 7. How can you modify data using UPDATE statements?

`UPDATE` কমান্ড দিয়ে টেবিলের ডেটা পরিবর্তন করা যায়।

```sql
UPDATE students SET age = 20 WHERE student_id = 1;
```

`WHERE` ছাড়া `UPDATE` করলে সব রেকর্ড বদলে যাবে।

---

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?

JOIN দিয়ে একাধিক টেবিল থেকে ডেটা একসাথে আনা যায় যেখানে তাদের মধ্যে সম্পর্ক আছে।

**JOIN এর টাইপ:**
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN

```sql
SELECT s.name, e.course_id
FROM students s
JOIN enrollments e ON s.student_id = e.student_id;
```

---

## 9. Explain the GROUP BY clause and its role in aggregation operations.

`GROUP BY` দিয়ে ডেটা গ্রুপ করে তার উপর অ্যাগ্রিগেট ফাংশন (যেমন COUNT, SUM) চালানো যায়।

```sql
SELECT department, COUNT(*) 
FROM students 
GROUP BY department;
```

---

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?

- **COUNT()**: কতগুলো রেকর্ড আছে তা জানা যায়।
- **SUM()**: সব ভ্যালুর যোগফল বের করে।
- **AVG()**: গড় বের করে।

```sql
SELECT COUNT(*) FROM students;
SELECT SUM(marks) FROM results;
SELECT AVG(age) FROM students;
```