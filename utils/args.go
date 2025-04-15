package utils

import "os"

func GetFileName() string {
	fileName := os.Args[1]
	if fileName == "" {
		panic("Please Provide File Name As An Argument")
	}

	return fileName
}
