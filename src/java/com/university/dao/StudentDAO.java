/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.university.dao;

import com.university.model.Course;
import com.university.model.Student;
import com.university.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class StudentDAO {

    public Student getStudentById(int studentId) {
        String sql = "SELECT * FROM Students WHERE student_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Student(
                            rs.getInt("student_id"),
                            rs.getString("first_name"),
                            rs.getString("last_name"),
                            rs.getString("email")
                    );
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Course> getCoursesForStudent(int studentId) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT c.* FROM Courses c " +
                     "JOIN StudentCourse sc ON c.course_id = sc.course_id " +
                     "WHERE sc.student_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Course c = new Course(
                            rs.getInt("course_id"),
                            rs.getString("course_code"),
                            rs.getString("course_name"),
                            rs.getString("instructor"),
                            rs.getString("schedule")
                    );
                    list.add(c);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
