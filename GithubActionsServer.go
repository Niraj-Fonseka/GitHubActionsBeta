package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Saying Hello world")
		fmt.Fprintf(w, "Hello World from GithubActions")
	})

	http.HandleFunc("/hi", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Saying Hello world")
		fmt.Fprintf(w, "try /hello")
	})

	http.HandleFunc("/time", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Showing Time")
		fmt.Fprintf(w, time.Now().UTC().String())
	})

	fmt.Println("Running App : ")
	http.ListenAndServe(":8080", nil)
}
