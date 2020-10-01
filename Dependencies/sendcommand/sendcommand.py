from __future__ import print_function
import argparse
import socket
import rcon

# python 2 compatibility
try:
    input = raw_input
except NameError:
    pass

def main():
    # Parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("port", type=int)
    parser.add_argument("password")
    parser.add_argument("command")
    args = parser.parse_args()

    # Connect
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect(("127.0.0.1", args.port))

    try:
        # Log in
        result = rcon.login(sock, args.password)
        if not result:
            print("Incorrect Rcon Password")
            return
        # Run command
        response = rcon.command(sock, args.command)
        print(response)
    finally:
        sock.close()

if __name__ == '__main__':
    main()
