-- ============================================
-- Script Verifikasi dan Perbaikan RLS Policies
-- ============================================
-- 
-- Migration ini memastikan RLS policies benar dan sinkron
-- untuk mendukung login guru (authenticated) dan siswa (anon)
--
-- ============================================

-- ============================================
-- 1. ENABLE RLS PADA SEMUA TABEL
-- ============================================
ALTER TABLE teachers ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE class_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE materials ENABLE ROW LEVEL SECURITY;
ALTER TABLE assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE assignment_classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendances ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE newsroom ENABLE ROW LEVEL SECURITY;

-- ============================================
-- 2. HAPUS POLICIES LAMA (Jika ada)
-- ============================================
-- Teachers
DROP POLICY IF EXISTS "Teachers can view all teachers" ON teachers;
DROP POLICY IF EXISTS "Teachers can insert their profile" ON teachers;
DROP POLICY IF EXISTS "Teachers can update all teacher profiles" ON teachers;

-- Students
DROP POLICY IF EXISTS "Teachers can view all students" ON students;
DROP POLICY IF EXISTS "Teachers can create students" ON students;
DROP POLICY IF EXISTS "Teachers can update all students" ON students;
DROP POLICY IF EXISTS "Teachers can delete students" ON students;
DROP POLICY IF EXISTS "Students can view own profile" ON students;

-- Classes
DROP POLICY IF EXISTS "Teachers can view all classes" ON classes;
DROP POLICY IF EXISTS "Teachers can create classes" ON classes;
DROP POLICY IF EXISTS "Teachers can update all classes" ON classes;
DROP POLICY IF EXISTS "Teachers can delete classes" ON classes;
DROP POLICY IF EXISTS "Students can view enrolled classes" ON classes;

-- Class Students
DROP POLICY IF EXISTS "Teachers can manage class_students" ON class_students;
DROP POLICY IF EXISTS "Students can view their enrollments" ON class_students;

-- Materials
DROP POLICY IF EXISTS "Teachers can manage all materials" ON materials;
DROP POLICY IF EXISTS "Students can view enrolled class materials" ON materials;

-- Assignments
DROP POLICY IF EXISTS "Teachers can manage all assignments" ON assignments;
DROP POLICY IF EXISTS "Students can view assignments for enrolled classes" ON assignments;

-- Assignment Classes
DROP POLICY IF EXISTS "Teachers can manage assignment_classes" ON assignment_classes;
DROP POLICY IF EXISTS "Students can view assignment_classes" ON assignment_classes;

-- Questions
DROP POLICY IF EXISTS "Teachers can manage all questions" ON questions;
DROP POLICY IF EXISTS "Students can view questions for visible assignments" ON questions;

-- Submissions
DROP POLICY IF EXISTS "Teachers can manage all submissions" ON submissions;
DROP POLICY IF EXISTS "Students can manage own submissions" ON submissions;

-- Answers
DROP POLICY IF EXISTS "Teachers can manage all answers" ON answers;
DROP POLICY IF EXISTS "Students can manage own answers" ON answers;

-- Attendances
DROP POLICY IF EXISTS "Teachers can manage all attendances" ON attendances;
DROP POLICY IF EXISTS "Students can view own attendances" ON attendances;

-- Notifications
DROP POLICY IF EXISTS "Teachers can view their notifications" ON notifications;
DROP POLICY IF EXISTS "Students can view their notifications" ON notifications;

-- Activity Logs
DROP POLICY IF EXISTS "Teachers can view all activity logs" ON activity_logs;

-- Newsroom
DROP POLICY IF EXISTS "Teachers can manage all newsroom" ON newsroom;
DROP POLICY IF EXISTS "Students can view published newsroom" ON newsroom;
DROP POLICY IF EXISTS "Service role can insert external news" ON newsroom;

-- ============================================
-- 3. BUAT POLICIES BARU
-- ============================================

-- TEACHERS
CREATE POLICY "Teachers can view all teachers" ON teachers
  FOR SELECT TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Teachers can insert their profile" ON teachers
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = id);

CREATE POLICY "Teachers can update all teacher profiles" ON teachers
  FOR UPDATE TO authenticated USING (auth.uid() IS NOT NULL);

-- STUDENTS
-- ⚠️ PENTING: Policy untuk anon memungkinkan siswa login tanpa Supabase Auth
CREATE POLICY "Teachers can view all students" ON students
  FOR SELECT TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Teachers can create students" ON students
  FOR INSERT TO authenticated WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Teachers can update all students" ON students
  FOR UPDATE TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Teachers can delete students" ON students
  FOR DELETE TO authenticated USING (auth.uid() IS NOT NULL);

-- ⚠️ PENTING: Policy ini memungkinkan siswa login (menggunakan anon role)
CREATE POLICY "Students can view own profile" ON students
  FOR SELECT TO anon USING (true);

-- CLASSES
CREATE POLICY "Teachers can view all classes" ON classes
  FOR SELECT TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Teachers can create classes" ON classes
  FOR INSERT TO authenticated WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Teachers can update all classes" ON classes
  FOR UPDATE TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Teachers can delete classes" ON classes
  FOR DELETE TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can view enrolled classes" ON classes
  FOR SELECT TO anon USING (
    id IN (SELECT class_id FROM class_students WHERE student_id IN (SELECT id FROM students))
  );

-- CLASS STUDENTS
CREATE POLICY "Teachers can manage class_students" ON class_students
  FOR ALL TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can view their enrollments" ON class_students
  FOR SELECT TO anon USING (true);

-- MATERIALS
CREATE POLICY "Teachers can manage all materials" ON materials
  FOR ALL TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can view enrolled class materials" ON materials
  FOR SELECT TO anon USING (
    class_id IN (SELECT class_id FROM class_students WHERE student_id IN (SELECT id FROM students))
  );

-- ASSIGNMENTS
CREATE POLICY "Teachers can manage all assignments" ON assignments
  FOR ALL TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can view assignments for enrolled classes" ON assignments
  FOR SELECT TO anon USING (
    assignment_type = 'tambahan' OR
    class_id IN (SELECT class_id FROM class_students WHERE student_id IN (SELECT id FROM students)) OR
    id IN (SELECT assignment_id FROM assignment_classes WHERE class_id IN (SELECT class_id FROM class_students WHERE student_id IN (SELECT id FROM students)))
  );

-- ASSIGNMENT CLASSES
CREATE POLICY "Teachers can manage assignment_classes" ON assignment_classes
  FOR ALL TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can view assignment_classes" ON assignment_classes
  FOR SELECT TO anon USING (true);

-- QUESTIONS
CREATE POLICY "Teachers can manage all questions" ON questions
  FOR ALL TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can view questions for visible assignments" ON questions
  FOR SELECT TO anon USING (true);

-- SUBMISSIONS
CREATE POLICY "Teachers can manage all submissions" ON submissions
  FOR ALL TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can manage own submissions" ON submissions
  FOR ALL TO anon USING (student_id IN (SELECT id FROM students));

-- ANSWERS
CREATE POLICY "Teachers can manage all answers" ON answers
  FOR ALL TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can manage own answers" ON answers
  FOR ALL TO anon USING (
    submission_id IN (SELECT id FROM submissions WHERE student_id IN (SELECT id FROM students))
  );

-- ATTENDANCES
CREATE POLICY "Teachers can manage all attendances" ON attendances
  FOR ALL TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can view own attendances" ON attendances
  FOR SELECT TO anon USING (student_id IN (SELECT id FROM students));

-- NOTIFICATIONS
CREATE POLICY "Teachers can view their notifications" ON notifications
  FOR ALL USING (user_type = 'teacher' AND user_id = auth.uid());

CREATE POLICY "Students can view their notifications" ON notifications
  FOR ALL USING (user_type = 'student' AND user_id IN (SELECT id FROM students));

-- ACTIVITY LOGS
CREATE POLICY "Teachers can view all activity logs" ON activity_logs
  FOR SELECT TO authenticated USING (auth.uid() IS NOT NULL);

-- NEWSROOM
CREATE POLICY "Teachers can manage all newsroom" ON newsroom
  FOR ALL USING (auth.uid() IS NOT NULL);

CREATE POLICY "Students can view published newsroom" ON newsroom
  FOR SELECT TO anon USING (
    status = 'published' AND (target_audience = 'all' OR target_audience = 'students')
  );

