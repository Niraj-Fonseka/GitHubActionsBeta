package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Saying Hello world")
		fmt.Fprintf(w, "HelloWorld")
	})

	http.HandleFunc("/test_two", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Saying test two")
		fmt.Fprintf(w, "Test Two ")
	})

	fmt.Println("Running App : ")
	http.ListenAndServe(":8080", nil)
}
