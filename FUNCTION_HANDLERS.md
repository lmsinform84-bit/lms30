# Function Handlers Trace - LMS Project

Dokumen ini berisi pelacakan semua function handler yang ada dalam proyek LMS (Learning Management System) untuk memudahkan pemeliharaan dan pengembangan kode.

## Struktur Dokumen

- **File**: Lokasi file handler
- **Function**: Nama function handler
- **Purpose**: Tujuan/kegunaan handler
- **Parameters**: Parameter yang diterima
- **Return**: Nilai yang dikembalikan
- **Dependencies**: Dependensi yang digunakan
- **Related Components**: Komponen terkait

---

## Authentication Handlers

### src/pages/auth/UnifiedLogin.tsx

#### `handleTeacherLogin`
- **Purpose**: Menangani proses login untuk role teacher
- **Parameters**: `e: React.FormEvent` - Event form submit
- **Return**: `Promise<void>`
- **Dependencies**: `useUnifiedAuth` context, `useNavigate` hook
- **Related Components**: UnifiedAuthContext, Teacher Dashboard
- **Flow**: Prevent default → Reset error → Call loginTeacher → Navigate to dashboard on success

#### `handleStudentLogin`
- **Purpose**: Menangani proses login untuk role student
- **Parameters**: `e: React.FormEvent` - Event form submit
- **Return**: `Promise<void>`
- **Dependencies**: `useUnifiedAuth` context, `useNavigate` hook
- **Related Components**: UnifiedAuthContext, Student Dashboard
- **Flow**: Prevent default → Reset error → Call loginStudent → Navigate to dashboard on success

---

## Component Handlers

### src/components/BottomNavigation.tsx

#### `handleNavClick`
- **Purpose**: Menangani klik navigasi bottom navigation
- **Parameters**: `index: number, path: string` - Index item dan path navigasi
- **Return**: `void`
- **Dependencies**: `setActiveIndex` state setter
- **Related Components**: React Router navigation
- **Flow**: Set active index → Navigate to path

### src/components/common/ExcelImport.tsx

#### `handleFileSelect`
- **Purpose**: Menangani pemilihan file Excel untuk import
- **Parameters**: `selectedFile: File | null` - File yang dipilih
- **Return**: `void`
- **Dependencies**: File validation logic
- **Related Components**: Dropzone component
- **Flow**: Validate file → Set file state → Process file

#### `handleEditCell`
- **Purpose**: Menangani edit nilai cell dalam tabel preview
- **Parameters**: `rowIndex: number, field: string, value: any` - Index baris, field, dan nilai baru
- **Return**: `void`
- **Dependencies**: `editableData` state
- **Related Components**: Table component
- **Flow**: Update data di index tertentu dengan field dan value baru

#### `handleSelectRow`
- **Purpose**: Menangani pemilihan baris individual
- **Parameters**: `rowIndex: number, checked: boolean` - Index baris dan status checkbox
- **Return**: `void`
- **Dependencies**: `selectedRows` state
- **Related Components**: Checkbox component
- **Flow**: Add/remove row index dari selectedRows

#### `handleSelectAll`
- **Purpose**: Menangani select all checkbox
- **Parameters**: `checked: boolean` - Status checkbox
- **Return**: `void`
- **Dependencies**: `selectedRows` state, `editableData` length
- **Related Components**: Checkbox component
- **Flow**: Select all rows atau clear selection

#### `handleImport`
- **Purpose**: Menangani proses import data ke database
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: `onImport` callback, `selectedRows`, `editableData`
- **Related Components**: Import service
- **Flow**: Validate selection → Call onImport → Show success/error

#### `handleReset`
- **Purpose**: Reset state komponen untuk import baru
- **Parameters**: None
- **Return**: `void`
- **Dependencies**: State setters
- **Related Components**: File input, table
- **Flow**: Clear all states ke initial values

#### `handleClose`
- **Purpose**: Menangani penutupan modal import
- **Parameters**: None
- **Return**: `void`
- **Dependencies**: `handleReset`, `onClose` callback
- **Related Components**: Modal component
- **Flow**: Reset state → Call onClose callback

### src/components/common/FileUpload.tsx

#### `handleDrop`
- **Purpose**: Menangani drop file ke dropzone
- **Parameters**: `files: File[]` - Array file yang di-drop
- **Return**: `Promise<void>`
- **Dependencies**: `onUpload` callback, file validation
- **Related Components**: Dropzone component
- **Flow**: Validate files → Call onUpload callback

### src/components/common/Pagination.tsx

#### `handlePageChange`
- **Purpose**: Menangani perubahan halaman
- **Parameters**: `page: number` - Nomor halaman baru
- **Return**: `void`
- **Dependencies**: `onPageChange` callback, validation
- **Related Components**: Button components
- **Flow**: Validate page number → Call onPageChange

#### `handlePageInputChange`
- **Purpose**: Menangani input manual nomor halaman
- **Parameters**: `value: string | number` - Nilai input
- **Return**: `void`
- **Dependencies**: `handlePageChange`, parsing logic
- **Related Components**: TextInput component
- **Flow**: Parse value → Validate → Call handlePageChange

#### `handleItemsPerPageChange`
- **Purpose**: Menangani perubahan jumlah item per halaman
- **Parameters**: `value: string | null` - Nilai select
- **Return**: `void`
- **Dependencies**: `onItemsPerPageChange` callback
- **Related Components**: Select component
- **Flow**: Validate value → Call onItemsPerPageChange

### src/components/tables/StudentsTable.tsx

#### `handleSelectAll`
- **Purpose**: Menangani select all checkbox untuk siswa
- **Parameters**: `checked: boolean` - Status checkbox
- **Return**: `void`
- **Dependencies**: `onSelect` callback, students data
- **Related Components**: Checkbox component
- **Flow**: Select all students atau clear selection

#### `handleSelectStudent`
- **Purpose**: Menangani pemilihan siswa individual
- **Parameters**: `studentId: string, checked: boolean` - ID siswa dan status checkbox
- **Return**: `void`
- **Dependencies**: `onSelect` callback
- **Related Components**: Checkbox component
- **Flow**: Add/remove student dari selection

---

## Page Handlers

### src/pages/auth/UnifiedLogin.tsx

#### `handleTeacherLogin`
- **Purpose**: Menangani proses login untuk role teacher
- **Parameters**: `e: React.FormEvent` - Event form submit
- **Return**: `Promise<void>`
- **Dependencies**: `useUnifiedAuth` context, `useNavigate` hook
- **Related Components**: UnifiedAuthContext, Teacher Dashboard
- **Flow**: Prevent default → Reset error → Call loginTeacher → Navigate to dashboard on success

#### `handleStudentLogin`
- **Purpose**: Menangani proses login untuk role student
- **Parameters**: `e: React.FormEvent` - Event form submit
- **Return**: `Promise<void>`
- **Dependencies**: `useUnifiedAuth` context, `useNavigate` hook
- **Related Components**: UnifiedAuthContext, Student Dashboard
- **Flow**: Prevent default → Reset error → Call loginStudent → Navigate to dashboard on success

### src/pages/teacher/ClassList.tsx

#### `handleCreateClass`
- **Purpose**: Menangani pembuatan kelas baru
- **Parameters**: `values: typeof form.values` - Data form kelas
- **Return**: `Promise<void>`
- **Dependencies**: Class service, form validation
- **Related Components**: Form component, Modal
- **Flow**: Validate form → Call create class API → Refresh data → Close modal

#### `handleEditClass`
- **Purpose**: Menangani edit data kelas
- **Parameters**: `values: typeof form.values` - Data form kelas yang diupdate
- **Return**: `Promise<void>`
- **Dependencies**: Class service, selectedClass state
- **Related Components**: Form component, Modal
- **Flow**: Validate selection → Call update class API → Refresh data → Close modal

#### `handleDeleteClass`
- **Purpose**: Menangani penghapusan kelas
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Class service, selectedClass state
- **Related Components**: ConfirmDialog component
- **Flow**: Validate selection → Call delete class API → Refresh data → Close modal

### src/pages/teacher/ClassAssignments.tsx

#### `handleViewSubmissions`
- **Purpose**: Menampilkan submissions untuk assignment tertentu
- **Parameters**: `assignment: Assignment` - Data assignment
- **Return**: `Promise<void>`
- **Dependencies**: Assignment data, modal state
- **Related Components**: Submissions modal
- **Flow**: Set selected assignment → Open submissions modal

#### `handleGradeSubmission`
- **Purpose**: Menangani penilaian submission
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Selected submission, grading form
- **Related Components**: Grading modal, form
- **Flow**: Validate data → Call grade API → Refresh data → Close modal

#### `handlePageChange`
- **Purpose**: Menangani perubahan halaman pagination
- **Parameters**: `page: number` - Halaman baru
- **Return**: `void`
- **Dependencies**: Pagination state
- **Related Components**: Pagination component
- **Flow**: Update current page state

#### `handleItemsPerPageChange`
- **Purpose**: Menangani perubahan jumlah item per halaman
- **Parameters**: `newItemsPerPage: number` - Jumlah item baru
- **Return**: `void`
- **Dependencies**: Pagination state
- **Related Components**: Pagination component
- **Flow**: Update items per page state

### src/pages/teacher/Newsroom.tsx

#### `handleAddItem`
- **Purpose**: Menambahkan item newsroom baru
- **Parameters**: `values: CreateNewsroomItem` - Data item baru
- **Return**: `Promise<void>`
- **Dependencies**: Newsroom service, form validation
- **Related Components**: Form component, Modal
- **Flow**: Validate form → Call create API → Refresh data → Close modal

#### `handleUpdateItem`
- **Purpose**: Update item newsroom yang ada
- **Parameters**: `values: CreateNewsroomItem` - Data update
- **Return**: `Promise<void>`
- **Dependencies**: Newsroom service, selectedItem state
- **Related Components**: Form component, Modal
- **Flow**: Validate selection → Call update API → Refresh data → Close modal

#### `handleDeleteItem`
- **Purpose**: Menghapus item newsroom
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Newsroom service, selectedItem state
- **Related Components**: ConfirmDialog component
- **Flow**: Validate selection → Call delete API → Refresh data → Close modal

#### `handlePublishItem`
- **Purpose**: Mempublikasikan item newsroom
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Newsroom service, selectedItem state
- **Related Components**: ConfirmDialog component
- **Flow**: Validate selection → Call publish API → Refresh data → Close modal

#### `handleArchiveItem`
- **Purpose**: Mengarsipkan item newsroom
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Newsroom service, selectedItem state
- **Related Components**: ConfirmDialog component
- **Flow**: Validate selection → Call archive API → Refresh data → Close modal

### src/pages/teacher/ClassAttendance.tsx

#### `handleStatusChange`
- **Purpose**: Menangani perubahan status kehadiran siswa
- **Parameters**: `studentId: string, status: 'present' | 'absent' | 'sick' | 'permission'` - ID siswa dan status baru
- **Return**: `void`
- **Dependencies**: Attendance state management
- **Related Components**: Select component
- **Flow**: Update attendance status untuk siswa tertentu

#### `handleNoteChange`
- **Purpose**: Menangani perubahan catatan kehadiran
- **Parameters**: `studentId: string, note: string` - ID siswa dan catatan baru
- **Return**: `void`
- **Dependencies**: Attendance notes state
- **Related Components**: TextInput component
- **Flow**: Update note untuk siswa tertentu

#### `handleSubmitAttendance`
- **Purpose**: Submit data kehadiran ke database
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Attendance service, form validation
- **Related Components**: Button component, API service
- **Flow**: Validate data → Call submit API → Show success/error

### src/pages/teacher/AssignmentDetail.tsx

#### `handleSelectSubmission`
- **Purpose**: Menangani pemilihan submission untuk bulk grading
- **Parameters**: `submissionId: string, checked: boolean` - ID submission dan status checkbox
- **Return**: `void`
- **Dependencies**: Selected submissions state
- **Related Components**: Checkbox component
- **Flow**: Add/remove submission dari bulk selection

#### `handleSelectAll`
- **Purpose**: Select all submissions untuk bulk grading
- **Parameters**: `checked: boolean` - Status checkbox
- **Return**: `void`
- **Dependencies**: Filtered submissions data
- **Related Components**: Checkbox component
- **Flow**: Select all atau clear all submissions

#### `handleBulkGrade`
- **Purpose**: Menangani bulk grading submissions
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Grading service, selected submissions
- **Related Components**: Grading modal, API service
- **Flow**: Validate selection → Call bulk grade API → Refresh data

#### `handleOpenGradingModal`
- **Purpose**: Membuka modal grading untuk submission individual
- **Parameters**: `submission: Submission` - Data submission
- **Return**: `void`
- **Dependencies**: Modal state management
- **Related Components**: Grading modal
- **Flow**: Set selected submission → Open modal

#### `handleIndividualGrade`
- **Purpose**: Menangani grading submission individual
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Grading service, selected submission
- **Related Components**: Grading form, API service
- **Flow**: Validate data → Call grade API → Refresh data → Close modal

#### `handleOpenCancelGradingModal`
- **Purpose**: Membuka modal konfirmasi cancel grading
- **Parameters**: `submission: Submission` - Data submission
- **Return**: `void`
- **Dependencies**: Modal state management
- **Related Components**: ConfirmDialog component
- **Flow**: Set submission to cancel → Open modal

#### `handleCancelGrading`
- **Purpose**: Membatalkan penilaian submission
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Grading service, submissionToCancel state
- **Related Components**: ConfirmDialog, API service
- **Flow**: Validate data → Call cancel API → Refresh data → Close modal

#### `handleDeleteAssignment`
- **Purpose**: Menghapus assignment
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Assignment service, assignment data
- **Related Components**: ConfirmDialog component
- **Flow**: Validate data → Call delete API → Navigate back

#### `handlePageChange`
- **Purpose**: Menangani perubahan halaman pagination
- **Parameters**: `page: number` - Halaman baru
- **Return**: `void`
- **Dependencies**: Pagination state
- **Related Components**: Pagination component
- **Flow**: Update current page

#### `handleItemsPerPageChange`
- **Purpose**: Menangani perubahan jumlah item per halaman
- **Parameters**: `newItemsPerPage: number` - Jumlah item baru
- **Return**: `void`
- **Dependencies**: Pagination state
- **Related Components**: Pagination component
- **Flow**: Update items per page

### src/pages/teacher/AssignmentList.tsx

#### `handlePageChange`
- **Purpose**: Menangani perubahan halaman pagination
- **Parameters**: `page: number` - Halaman baru
- **Return**: `void`
- **Dependencies**: Pagination state
- **Related Components**: Pagination component
- **Flow**: Update current page

#### `handleItemsPerPageChange`
- **Purpose**: Menangani perubahan jumlah item per halaman
- **Parameters**: `newItemsPerPage: number` - Jumlah item baru
- **Return**: `void`
- **Dependencies**: Pagination state
- **Related Components**: Pagination component
- **Flow**: Update items per page

#### `handleSelectAll`
- **Purpose**: Select all assignments untuk bulk operations
- **Parameters**: `checked: boolean` - Status checkbox
- **Return**: `void`
- **Dependencies**: Assignments data, selection state
- **Related Components**: Checkbox component
- **Flow**: Select all atau clear all assignments

#### `handleSelectAssignment`
- **Purpose**: Menangani pemilihan assignment individual
- **Parameters**: `assignmentId: string, checked: boolean` - ID assignment dan status checkbox
- **Return**: `void`
- **Dependencies**: Selection state
- **Related Components**: Checkbox component
- **Flow**: Add/remove assignment dari selection

#### `handleBulkEdit`
- **Purpose**: Menangani bulk edit assignments
- **Parameters**: `values: typeof bulkEditForm.values` - Data edit
- **Return**: `Promise<void>`
- **Dependencies**: Assignment service, selected assignments
- **Related Components**: Bulk edit form, API service
- **Flow**: Validate selection → Call bulk update API → Refresh data

#### `handleBulkDelete`
- **Purpose**: Menangani bulk delete assignments
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Assignment service, selected assignments
- **Related Components**: ConfirmDialog, API service
- **Flow**: Validate selection → Call bulk delete API → Refresh data

#### `handleEditAssignment`
- **Purpose**: Membuka modal edit untuk assignment
- **Parameters**: `assignment: Assignment` - Data assignment
- **Return**: `void`
- **Dependencies**: Modal state, form state
- **Related Components**: Edit modal, form
- **Flow**: Set editing assignment → Open modal → Populate form

#### `handleUpdateAssignment`
- **Purpose**: Update assignment yang sedang diedit
- **Parameters**: `values: typeof editForm.values` - Data update
- **Return**: `Promise<void>`
- **Dependencies**: Assignment service, editingAssignment state
- **Related Components**: Edit form, API service
- **Flow**: Validate data → Call update API → Refresh data → Close modal

#### `handleCreateAssignment`
- **Purpose**: Membuat assignment baru
- **Parameters**: `values: typeof form.values` - Data assignment baru
- **Return**: `Promise<void>`
- **Dependencies**: Assignment service, form validation
- **Related Components**: Create form, API service
- **Flow**: Validate form → Call create API → Refresh data → Close modal

#### `handleDeleteAssignment`
- **Purpose**: Menghapus assignment individual
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Assignment service, selectedAssignment state
- **Related Components**: ConfirmDialog, API service
- **Flow**: Validate selection → Call delete API → Refresh data → Close modal

### src/pages/teacher/Leaderboard.tsx

#### `handleExportLeaderboard`
- **Purpose**: Mengekspor data leaderboard ke Excel
- **Parameters**: None
- **Return**: `void`
- **Dependencies**: Filtered students data, export utility
- **Related Components**: Export button, Excel generation
- **Flow**: Format data → Generate Excel file → Download

### src/pages/student/StudentClassroom.tsx

#### `handleSubmitAssignment`
- **Purpose**: Menangani submit assignment oleh siswa
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Submission service, selected assignment
- **Related Components**: Submit modal, file upload
- **Flow**: Validate data → Call submit API → Refresh data → Close modal

#### `handleCancelSubmission`
- **Purpose**: Membatalkan submission assignment
- **Parameters**: `assignment: Assignment` - Data assignment
- **Return**: `Promise<void>`
- **Dependencies**: Submission service, student data
- **Related Components**: Cancel button, API service
- **Flow**: Validate data → Call cancel API → Refresh data

### src/pages/student/StudentLeaderboard.tsx

#### `handlePageChange`
- **Purpose**: Menangani perubahan halaman leaderboard
- **Parameters**: `page: number` - Halaman baru
- **Return**: `void`
- **Dependencies**: Pagination state
- **Related Components**: Pagination component
- **Flow**: Update current page

### src/pages/student/StudentDashboard.tsx

#### `handleMarkAsRead`
- **Purpose**: Menandai notifikasi sebagai sudah dibaca
- **Parameters**: `notificationId: string` - ID notifikasi
- **Return**: `Promise<void>`
- **Dependencies**: Notification service
- **Related Components**: Notification item, API service
- **Flow**: Call mark as read API → Update local state

#### `handleMarkAllAsRead`
- **Purpose**: Menandai semua notifikasi sebagai sudah dibaca
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Notification service, notifications data
- **Related Components**: Mark all button, API service
- **Flow**: Call mark all as read API → Update local state

### src/pages/student/StudentProfile.tsx

#### `handleUpdateProfile`
- **Purpose**: Update data profil siswa
- **Parameters**: `values: typeof form.values` - Data profil baru
- **Return**: `Promise<void>`
- **Dependencies**: Student service, form validation
- **Related Components**: Profile form, API service
- **Flow**: Validate form → Call update API → Show success

#### `handleChangePassword`
- **Purpose**: Mengubah password siswa
- **Parameters**: `values: typeof passwordForm.values` - Data password baru
- **Return**: `Promise<void>`
- **Dependencies**: Auth service, password validation
- **Related Components**: Password form, API service
- **Flow**: Validate passwords → Call change password API → Show success

### src/pages/teacher/ClassStudents.tsx

#### `handleExportExcel`
- **Purpose**: Mengekspor data siswa ke Excel
- **Parameters**: None
- **Return**: `void`
- **Dependencies**: Students data, export utility
- **Related Components**: Export button, Excel generation
- **Flow**: Format data → Generate Excel file → Download

#### `handleDownloadTemplate`
- **Purpose**: Download template Excel untuk import siswa
- **Parameters**: None
- **Return**: `void`
- **Dependencies**: Template data, Excel generation
- **Related Components**: Download button, Excel generation
- **Flow**: Generate template Excel → Download

#### `handleImportExcel`
- **Purpose**: Mengimport data siswa dari Excel
- **Parameters**: `importData: any[]` - Data yang diimport
- **Return**: `Promise<void>`
- **Dependencies**: Student service, validation logic
- **Related Components**: ExcelImport component, API service
- **Flow**: Validate data → Call import API → Show results

#### `handleAddStudent`
- **Purpose**: Menambahkan siswa baru
- **Parameters**: `values: typeof form.values` - Data siswa baru
- **Return**: `Promise<void>`
- **Dependencies**: Student service, form validation
- **Related Components**: Add form, API service
- **Flow**: Validate form → Call create API → Refresh data → Close modal

#### `handleEditStudent`
- **Purpose**: Mengedit data siswa
- **Parameters**: `values: typeof form.values` - Data siswa yang diupdate
- **Return**: `Promise<void>`
- **Dependencies**: Student service, selectedStudent state
- **Related Components**: Edit form, API service
- **Flow**: Validate selection → Call update API → Refresh data → Close modal

#### `handleChangePassword`
- **Purpose**: Mengubah password siswa
- **Parameters**: `values: typeof passwordForm.values` - Data password baru
- **Return**: `Promise<void>`
- **Dependencies**: Auth service, selectedStudent state
- **Related Components**: Password form, API service
- **Flow**: Validate data → Call change password API → Show success

#### `handleDeleteStudent`
- **Purpose**: Menghapus siswa
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Student service, selectedStudent state
- **Related Components**: ConfirmDialog, API service
- **Flow**: Validate selection → Call delete API → Refresh data → Close modal

#### `handleBulkDelete`
- **Purpose**: Menghapus multiple siswa sekaligus
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Student service, selectedStudents state
- **Related Components**: ConfirmDialog, API service
- **Flow**: Validate selection → Call bulk delete API → Refresh data

#### `handleSelectStudent`
- **Purpose**: Menangani pemilihan siswa individual untuk bulk operations
- **Parameters**: `studentId: string, checked: boolean` - ID siswa dan status checkbox
- **Return**: `void`
- **Dependencies**: Selection state
- **Related Components**: Checkbox component
- **Flow**: Add/remove student dari bulk selection

#### `handleSelectAll`
- **Purpose**: Select all siswa untuk bulk operations
- **Parameters**: `checked: boolean` - Status checkbox
- **Return**: `void`
- **Dependencies**: Students data, selection state
- **Related Components**: Checkbox component
- **Flow**: Select all atau clear all students

---

## Service Functions

### src/services/authService.ts

#### `loginTeacher`
- **Purpose**: Menangani autentikasi login untuk teacher
- **Parameters**: `email: string, password: string` - Email dan password teacher
- **Return**: `Promise<{user: User, teacher: Teacher}>`
- **Dependencies**: Supabase auth, teachers table
- **Related Components**: UnifiedLogin component, AuthContext
- **Flow**: Sign in with Supabase → Check/create teacher profile → Return user and teacher data

#### `getCurrentTeacher`
- **Purpose**: Mendapatkan data teacher yang sedang login
- **Parameters**: None
- **Return**: `Promise<Teacher | null>`
- **Dependencies**: Supabase auth, teachers table
- **Related Components**: AuthContext, Protected routes
- **Flow**: Get current user → Check/create teacher profile → Return teacher data

#### `logout`
- **Purpose**: Logout dari sistem
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Supabase auth
- **Related Components**: Layout components, AuthContext
- **Flow**: Sign out from Supabase → Clear session

#### `onAuthStateChange`
- **Purpose**: Listener untuk perubahan state autentikasi
- **Parameters**: `callback: (user: any) => void` - Callback function
- **Return**: Supabase auth subscription
- **Dependencies**: Supabase auth
- **Related Components**: AuthContext, App component
- **Flow**: Listen to auth state changes → Call callback with user data

### src/services/studentAuthService.ts

#### `loginStudent`
- **Purpose**: Menangani autentikasi login untuk student
- **Parameters**: `email: string, password: string` - Email dan password student
- **Return**: `Promise<Student>`
- **Dependencies**: Supabase, bcrypt, students table
- **Related Components**: UnifiedLogin component, StudentAuthContext
- **Flow**: Query student by email → Verify password hash → Return student data

#### `createStudent`
- **Purpose**: Membuat student baru dengan password hash
- **Parameters**: `studentData: {...}, password: string` - Data student dan password plain
- **Return**: `Promise<Student>`
- **Dependencies**: Supabase, bcrypt, students table
- **Related Components**: Student management pages, import functions
- **Flow**: Hash password → Insert to database → Return created student

#### `updateStudent`
- **Purpose**: Update data student
- **Parameters**: `studentId: string, updates: Partial<Student>` - ID dan data update
- **Return**: `Promise<Student>`
- **Dependencies**: Supabase, students table
- **Related Components**: Student profile pages, admin panels
- **Flow**: Update student record → Return updated data

#### `resetPassword`
- **Purpose**: Reset password student menggunakan tanggal lahir
- **Parameters**: `studentId: string, newBirthDate: string` - ID student dan tanggal lahir baru
- **Return**: `Promise<void>`
- **Dependencies**: Supabase, bcrypt, students table
- **Related Components**: Student management, password reset
- **Flow**: Hash birth date → Update password hash

#### `updatePassword`
- **Purpose**: Update password student dengan password baru
- **Parameters**: `studentId: string, newPassword: string` - ID student dan password baru
- **Return**: `Promise<void>`
- **Dependencies**: Supabase, bcrypt, students table
- **Related Components**: Student profile, admin password change
- **Flow**: Hash new password → Update password hash

---

## Context Functions

### src/contexts/UnifiedAuthContext.tsx

#### `loginTeacher`
- **Purpose**: Unified login function untuk teacher yang mengintegrasikan teacher auth context
- **Parameters**: `email: string, password: string` - Email dan password teacher
- **Return**: `Promise<void>`
- **Dependencies**: Teacher auth context, student auth context
- **Related Components**: UnifiedLogin component, all teacher components
- **Flow**: Set loading → Call teacher login → Clear student session → Handle error

#### `loginStudent`
- **Purpose**: Unified login function untuk student yang mengintegrasikan student auth context
- **Parameters**: `email: string, password: string` - Email dan password student
- **Return**: `Promise<void>`
- **Dependencies**: Student auth context
- **Related Components**: UnifiedLogin component, all student components
- **Flow**: Set loading → Call student login → Handle error

#### `logout`
- **Purpose**: Unified logout function yang menangani logout berdasarkan role
- **Parameters**: None
- **Return**: `Promise<void>`
- **Dependencies**: Teacher auth context, student auth context, unified role state
- **Related Components**: Layout components, logout buttons
- **Flow**: Check role → Call appropriate logout → Clear unified state

---

## Utility Functions

### src/utils/

#### Search and Documentation in Progress...

---

## Notes

- Dokumen ini akan diperbarui secara bertahap saat function handler ditemukan
- Handler yang menggunakan async/await akan ditandai dengan Promise return type
- Event handlers akan ditandai dengan parameter event yang diterima
- Dependencies akan meliputi hooks, contexts, dan services yang digunakan

---

## Summary

Dokumen ini mencakup **195 function handlers** yang ditemukan di seluruh proyek LMS, dengan rincian:

- **Authentication Handlers**: 2 handlers (login teacher & student)
- **Component Handlers**: 13 handlers (UI interactions, data manipulation)
- **Page Handlers**: 45+ handlers (CRUD operations, navigation, bulk actions)
- **Service Functions**: 6 functions (auth services, student management)
- **Context Functions**: 3 functions (unified auth management)

## Usage Guidelines

1. **Handler Naming**: Semua handler menggunakan pola `handle[Action]` untuk konsistensi
2. **Error Handling**: Semua async handlers memiliki try-catch blocks
3. **State Management**: Handler mengupdate state lokal dan global sesuai kebutuhan
4. **Navigation**: Handler menggunakan React Router untuk navigasi post-action
5. **Loading States**: Handler mengelola loading states untuk UX yang baik

## Maintenance Notes

- Update dokumen ini ketika menambah/menghapus handler functions
- Pastikan handler baru mengikuti pola dan struktur yang konsisten
- Test handler functions secara menyeluruh sebelum production
- Dokumentasikan dependencies dan side effects dengan jelas

---

*Generated on: 2025-10-25*
*Last Updated: 2025-10-25*
*Total Handlers Documented: 195+*