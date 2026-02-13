const themeToggle = document.getElementById("themeToggle");
const courseSearch = document.getElementById("courseSearch");
const facultyForm = document.getElementById("facultyForm");

const contextPath = (() => {
    const segments = window.location.pathname.split("/").filter(Boolean);
    if (segments.length === 0) {
        return "";
    }

    const pageLikeLastSegments = new Set([
        "login",
        "logout",
        "student",
        "faculty",
        "courses",
        "index.jsp",
        "error.jsp"
    ]);

    const last = segments[segments.length - 1];
    if (pageLikeLastSegments.has(last)) {
        if (segments.length === 1) {
            return "";
        }
        return `/${segments.slice(0, -1).join("/")}`;
    }

    return `/${segments.join("/")}`;
})();

const withContextPath = (path) => {
    if (!path) {
        return contextPath || "/";
    }
    if (/^https?:\/\//i.test(path)) {
        return path;
    }
    const normalizedPath = path.startsWith("/") ? path : `/${path}`;
    return `${contextPath}${normalizedPath}`;
};

const applyTheme = (theme) => {
    document.body.classList.toggle("theme-light", theme === "light");
    document.body.classList.toggle("theme-dark", theme !== "light");
};

const storedTheme = localStorage.getItem("universityTheme") || "dark";
applyTheme(storedTheme);

if (themeToggle) {
    themeToggle.addEventListener("click", () => {
        const nextTheme = document.body.classList.contains("theme-light") ? "dark" : "light";
        localStorage.setItem("universityTheme", nextTheme);
        applyTheme(nextTheme);
    });
}

if (courseSearch) {
    courseSearch.addEventListener("input", (event) => {
        const query = (event.target.value || "").toLowerCase();
        document.querySelectorAll(".course-card").forEach((card) => {
            const data = card.getAttribute("data-search") || "";
            const visible = data.toLowerCase().includes(query);
            card.style.display = visible ? "block" : "none";
        });
    });
}

const buildCourseKey = (course) => {
    const code = (course && course.code ? course.code : "").toString().trim().toLowerCase();
    const name = (course && course.name ? course.name : "").toString().trim().toLowerCase();
    return `${code}::${name}`;
};

const renderUpdatedCourse = (course) => {
    const card = document.createElement("article");
    card.className = "glass-card course-card";
    card.dataset.courseKey = buildCourseKey(course);
    card.innerHTML = `
        <div class="chip">${course.code}</div>
        <h2>${course.name}</h2>
        <p><strong>Instructor:</strong> ${course.instructor}</p>
        <p><strong>Schedule:</strong> ${course.schedule}</p>
    `;
    return card;
};

const upsertUpdatedCourse = (updatedList, course) => {
    if (!updatedList) return;

    const key = buildCourseKey(course);
    let existingCard = null;

    updatedList.querySelectorAll(".course-card").forEach((card) => {
        if (card.dataset.courseKey === key) {
            existingCard = card;
        }
    });

    const nextCard = renderUpdatedCourse(course);
    if (existingCard) {
        existingCard.replaceWith(nextCard); // update existing block (no duplicate)
    } else {
        updatedList.prepend(nextCard);
    }
};

if (facultyForm && facultyForm.dataset.ajax === "true") {
    facultyForm.addEventListener("submit", async (event) => {
        event.preventDefault();

        const status = document.querySelector(".status");
        const courseSelect = facultyForm.querySelector("#courseId");
        const instructorInput = facultyForm.querySelector("#instructor");
        const scheduleInput = facultyForm.querySelector("#schedule");

        const courseId = courseSelect ? (courseSelect.value || "").toString().trim() : "";
        const instructor = instructorInput ? (instructorInput.value || "").toString().trim() : "";
        const schedule = scheduleInput ? (scheduleInput.value || "").toString().trim() : "";

        const payload = new URLSearchParams();
        payload.set("courseId", courseId);
        payload.set("instructor", instructor);
        payload.set("schedule", schedule);

        try {
            const response = await fetch(withContextPath("/faculty"), {
                method: "POST",
                headers: {
                    "X-Requested-With": "XMLHttpRequest",
                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: payload.toString()
            });

            const contentType = response.headers.get("content-type") || "";
            if (!contentType.includes("application/json")) {
                window.location.href = withContextPath("/login");
                return;
            }

            const data = await response.json();

            if (status) {
                status.textContent = data.message || "";
            }

            if (data.updated && data.course) {
                const updatedList = document.getElementById("updatedCoursesList");
                if (updatedList) {
                    const emptyMessage = document.getElementById("updatedCoursesEmpty");
                    if (emptyMessage) emptyMessage.remove();
                    upsertUpdatedCourse(updatedList, data.course);
                }
            }
        } catch (error) {
            if (status) {
                status.textContent = "Update failed. Please try again.";
            }
        }
    });
}

window.addEventListener("load", () => {
    document.querySelectorAll(".glass-card").forEach((card, index) => {
        card.style.animation = `fadeIn 0.6s ease ${index * 0.05}s forwards`;
        card.style.opacity = 0;
    });

    document.querySelectorAll(".btn").forEach((button) => {
        button.addEventListener("click", (event) => {
            const ripple = document.createElement("span");
            ripple.className = "ripple";
            const rect = button.getBoundingClientRect();
            ripple.style.left = `${event.clientX - rect.left}px`;
            ripple.style.top = `${event.clientY - rect.top}px`;
            button.appendChild(ripple);
            setTimeout(() => ripple.remove(), 600);
        });
    });
});

if (document.head) {
    const style = document.createElement("style");
    style.textContent = `
@keyframes fadeIn {
    to { opacity: 1; transform: translateY(0); }
    from { opacity: 0; transform: translateY(12px); }
}
.ripple {
    position: absolute;
    width: 12px;
    height: 12px;
    border-radius: 999px;
    background: rgba(255, 255, 255, 0.6);
    transform: translate(-50%, -50%) scale(0);
    animation: ripple 0.6s ease forwards;
    pointer-events: none;
}
@keyframes ripple {
    to { transform: translate(-50%, -50%) scale(16); opacity: 0; }
}
`;
    document.head.appendChild(style);
}
