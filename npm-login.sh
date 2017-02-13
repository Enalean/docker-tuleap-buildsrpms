#!/usr/bin/expect
set timeout 10

set username [lindex $argv 0]
set password [lindex $argv 1]
set email [lindex $argv 2]

spawn npm login

expect "Username:"
send "$username\n";

expect "Password:"
send "$password\n";

expect "Email: (this IS public)"
send "$email\n";

expect eof
