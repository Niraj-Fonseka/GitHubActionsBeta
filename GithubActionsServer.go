package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Saying Hello world")
		fmt.Fprintf(w, "Hello World from GithubActions")
	})

	fmt.Println("Running App : ")
	http.ListenAndServe(":8080", nil)
}
