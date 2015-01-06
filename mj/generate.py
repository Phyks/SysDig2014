#!/usr/bin/env python3

import re
import sys

already_included = []


def compute_includes(file):
    with open(file, 'r') as fh:
        generated = fh.readlines()
    generated = [re.sub(r"#.*", "", i) for i in generated]
    generated = [re.sub(r"(\w+)\[(\d+)-(\d+)\]",
                        lambda m: ", ".join([m.group(1) + str(i)
                                             for i in range(int(m.group(2)),
                                                            int(m.group(3)))]),
                        i) for i in generated]
    generated = [re.sub(r"(\w+)\[(\d+)\.\.(\d+)\]",
                        lambda m: ", ".join([m.group(1) + "[" + str(i) + "]"
                                             for i in range(int(m.group(2)),
                                                            int(m.group(3)))]),
                        i) for i in generated]
    includes = {i: generated[i].replace('require', '').strip()
                for i in range(len(generated))
                if 'require' in generated[i]}
    for k, v in includes.items():
        if v in already_included:
            continue
        generated[k] = compute_includes(v)
    return ''.join(generated)


def main():
    if len(sys.argv) < 2:
        sys.exit("Usage: "+sys.argv[0]+" input_file")
    else:
        already_included.append(sys.argv[1])
        mj = compute_includes(sys.argv[1])
        print(mj)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit()
