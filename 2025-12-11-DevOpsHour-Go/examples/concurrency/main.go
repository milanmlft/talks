package main

import (
	"fmt"
	"time"
)

func checkHealth(url string, results chan<- string) {
	time.Sleep(1 * time.Second)
	if url == "http://api2.com" {
		results <- fmt.Sprintf("%s: DOWN", url)
		return
	}
	results <- fmt.Sprintf("%s: UP", url)
}

func main() {
	services := []string{"http://api1.com", "http://api2.com", "http://api3.com"}
	results := make(chan string, len(services))

	for _, service := range services {
		fmt.Println("Checking ", service)
		go checkHealth(service, results) // Run health checks concurrently
	}

	for range services {
		fmt.Println(<-results) // Collect results
	}
}
