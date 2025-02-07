#!/bin/bash

for file in dredg*.lua; do
    perl -0777 -pe '
        use strict;
        use warnings;

        # Recursive regex pattern to match balanced braces
        my $braces_re = qr/
            \{
            (?:
                [^{}]++       # Non-brace characters
                |
                (?0)          # Recursive call for nested braces
            )*
            \}
        /x;

        # Pattern to match the outer table, accounting for extra nesting
        s{
            (
                \{\s*                             # Opening brace of array element
                \{                                # Opening brace of outer table
                \s*
                filename \s* = \s* [^,}]+ ,      # Match filename = ..., up to comma or }
                (?:
                    [^{}]*+                       # Non-brace content
                    |
                    (?0)                          # Nested braces
                )*?
                hr_version \s* = \s*
            )
            ($braces_re)                          # Capture inner table
            (?:
                (?:
                    [^{}]*+                       # Any content after hr_version
                    |
                    (?0)                          # Nested braces
                )*?
            )
            \s*
            \}                                    # Closing brace of outer table
            \s*
            \}                                    # Closing brace of array element
        }
        {
            "{\n$2\n}"                            # Replace with the inner table wrapped in braces
        }xgs;
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done
