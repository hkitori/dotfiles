#!/usr/bin/expect -f

set prompt "#"
set address [lindex $argv 0]
set dev_name [lindex $argv 1]

spawn bluetoothctl
expect -re $prompt
send "remove $address\r"
sleep 1
expect -re $prompt
send "scan on\r"
sleep 1
send_user "\nscanning... start to pair your controller!\r"
sleep 3
expect "NEW"
sleep 1
send "pair $address\r"
expect "Pairing successful"
sleep 2
send "trust $address\r"
sleep 2
send "connect $address\r"
sleep 5
send "quit\r"
expect eof

