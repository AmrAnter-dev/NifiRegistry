import tkinter as tk
from tkinter import scrolledtext
import requests
import uuid
import threading

URL = "http://localhost:8000/chat"
DEFAULT_PHONE = "01027372729"


def send_message(event=None):
    message = entry.get("1.0", tk.END).strip()
    if not message:
        return

    phone_number = phone_entry.get().strip() or DEFAULT_PHONE

    append_message(f"You: {message}")
    entry.delete("1.0", tk.END)

    # زر الإرسال يتقفل لحد ما الرد يوصل
    send_button.config(state=tk.DISABLED, text="...جاري الإرسال")

    threading.Thread(
        target=_send_request,
        args=(message, phone_number),
        daemon=True,
    ).start()


def _send_request(message, phone_number):
    request_data = {
        "phone_number": phone_number,
        "message": message,
        "message_id": str(uuid.uuid4()),
    }

    server_message = None
    try:
        response = requests.post(URL, json=request_data, timeout=120)
        response.raise_for_status()
        try:
            data = response.json()
            server_message = data.get("message", str(data))
        except ValueError:
            server_message = response.text

    except requests.RequestException as e:
        server_message = f"Request error: {e}"

    # التحديث للـ UI لازم يرجع للـ main thread
    root.after(0, _on_response_received, server_message)


def _on_response_received(server_message):
    append_message(f"Server: {server_message}")
    send_button.config(state=tk.NORMAL, text="Send")


def append_message(text):
    chat.config(state=tk.NORMAL)
    chat.insert(tk.END, f"{text}\n\n")
    chat.see(tk.END)
    chat.config(state=tk.DISABLED)


# ---------------- GUI ----------------

root = tk.Tk()
root.title("AI Pharmacy")
root.geometry("700x650")

# رقم الهاتف (قابل للتعديل)
phone_frame = tk.Frame(root)
phone_frame.pack(fill=tk.X, padx=10, pady=(10, 0))

tk.Label(phone_frame, text="Phone:", font=("Arial", 11)).pack(side=tk.LEFT)
phone_entry = tk.Entry(phone_frame, font=("Arial", 11))
phone_entry.insert(0, DEFAULT_PHONE)
phone_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(5, 0))

# منطقة المحادثة
chat = scrolledtext.ScrolledText(
    root, wrap=tk.WORD, state=tk.DISABLED, font=("Arial", 12)
)
chat.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

# مربع كتابة الرسالة
entry = tk.Text(root, height=4, wrap=tk.WORD, font=("Arial", 12))
entry.pack(fill=tk.X, padx=10, pady=(0, 5))

# زر الإرسال
send_button = tk.Button(
    root, text="Send", command=send_message, font=("Arial", 11)
)
send_button.pack(pady=(0, 10))

# Ctrl + Enter للإرسال
entry.bind("<Control-Return>", send_message)

root.mainloop()
