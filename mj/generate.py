#!/usr/bin/env python3

import re
import sys

already_included = []


def compute_includes(file):
    with open(file, 'r') as fh:
        generated = fh.readlines()
    # remove comments
    generated = [re.sub(r"#.*", "", i) for i in generated]
    
    def subfunction(pre, i_start, i_end, suff="", sep=("", "")):
        i_start = int(i_start)
        i_end = int(i_end) + 1
        return ", ".join([pre + sep[0] + str(i) + sep[1] + suff
                          for i in range(i_start, i_end)])

    # replace "foo[0-n]" by "foo0, foo1, …, foon"
    generated = [re.sub(r"(\w+)\[(\d+)-(\d+)\]",
                        lambda m: subfunction(m.group(1), m.group(2),
                                              m.group(3)),
                        string)
                 for string in generated]
    # replace "foo[0-n]:[bar]" by "foo0:[bar], foo1:[bar], …, foon:[bar]"
    generated = [re.sub(r"(\w+)\[(\d+)-(\d+)\](:\[\w\])",
                        lambda m: subfunction(m.group(1), m.group(2),
                                              m.group(3), suff=m.group(4)),
                        string)
                 for string in generated]
    # replace "foo[0..n]" by "foo[0], foo[1], …, foo[n]"
    generated = [re.sub(r"(\w+)\[(\d+)\.\.(\d+)\]",
                        lambda m: subfunction(m.group(1), m.group(2),
                                              m.group(3), sep=("[", "]")),
                        string)
                 for string in generated]

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
