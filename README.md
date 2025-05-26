## 1. What is PostgreSQL?

**PostgreSQL** হলো একটি শক্তিশালী ফ্রি এবং ওপেন সোর্স ডেটাবেইজ সিস্টেম। এটি রিলেশনাল ডেটাবেইজ মডেল এবং অনেক আধুনিক ফিচার সাপোর্ট করে যেমন: JSON ডেটা, স্টোরড প্রোসিজার, ট্রানজেকশন, ফোরেন কি ইত্যাদি।

---

## 2. What is the purpose of a database schema in PostgreSQL?

স্কিমা (Schema) হচ্ছে PostgreSQL ডেটাবেইজের একটি লজিক্যাল কাঠামো যেখানে টেবিল, ভিউ, ইন্ডেক্স, ফাংশন, সিকোয়েন্স ইত্যাদি অবজেক্ট রাখা হয়।

একটি ডেটাবেইজে একাধিক স্কিমা থাকতে পারে, এবং প্রতিটি স্কিমা একটি আলাদা namespace-এর মতো কাজ করে। এতে করে একই নামের টেবিল বা ফাংশন আলাদা স্কিমাতে রাখা যায়, ফলে নেম কনফ্লিক্ট এড়ানো যায় এবং অ্যাক্সেস কন্ট্রোল ও ডেটা ম্যানেজমেন্ট সহজ হয়।

উদাহরণ: `public`, `admin`, `sales` এই নামে স্কিমা থাকতে পারে, যেখানে আলাদা আলাদা টেবিল ও ফাংশন থাকবে, যেমন `admin.users`, `sales.customers` ইত্যাদি।

---

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

- **Primary Key**: হলো এক বা একাধিক কলামের সমষ্টি যা একটি টেবিলের প্রতিটি রেকর্ডকে ইউনিকভাবে চিহ্নিত করে। এটা কখনো ফাঁকা (NULL) হয় না।
- **Foreign Key**: হলো অন্য একটি টেবিলের Primary Key বা Unique Key এর এর সাথে সম্পর্ক তৈরি করে ।

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

- **VARCHAR(n)**: প্রয়োজন অনুযায়ী যতটুকু জায়গা লাগে ঠিক ততটুকুই জায়গা নেয়।
- **CHAR(n)**: সবসময় ঠিক n ক্যারেক্টার জায়গা নেয়, কম হলে ফাঁকা (space) জায়গা দিয়ে পূরণ করে।

**উদাহরণ:**

```sql
name VARCHAR(50)
code CHAR(10)
```

---

## 5. Explain the purpose of the WHERE clause in a SELECT statement.

`WHERE` ক্লজ দিয়ে নির্দিষ্ট শর্ত অনুযায়ী ডেটা ফিল্টার করা যায়। অর্থাৎ একজন ইউজারের কন্ডিশনের উপর ভিত্তিতে করে ডেটা দেখানো হবে।

**উদাহরণ:**

```sql
SELECT * FROM students WHERE age > 18;
```

---

## 6. What are the LIMIT and OFFSET clauses used for?

- **LIMIT**: শুরুতে কতটি রেকর্ড দেখানো হবে তা নির্ধারন করা হয়।
- **OFFSET**: শুরুতে কতটি রেকর্ড বাদ দেওয়া হবে এবং তারপর থেকে ডেটা দেখানো হবে। এটি সাধারণত পেজিনেশন (pagination) এর জন্য ব্যবহার হয়।

**উদাহরণ:**

```sql
SELECT * FROM students LIMIT 10 OFFSET 20;
```

---

## 7. How can you modify data using UPDATE statements?

`UPDATE` কমান্ড দিয়ে একটি টেবিলের নির্দিষ্ট কোনো ডেটা পরিবর্তন করা যায়। তবে আপনাকে করে নির্দিষ্ট বলে দিতে আপনি একটি টেবিলের কোন ডেটা পরিবর্তন করতে চান। আর নির্দিষ্ট করে বলে দেওয়ার জন্য আমরা `WHERE` ব্যবহার করি। `WHERE` ছাড়া `UPDATE` করলে সব ডেটা পরিবর্তন হয়ে যাবে।

**উদাহরণ:**

```sql
UPDATE students SET age = 20 WHERE student_id = 1;
```

---

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?

`JOIN` কমান্ড দিয়ে একাধিক টেবিলের মধ্যে সম্পর্কযুক্ত ডেটাগুলোকে একসাথে যুক্ত করে একটি কম্বাইন্ড রেজাল্ট তৈরি করে।

**JOIN এর টাইপ:**

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN

**উদাহরণ:**

```sql
SELECT s.name, e.course_id
FROM students s
JOIN enrollments e ON s.student_id = e.student_id;
```

---

## 9. Explain the GROUP BY clause and its role in aggregation operations.

`GROUP BY` ক্লজ ব্যবহার করে ডেটাকে নির্দিষ্ট কলামের মান অনুযায়ী গ্রুপ করা যায়। এরপর প্রতিটি গ্রুপের উপর aggregation functions (যেমন COUNT(), SUM(), AVG(), MAX(), MIN()) ব্যবহার করে গ্রুপভিত্তিক রেজাল্ট পাওয়া যায়।

**উদাহরণ:**

```sql
SELECT department, COUNT(*)
FROM students
GROUP BY department;
```

---

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?

- **COUNT()**: কতগুলো ডেটা বা রেকর্র আছে তা জানা যায়।
- **SUM()**: সবগুলো ভ্যালুর যোগফল বের করা যায়।
- **AVG()**: সবগুলো ভ্যালুর গড় বের করা যায়।

**উদাহরণ:**

```sql
SELECT COUNT(*) FROM students;
SELECT SUM(marks) FROM results;
SELECT AVG(age) FROM students;
```
