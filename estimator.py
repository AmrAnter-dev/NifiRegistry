
from datetime import datetime
import math
import flet as ft


def calculate_hemodialysis_sessions(
    start_date_str: str,
    end_date_str: str
) -> dict:
    """
    Validate dates and calculate the estimated number of hemodialysis sessions.
    """

    try:
        start_date = datetime.strptime(
            start_date_str.strip(), "%d-%m-%Y"
        )
    except ValueError:
        raise ValueError(
            "Invalid Start Date. Please use DD-MM-YYYY."
        )

    try:
        end_date = datetime.strptime(
            end_date_str.strip(), "%d-%m-%Y"
        )
    except ValueError:
        raise ValueError(
            "Invalid End Date. Please use DD-MM-YYYY."
        )

    if start_date > end_date:
        raise ValueError(
            "Start Date must not be later than End Date."
        )

    total_days = (end_date - start_date).days + 1

    weeks = total_days // 7
    remaining_days = total_days % 7

    estimated_sessions = math.ceil(total_days * 3 / 7)

    return {
        "start_date": start_date.strftime("%d-%m-%Y"),
        "end_date": end_date.strftime("%d-%m-%Y"),
        "total_days": total_days,
        "weeks": weeks,
        "remaining_days": remaining_days,
        "estimated_sessions": estimated_sessions,
    }


def main(page: ft.Page):

    # =====================================================
    # Page Configuration
    # =====================================================

    page.title = "Hemodialysis Session Estimator"

    # Transparent background
    page.bgcolor = ft.Colors.TRANSPARENT
    page.window.bgcolor = ft.Colors.TRANSPARENT

    # Remove window frame and title bar
    page.window.frameless = True
    page.window.title_bar_hidden = True

     # Window Size
    page.window.width = 460
    page.window.height = 580
    page.window.resizable = False

    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    page.theme_mode = ft.ThemeMode.LIGHT

    # Default dates
    default_start = datetime(2026, 1, 1)
    default_end = datetime(2026, 1, 31)

    # =====================================================
    # Input Fields
    # =====================================================

    start_input = ft.TextField(
        label="Start Date (DD-MM-YYYY)",
        value=default_start.strftime("%d-%m-%Y"),
        read_only=True,
        expand=True,
        border_radius=8,
    )

    end_input = ft.TextField(
        label="End Date (DD-MM-YYYY)",
        value=default_end.strftime("%d-%m-%Y"),
        read_only=True,
        expand=True,
        border_radius=8,
    )

    # =====================================================
    # Result Labels
    # =====================================================

    lbl_start = ft.Text("Start Date: -", size=13)
    lbl_end = ft.Text("End Date: -", size=13)

    lbl_total_days = ft.Text(
        "Total Days (Inclusive): -",
        size=13,
    )

    lbl_duration = ft.Text(
        "Equivalent Duration: -",
        size=13,
    )

    lbl_sessions = ft.Text(
        "Estimated Sessions: -",
        size=15,
        weight=ft.FontWeight.BOLD,
        color=ft.Colors.BLUE_700,
    )

    # =====================================================
    # Dialog
    # =====================================================

    error_dialog = ft.AlertDialog(
        modal=True,
        title=ft.Text("Input Error"),
        content=ft.Text(""),
        actions=[
            ft.TextButton(
                "OK",
                on_click=lambda e: close_error_dialog(),
            )
        ],
    )

    def close_error_dialog():
        error_dialog.open = False
        page.update()

    page.overlay.append(error_dialog)

    def show_error(message: str):
        error_dialog.content = ft.Text(message)
        error_dialog.open = True
        page.update()

    # =====================================================
    # Date Picker Callbacks
    # =====================================================
   
    
    def update_start(e):
        if e.data:
            selected_date = e.data

            if isinstance(selected_date, str):
                selected_date = datetime.fromisoformat(selected_date)

            start_input.value = selected_date.astimezone().strftime("%d-%m-%Y")
            start_input.update()




    
    def update_end(e):
        if e.data:
            selected_date = e.data

            if isinstance(selected_date, str):
                selected_date = datetime.fromisoformat(selected_date)

            end_input.value = selected_date.astimezone().strftime("%d-%m-%Y")
            end_input.update()






    start_picker = ft.DatePicker(
        first_date=datetime(2000, 1, 1),
        last_date=datetime(2100, 12, 31),
        value=default_start,
        on_change=update_start,
    )

    end_picker = ft.DatePicker(
        first_date=datetime(2000, 1, 1),
        last_date=datetime(2100, 12, 31),
        value=default_end,
        on_change=update_end,
    )

    page.overlay.extend([start_picker, end_picker])

    # =====================================================
    # Calculate
    # =====================================================

    def on_calculate(e):

        try:
            result = calculate_hemodialysis_sessions(
                start_input.value or "",
                end_input.value or "",
            )

            lbl_start.value = (
                f"Start Date: {result['start_date']}"
            )

            lbl_end.value = (
                f"End Date: {result['end_date']}"
            )

            lbl_total_days.value = (
                "Total Days (Inclusive): "
                f"{result['total_days']}"
            )

            lbl_duration.value = (
                "Equivalent Duration: "
                f"{result['weeks']} weeks and "
                f"{result['remaining_days']} days"
            )

            lbl_sessions.value = (
                "Estimated Sessions: "
                f"{result['estimated_sessions']} sessions"
            )

            page.update()

        except ValueError as err:
            show_error(str(err))

    # =====================================================
    # Clear
    # =====================================================

    def on_clear(e):

        start_input.value = ""
        end_input.value = ""

        lbl_start.value = "Start Date: -"
        lbl_end.value = "End Date: -"

        lbl_total_days.value = "Total Days (Inclusive): -"
        lbl_duration.value = "Equivalent Duration: -"
        lbl_sessions.value = "Estimated Sessions: -"

        page.update()

    # =====================================================
    # Open Date Pickers
    # =====================================================

   
    def open_start_picker(e):
        page.show_dialog(start_picker)

    def open_end_picker(e):
        page.show_dialog(end_picker)



    async def close_app(e):
        await page.window.close()

    # =====================================================
    # Main Layout
    # =====================================================

    page.add(
        ft.Card(
            
            content=ft.Container(
                bgcolor=ft.Colors.WHITE,
                border_radius=12,
                padding=20,
                content=ft.Column(
                    controls=[
                        # Draggable title bar + close button
                        ft.Row(
                            controls=[
                                ft.WindowDragArea(
                                    content=ft.Container(
                                        content=ft.Text(
                                            "Hemodialysis Estimator",
                                            size=18,
                                            weight=ft.FontWeight.BOLD,
                                        ),
                                        padding=ft.Padding(
                                        left=4,
                                        top=6,
                                        right=0,
                                        bottom=6,
                                    ),
                                    ),
                                    expand=True,
                                    maximizable=False,
                                ),
                                ft.IconButton(
                                    icon=ft.Icons.CLOSE,
                                    icon_color=ft.Colors.RED_600,
                                    tooltip="Close application",
                                    on_click=close_app,
                                ),
                            ],
                            alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
                            vertical_alignment=ft.CrossAxisAlignment.CENTER,
                            spacing=4,
                        ),

                        ft.Divider(),

                        # Start Date
                        ft.Row(
                            controls=[
                                start_input,
                                ft.IconButton(
                                    icon=ft.Icons.CALENDAR_MONTH,
                                    on_click=open_start_picker,
                                    tooltip="Select Start Date",
                                ),
                            ],
                            alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
                        ),

                        # End Date
                        ft.Row(
                            controls=[
                                end_input,
                                ft.IconButton(
                                    icon=ft.Icons.CALENDAR_MONTH,
                                    on_click=open_end_picker,
                                    tooltip="Select End Date",
                                ),
                            ],
                            alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
                        ),

                        # Action Buttons
                        ft.Row(
                            controls=[
                                ft.Button(
                                    content="Calculate",
                                    on_click=on_calculate,
                                    color=ft.Colors.WHITE,
                                    bgcolor=ft.Colors.BLUE,
                                    expand=True,
                                ),

                                ft.OutlinedButton(
                                    "Clear",
                                    on_click=on_clear,
                                    expand=True,
                                ),
                            ],
                            alignment=ft.MainAxisAlignment.SPACE_AROUND,
                        ),

                        ft.Divider(),

                        # Results
                        ft.Text(
                            "Calculation Results",
                            weight=ft.FontWeight.BOLD,
                            size=14,
                        ),

                        lbl_start,
                        lbl_end,
                        lbl_total_days,
                        lbl_duration,
                        lbl_sessions,

                        ft.Divider(),

                        # Disclaimer
                        ft.Text(
                            "Note: This application provides a "
                            "mathematical estimate based on an "
                            "average rate of 3 sessions per 7 days. "
                            "created by: "
                            "Dr amr anter",
                            size=9,
                            italic=True,
                            color=ft.Colors.GREY_700,
                            text_align=ft.TextAlign.CENTER,
                        ),
                    ],
                    tight=True,
                    spacing=12,
                    horizontal_alignment=ft.CrossAxisAlignment.STRETCH,
                ),
                # padding=20,
                # width=420,
            ),
            elevation=4,
        )
    )


if __name__ == "__main__":
    ft.run(main)

