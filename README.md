# 🎓✨ University Portal — Premium Java EE Campus Experience

## 📖 Project Description
The **University Portal** is a web-based Java application with **JDBC database integration**, designed for **students** and **faculty**.  
- **Students** can view personalized course schedules.  
- **Faculty** can update course details like instructors and schedules.  
This multipage portal demonstrates dynamic, database-driven web functionality with secure, role-based features.🚀

---
  
## 🌟 What is this project?
**University Portal** is a full-stack web application for managing core academic workflows between:

- 👩‍🎓 **Students** (view personal schedules and course data)
- 👨‍🏫 **Lecturers/Faculty** (update course instructor and schedule details)

It combines strong backend fundamentals (MVC-style layering, DAO pattern, prepared statements) with a modern, animated UI (glassmorphism, dark/light mode, transitions, responsive layout). 🎨

---

## 🛠️ Technologies Used
- Java (Servlets)
- JDBC (MySQL/PostgreSQL)
- HTML / CSS
- Apache Tomcat
- NetBeans IDE
## 🧠 Why this project is cool

This isn’t just a CRUD demo — it’s an end-to-end campus portal with:

- ✅ Role-based navigation and access behavior
- ✅ Session-driven login/logout flow
- ✅ Dynamic student schedule retrieval
- ✅ Faculty update workflows with server-side validation
- ✅ Recently-updated course visibility logic
- ✅ Mobile-friendly, premium UI experience

This project gives is a real-world baseline, because it is project based on Java web development and demonstrating full-stack architecture 💼

---

## 🏗️ Architecture Overview

The codebase follows a practical layered structure:

- **Model Layer** (`com.university.model`)
  Represents domain entities like `Student`, `Course`, `Faculty`, and update metadata.

- **DAO Layer** (`com.university.dao`)
  Handles all SQL/database interactions using **PreparedStatement only** for safe, parameterized queries.

- **Servlet Layer** (`com.university.servlet`)
  Coordinates HTTP request handling, validation, role checks, session state, and view forwarding.

- **View Layer** (`web/*.jsp`)
  Renders student/faculty/login/dashboard pages with responsive, themeable UI.

- **Static Assets** (`web/css`, `web/js`)
  Styling, animations, theme toggle, and UI interactions.

---

## 🚀 Core Features

### 🔐 Authentication & Session Flow
- Login with role selection (`student` or `lecturer`)
- Session-aware dashboard experience
- Logout support with redirect handling

### 👩‍🎓 Student Experience
- Enter Student ID to load personalized schedule
- View student profile details (name, email)
- See updated modules relevant to enrolled courses
- Friendly validation and empty-state handling (no ugly null values)

### 👨‍🏫 Lecturer Experience
- Select a course and update:
  - Instructor
  - Schedule
- Secure update handling with validation feedback
- Recently updated courses panel for quick visibility

### 🕒 Recent Updates Logic
- Course updates are tracked with timestamp metadata
- Update visibility is scoped to meaningful users/flows
- Designed around a **24-hour update window** concept

### 🎨 Premium UI/UX
- Glassmorphism-inspired cards
- Dark/light theme toggle
- Smooth hover states and subtle micro-interactions
- Responsive layout for desktop/tablet/mobile

---

## 🧰 Tech Stack

- ☕ **Java (Servlet API / JSP)**
- 🗄️ **JDBC**
- 🐬 **MySQL**
- 🌐 **Apache Tomcat**
- 🧱 **HTML5 / CSS3 / JavaScript**
- 🛠️ **NetBeans** (recommended) or any Java web IDE

---

## 🗂️ Project Structure (High Level)

```text
UniversityPortal/
├── src/java/com/university/
│   ├── dao/
│   ├── model/
│   ├── servlet/
│   └── util/
├── web/
│   ├── WEB-INF/web.xml
│   ├── css/style.css
│   ├── js/app.js
│   ├── index.jsp
│   ├── login.jsp
│   ├── student.jsp
│   ├── faculty.jsp
│   ├── courses.jsp
│   └── error.jsp
└── README.md
```

---

## 🛢️ Database Schema (Concept)

The portal uses three core tables:

- `Students`
- `Courses`
- `StudentCourse` (many-to-many mapping)

This design supports:
- Student enrollment across multiple courses
- Course reuse across multiple students
- Efficient joins for personalised schedule loading

---

## ⚙️ Setup Guide
```bash
### 1) Clone the repo

cd UniversityPortal


### 2) Configure database

- Create/import your MySQL schema and seed data.
- Update DB credentials in:
  - `src/java/com/university/util/DBConnection.java`

### 3) Add JDBC driver

- Add MySQL Connector/J to your web project libraries.
- In NetBeans: **Project Properties → Libraries → Add JAR/Folder**.

### 4) Run on Tomcat

- Use Tomcat 9+.
- Deploy and run project from IDE or build tool.

### 5) Open app

Typical local URLs:

- `http://localhost:8080/UniversityPortal/index.jsp`
- `http://localhost:8080/UniversityPortal/login`
- `http://localhost:8080/UniversityPortal/student`
- `http://localhost:8080/UniversityPortal/faculty`
- `http://localhost:8080/UniversityPortal/courses`

---
```

## 🧪 Validation & Quality Notes

- SQL calls are structured around prepared statements.
- UI handles blank/empty states gracefully.
- Role access behavior is validated in servlet flow.
- Session + update visibility logic implemented across views.

---

## 🛣️ Suggested Future Improvements

If I want to level this up even further:

- 🔒 Password hashing and real authentication provider
- 🧾 Audit trail table for persistent update history in DB
- 📊 Lecturer analytics dashboard
- 🔔 Notification center for students
- 🧪 Automated tests (JUnit + integration tests)
- 🐳 Dockerized local environment for one-command setup

---

## 🤝 Contributing

Contributions are welcome!
If you improve UI, validations, or data flow logic, feel free to open a PR. 🙌

---

## 📄 License

Licensed under the **MIT License**.
See `LICENSE` for details.

---

## 💬 Final Note

This project is a strong demonstration of combining **classic Java EE architecture** with **modern UX expectations**.
If you present this in a portfolio, highlight:

- your MVC layering
- role-based behavior
- DB-safe query handling
- and polished frontend execution
