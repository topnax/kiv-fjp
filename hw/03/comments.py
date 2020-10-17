import sys


def main():
    state = 0
    buf = ""
    try:
        with open(sys.argv[1], 'r') as content_file:
            for line in content_file.readlines():  
                # read each line of the file     
                written = False
                for char in line:
                    # for every character of the line, do something according to the designed DFSA
                    if state == 0:
                        if char == '/':
                            # / not followed by another / should be written to stdout, store it into a buffer
                            buf = char
                            state = 1
                        else:
                            written = True
                            print(char, end='')
                    elif state == 1:
                        if char == '/':
                            state = 2
                        elif char == '*':
                            state = 3
                        else:
                            state = 0
                            buf += char
                            written = True
                            # print the char stored in the buffer
                            print(buf, end='')
                            buf = ""
                    elif state == 2:
                        if '\n' in char:
                            if written:
                                # append a new line if a char has been written on this line
                                print()
                                written = False
                            state = 0
                    elif state == 3:
                        buf = ""
                        if char == '*':
                            state = 4
                        pass    
                    elif state == 4:
                        if char ==  '/':
                            state = 0
                        else:
                            state = 3
    except IOError:
        print("File not accessible")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("File to be parsed not provided in program arguments")
    else:
        main()

