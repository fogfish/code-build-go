#!/bin/sh
set -eu

cat <<EOF
==> test nodejs 12.x
EOF
node --version | grep 'v12' || exit 1

cat <<EOF
==> test typescript 3.x
EOF
tsc --version | grep '3.[0-9]' || exit 1

cat <<EOF
==> test ts-node 8.x
EOF
ts-node --version | grep 'v8' || exit 1

cat <<EOF
==> test aws-cdk 1.19.x
EOF
cdk --version | grep '1.19.[0-9]' || exit 1

cat <<EOF
==> test aws-cli 1.16.x
EOF
aws --version 2>&1 > /dev/null | grep 'aws-cli/1.16.[0-9]' || exit 1
aws --version 2>&1 > /dev/null | grep 'Python/2.7.[0-9]' || exit 1

cat > main.go <<EOF
package main

import "fmt"

func main() {
	fmt.Printf("hello, world\n")
}
EOF

go build -o main main.go
./main || exit 1