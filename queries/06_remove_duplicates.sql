-- Query: Remove Duplicate Appointment Records
-- Description: Deletes duplicates based on patientid, appointmentday, and scheduledday, keeping the first record.
-- Goal: Clean dataset by removing exact duplicate appointments.
WITH duplicates AS (
  SELECT ctid,
    ROW_NUMBER() OVER (
      PARTITION BY patientid, appointmentday, scheduledday
      ORDER BY patientid
    ) AS row_number
  FROM appointments
)
delete from appointments a
using duplicates d
where a.ctid = d.ctid
and row_number > 1;

