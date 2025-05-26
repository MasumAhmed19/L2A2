###  ১. **PostgreSQL কী?**

**PostgreSQL** হলো একটি ওপেন সোর্স রিলেশনাল ডেটাবেজ ম্যানেজমেন্ট সিস্টেম (RDBMS), যেটি SQL (Structured Query Language) ভিত্তিক। এটি শুধু রিলেশনাল ডেটা নয়, বরং JSON, XML-এর মতো semi-structured ডেটাও সাপোর্ট করে, তাই একে **object-relational** database বলা হয়।

🔹 **মূল বৈশিষ্ট্য**:

* Complex Query Handling
* Support for Triggers, Views, Stored Procedures
* Full Text Search
* Nested Query

---


###  ২. **PostgreSQL-এ Primary Key এবং Foreign Key এর ধারণা ব্যাখ্যা করুন।**

**Primary Key** হলো এমন একটি কলাম (বা কলামের সমন্বয়), যা প্রতিটি সারিকে ইউনিকভাবে শনাক্ত করে। এটি `NULL` গ্রহণ করে না।

**Foreign Key** হলো এমন একটি কলাম যা অন্য একটি টেবিলের Primary Key এর সাথে সম্পর্ক তৈরি করে। এটি relational integrity বজায় রাখে।


📌 **উদাহরণ**:

```sql
CREATE TABLE departments (
  dept_id SERIAL PRIMARY KEY,
  dept_name VARCHAR(100)
);

CREATE TABLE employees (
  emp_id SERIAL PRIMARY KEY,
  emp_name VARCHAR(100),
  dept_id INT REFERENCES departments(dept_id)
);
```

এখানে `employees` টেবিলের `dept_id` হলো `departments` টেবিলের `dept_id` এর Foreign Key।

---

### ৩. **VARCHAR এবং CHAR ডেটা টাইপের পার্থক্য কী?**

দুইটি ডেটা টাইপই টেক্সট ডেটা সংরক্ষণের জন্য ব্যবহৃত হয়, তবে:

🔹 **CHAR(n)**:

* Fixed-length (স্থির দৈর্ঘ্য)।
* যদি ইনপুট ডেটা `n` ক্যারেক্টারের কম হয়, তাহলে বাকি জায়গা space দিয়ে পূরণ হয়।
* পারফরমেন্সে একটু দ্রুত হতে পারে ছোট ফিক্সড সাইজ ডেটার জন্য।

🔹 **VARCHAR(n)**:

* Variable-length (পরিবর্তনশীল দৈর্ঘ্য)।
* ঠিক যতটুকু ডেটা দরকার, ততটুকুই সংরক্ষণ করে।
* storage-efficient এবং সাধারণত বেশি ব্যবহৃত হয়।

📌 **উদাহরণ**:

```sql
CREATE TABLE example1 (
  name CHAR(10)
);

CREATE TABLE example2 (
  name VARCHAR(10)
);
```

`CHAR(10)`-এ যদি “Masum” রাখা হয়, তাহলে তা "Masum     " (৫টি অতিরিক্ত স্পেসসহ) হয়ে সংরক্ষিত হয়, কিন্তু `VARCHAR(10)`-এ ঠিক “Masum” ই রাখা হবে।

---


### ৪. **LIMIT এবং OFFSET ক্লজ কী কাজে ব্যবহার হয়?**

**LIMIT** এবং **OFFSET** মূলত PostgreSQL-এ ডেটা **pagination** বা **partial data fetch** করার জন্য ব্যবহৃত হয়। যখন একটি টেবিলের অনেকগুলো রেকর্ড থাকে, তখন সবগুলো একসাথে না এনে নির্দিষ্ট সংখ্যক রেকর্ড আনতে LIMIT এবং OFFSET ব্যবহার করা হয়।

🔹 **LIMIT**: কয়টি রেকর্ড দেখানো হবে তা নির্ধারণ করে।

🔹 **OFFSET**: কতগুলো রেকর্ড স্কিপ করে দেখানো শুরু হবে তা নির্ধারণ করে।

📌 **উদাহরণ**:

```sql
SELECT * FROM products LIMIT 10;
```

এটি products টেবিল থেকে প্রথম ১০টি রেকর্ড দেখাবে।

```sql
SELECT * FROM products OFFSET 10 LIMIT 10;
```

এটি প্রথম ১০টি রেকর্ড বাদ দিয়ে পরবর্তী ১০টি রেকর্ড দেখাবে (যেমন: ১১ থেকে ২০ নম্বর রেকর্ড)।


---

### ৫. **UPDATE স্টেটমেন্ট ব্যবহার করে কীভাবে ডেটা পরিবর্তন করা যায়?**

**UPDATE** স্টেটমেন্ট PostgreSQL-এ বিদ্যমান ডেটা রেকর্ড আপডেট বা পরিবর্তন করতে ব্যবহৃত হয়। এটি `SET` এবং `WHERE` ক্লজের মাধ্যমে নির্দিষ্ট কলামের মান আপডেট করে।

📌 **Syntax**:

```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

📌 **উদাহরণ**:

```sql
UPDATE employees
SET salary = salary + 5000
WHERE dept_id = 2;
```

উপরের কোয়েরি সেই সব `employees`-এর বেতন ৫০০০ টাকা করে বাড়াবে যাদের `dept_id = 2`।