package main

import (
	"fmt"
	"time"
)

func checkHealth(url string, results *[]string) {
	time.Sleep(1 * time.Second)
	if url == "http://api2.com" {
		*results = append(*results, fmt.Sprintf("%s: DOWN", url))
		return
	}
	*results = append(*results, fmt.Sprintf("%s: UP", url))
}

func main() {
	services := []string{"http://api1.com", "http://api2.com", "http://api3.com"}
	results := make([]string, 0, len(services))

	for _, service := range services {
		fmt.Println("Checking ", service)
		checkHealth(service, &results) // Run health checks sequentially
	}

	for _, res := range results {
		fmt.Println(res)
	}
}
