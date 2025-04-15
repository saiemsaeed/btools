package main

import (
	"fmt"
	"image/jpeg"
	"image/png"
	"os"
	"path/filepath"
	"strings"

	utils "github.com/saiemsaeed/btools/utils"
)

func convertPNGToJPG(inputPath, outputPath string) error {
	inputFile, err := os.Open(inputPath)
	if err != nil {
		return err
	}
	defer inputFile.Close()

	img, err := png.Decode(inputFile)
	if err != nil {
		return err
	}

	outputFile, err := os.Create(outputPath)

	err = jpeg.Encode(outputFile, img, nil)
	if err != nil {
		return err
	}

	return nil
}

func main() {
	inputPath := utils.GetFileName()
	// Generate output path by changing extension
	outputPath := strings.TrimSuffix(inputPath, filepath.Ext(inputPath)) + ".jpg"

	err := convertPNGToJPG(inputPath, outputPath)
	if err != nil {
		fmt.Printf("Error converting image: %v\n", err)
		return
	}

	fmt.Printf("Successfully converted %s to %s\n", inputPath, outputPath)
}
