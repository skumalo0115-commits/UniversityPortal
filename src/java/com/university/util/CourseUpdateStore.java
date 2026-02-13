package com.university.util;

import com.university.model.Course;
import com.university.model.CourseUpdateEntry;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public final class CourseUpdateStore {

    private static final long UPDATE_TTL_MILLIS = 24L * 60L * 60L * 1000L;

    private static final Map<String, List<CourseUpdateEntry>> UPDATES_BY_LECTURER = new HashMap<>();

    private CourseUpdateStore() {
    }

    public static synchronized void recordUpdate(String lecturerKey, Course course) {
        if (lecturerKey == null || lecturerKey.trim().isEmpty() || course == null) {
            return;
        }

        pruneExpiredLocked();

        List<CourseUpdateEntry> lecturerUpdates = UPDATES_BY_LECTURER.get(lecturerKey);
        if (lecturerUpdates == null) {
            lecturerUpdates = new ArrayList<>();
            UPDATES_BY_LECTURER.put(lecturerKey, lecturerUpdates);
        }

        lecturerUpdates.removeIf(entry -> entry != null
                && entry.getCourse() != null
                && entry.getCourse().getCourseId() == course.getCourseId());

        lecturerUpdates.add(0, new CourseUpdateEntry(course, System.currentTimeMillis(), lecturerKey));
    }

    public static synchronized List<Course> getLecturerRecentCourses(String lecturerKey) {
        pruneExpiredLocked();

        List<Course> courses = new ArrayList<>();
        if (lecturerKey == null || lecturerKey.trim().isEmpty()) {
            return courses;
        }

        List<CourseUpdateEntry> lecturerUpdates = UPDATES_BY_LECTURER.get(lecturerKey);
        if (lecturerUpdates == null) {
            return courses;
        }

        for (CourseUpdateEntry entry : lecturerUpdates) {
            if (entry != null && entry.getCourse() != null) {
                courses.add(entry.getCourse());
            }
        }

        return courses;
    }

    public static synchronized List<Course> getRecentCoursesForIds(Set<Integer> courseIds) {
        pruneExpiredLocked();

        List<Course> courses = new ArrayList<>();
        if (courseIds == null || courseIds.isEmpty()) {
            return courses;
        }

        Set<Integer> seenCourseIds = new HashSet<>();

        for (List<CourseUpdateEntry> lecturerUpdates : UPDATES_BY_LECTURER.values()) {
            if (lecturerUpdates == null) {
                continue;
            }

            for (CourseUpdateEntry entry : lecturerUpdates) {
                if (entry == null || entry.getCourse() == null) {
                    continue;
                }

                Course course = entry.getCourse();
                int courseId = course.getCourseId();

                if (courseIds.contains(courseId) && !seenCourseIds.contains(courseId)) {
                    courses.add(course);
                    seenCourseIds.add(courseId);
                }
            }
        }

        return courses;
    }

    private static void pruneExpiredLocked() {
        long cutoff = System.currentTimeMillis() - UPDATE_TTL_MILLIS;

        List<String> emptyLecturerKeys = new ArrayList<>();

        for (Map.Entry<String, List<CourseUpdateEntry>> entry : UPDATES_BY_LECTURER.entrySet()) {
            List<CourseUpdateEntry> updates = entry.getValue();

            if (updates == null) {
                emptyLecturerKeys.add(entry.getKey());
                continue;
            }

            updates.removeIf(item -> item == null
                    || item.getCourse() == null
                    || item.getUpdatedAtMillis() < cutoff);

            if (updates.isEmpty()) {
                emptyLecturerKeys.add(entry.getKey());
            }
        }

        for (String key : emptyLecturerKeys) {
            UPDATES_BY_LECTURER.remove(key);
        }
    }
}
