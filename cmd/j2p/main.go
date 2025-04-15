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

func convertJPGToPNG(inputPath, outputPath string) error {
	// Open the JPG file
	inputFile, err := os.Open(inputPath)
	if err != nil {
		return err
	}
	defer inputFile.Close()

	// Decode the JPG
	img, err := jpeg.Decode(inputFile)
	if err != nil {
		return err
	}

	// Create the output PNG file
	outputFile, err := os.Create(outputPath)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	enc := &png.Encoder{
		CompressionLevel: png.BestCompression,
	}

	// Encode the image as PNG
	err = enc.Encode(outputFile, img)
	if err != nil {
		return err
	}

	return nil
}

func main() {
	// Example usage
	inputPath := utils.GetFileName()

	// Generate output path by changing extension
	outputPath := strings.TrimSuffix(inputPath, filepath.Ext(inputPath)) + ".png"

	err := convertJPGToPNG(inputPath, outputPath)
	if err != nil {
		fmt.Printf("Error converting image: %v\n", err)
		return
	}

	fmt.Printf("Successfully converted %s to %s\n", inputPath, outputPath)
}
