You are an experienced Python software developer.

Build a small desktop application using Python and Tkinter to estimate the number of hemodialysis sessions required for a patient during a specified date range.

1. User Interface

Create a simple, clean desktop application with the following elements:

* Start Date: date input field.
* End Date: date input field.
* Calculate: button to calculate the estimated number of sessions.
* Clear: button to reset the inputs and results.
* Results section: display the calculation results clearly.

Use the date format DD-MM-YYYY. If a date picker requires an external package, explain how to install it.

2. Calculation Rules

The patient receives hemodialysis at an estimated rate of 3 sessions every 7 days.

* The start date and end date must both be included in the calculation.
* Calculate the total number of days using inclusive date counting.
* Calculate the estimated number of sessions using this formula:
    Estimated Sessions = Ceiling(Total Days × 3 / 7)
* Round the result up to the next whole number using Python’s math.ceil() function.
* Do not calculate sessions based on specific weekdays.
* Do not count only complete weeks.
* Do not use the current date as a default end date unless explicitly requested.

3. Input Validation

* Both dates are required.
* Dates must be valid calendar dates.
* The start date must not be later than the end date.
* Display a clear error message when the inputs are invalid.

4. Results

Display the following:

* Start date.
* End date.
* Total number of days, including both endpoints.
* Equivalent number of weeks and remaining days.
* Estimated total number of hemodialysis sessions.

5. Example for Testing

Use these values to verify the calculation:

* Start Date: 28-10-2026
* End Date: 31-12-2026
* Inclusive total days: 65
* Equivalent duration: 9 weeks and 2 days
* Calculation: ceil(65 × 3 / 7)
* Expected result: 28 estimated sessions

6. Code Quality

* Use Python and Tkinter.
* Keep the calculation logic separate from the GUI code.
* Create separate functions for date validation, session calculation, and result display.
* Use clear variable names, type hints, and appropriate exception handling.
* Avoid unnecessary dependencies.
* Provide the complete, runnable Python code in a single file.
* Explain how to install any required dependencies and run the application on Windows.

Important Note

This application provides a mathematical estimate based on an average rate of 3 sessions per 7 days. It does not determine the patient’s actual scheduled sessions or replace a clinically prescribed dialysis schedule.
