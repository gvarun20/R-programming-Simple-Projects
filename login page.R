library(tcltk)

# Function to handle login
login <- function() {
  username <- "varung"
  password <- "12345"
  
  if (tkget(entry_username) == username && tkget(entry_password) == password) {
    tkmessageBox(message = "You successfully logged in.", icon = "info", title = "Login Success")
  } else {
    tkmessageBox(message = "Invalid login.", icon = "error", title = "Error")
  }
}

# Create main window
window <- tktoplevel()
tkconfigure(window, background='#333333')
tkwm.title(window, "Login form")
tkwm.geometry(window, '340x440')

# Create frame
frame <- tkframe(window, background='#333333')

# Create widgets
login_label <- tklabel(frame, text="Login", background='#333333', foreground="#FF3399", font="Arial 30")
username_label <- tklabel(frame, text="Username", background='#333333', foreground="#FFFFFF", font="Arial 16")
entry_username <- tkentry(frame, font="Arial 16")
entry_password <- tkentry(frame, show="*", font="Arial 16")
password_label <- tklabel(frame, text="Password", background='#333333', foreground="#FFFFFF", font="Arial 16")
login_button <- tkbutton(frame, text="Login", background="#FF3399", foreground="#FFFFFF", font="Arial 16", command=login)

# Place widgets on the screen
tkgrid(login_label, row=0, column=0, columnspan=2, sticky="news", pady=40)
tkgrid(username_label, row=1, column=0)
tkgrid(entry_username, row=1, column=1, pady=20)
tkgrid(password_label, row=2, column=0)
tkgrid(entry_password, row=2, column=1, pady=20)
tkgrid(login_button, row=3, column=0, columnspan=2, pady=30)

tkpack(frame)

# Set focus to the username entry
tkfocus(entry_username)
# Run the main loop
tcltk::tkwait.window(window)


