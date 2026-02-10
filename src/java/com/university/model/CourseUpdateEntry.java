package com.university.model;

public class CourseUpdateEntry {

    private Course course;
    private long updatedAtMillis;
    private String lecturerKey;

    public CourseUpdateEntry() {
    }

    public CourseUpdateEntry(Course course, long updatedAtMillis) {
        this.course = course;
        this.updatedAtMillis = updatedAtMillis;
    }

    public CourseUpdateEntry(Course course, long updatedAtMillis, String lecturerKey) {
        this.course = course;
        this.updatedAtMillis = updatedAtMillis;
        this.lecturerKey = lecturerKey;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public long getUpdatedAtMillis() {
        return updatedAtMillis;
    }

    public void setUpdatedAtMillis(long updatedAtMillis) {
        this.updatedAtMillis = updatedAtMillis;
    }

    public String getLecturerKey() {
        return lecturerKey;
    }

    public void setLecturerKey(String lecturerKey) {
        this.lecturerKey = lecturerKey;
    }
}
