WMENU(1)

# NAME

wmenu - dynamic menu for Wayland

# SYNOPSIS

*wmenu* [-biPv] \
  [-f _font_] \
  [-l _lines_] \
  [-o _output_] \
  [-p _prompt_] \
  [-N _color_] [-n _color_] \
  [-M _color_] [-m _color_] \
  [-S _color_] [-s _color_]

*wmenu-run* ...

# DESCRIPTION

*wmenu* is a dynamic menu for Wayland, which reads a list of newline-separated
items from stdin. When the user selects an item and presses Return, their choice
is printed to stdout and wmenu terminates. Entering text will narrow the items
to those matching the tokens in the input.

*wmenu-run* is a special invocation of wmenu which lists programs in the user's
$PATH and runs the result.

# OPTIONS

*-b*
	wmenu appears at the bottom of the screen.

*-i*
	wmenu matches menu items case insensitively.

*-P*
	wmenu will not directly display the keyboard input, but instead replace it
	with asterisks.

*-v*
	prints version information to stdout, then exits.

*-f* _font_
	defines the font used. For more information, see
	https://docs.gtk.org/Pango/type_func.FontDescription.from_string.html

*-l* _lines_
	wmenu lists items vertically, with the given number of lines.

*-o* _output_
	wmenu is displayed on the output with the given name.

*-p* _prompt_
	defines the prompt to be displayed to the left of the input field.

*-N* _RRGGBB[AA]_
	defines the normal background color.

*-n* _RRGGBB[AA]_
	defines the normal foreground color.

*-M* _RRGGBB[AA]_
	defines the prompt background color.

*-m* _RRGGBB[AA]_
	defines the prompt foreground color.

*-S* _RRGGBB[AA]_
	defines the selection background color.

*-s* _RRGGBB[AA]_
	defines the selection foreground color.

# USAGE

wmenu is completely controlled by the keyboard. Items are selected using the
arrow keys, page up, page down, home, and end.

*Tab*
	Copy the selected item to the input field.

*Return*
	Confirm selection. Prints the selected item to stdout and exits, returning
	success.

*Ctrl-Return*
	Confirm selection. Prints the selected item to stdout and continues.

*Shift-Return*
	Confirm input. Prints the input text to stdout and exits, returning success.

*Escape*
	Exit without selecting an item, returning failure.

*Ctrl-Left*
	Move cursor to the start of the current word.

*Ctrl-Right*
	Move cursor to the end of the current word.

|[ *C-a*
:< Home

|[ *C-b*
:< Left

|[ *C-c*
:< Escape

|[ *C-d*
:< Delete

|[ *C-e*
:< End

|[ *C-f*
:< Right

|[ *C-g*
:< Escape

|[ *C-[*
:< Escape

|[ *C-h*
:< Backspace

|[ *C-i*
:< Tab

|[ *C-j*
:< Return

|[ *C-J*
:< Shift-Return

|[ *C-k*
:< Delete line right

|[ *C-m*
:< Return

|[ *C-M*
:< Shift-Return

|[ *C-n*
:< Down

|[ *C-p*
:< Up

|[ *C-u*
:< Delete line left

|[ *C-w*
:< Delete word left

|[ *C-Y*
:< Paste from Wayland clipboard

|[ *M-b*
:< Move cursor to the start of the current word

|[ *M-f*
:< Move cursor to the end of the current word

|[ *M-g*
:< Home

|[ *M-G*
:< End

|[ *M-h*
:< Up

|[ *M-j*
:< Page down

|[ *M-k*
:< Page up

|[ *M-l*
:< Down

