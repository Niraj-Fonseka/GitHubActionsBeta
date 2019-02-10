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
		fmt.Fprintf(w, "Test Two !")
	})

	http.HandleFunc("/test_three", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Saying test two")
		fmt.Fprintf(w, "Test Three")
	})

	http.HandleFunc("/test_four", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Saying test two")
		fmt.Fprintf(w, "Test Three")
	})

	http.HandleFunc("/test_five", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Saying test two")
		fmt.Fprintf(w, "Test Five")
	})

	fmt.Println("Running App : ")
	http.ListenAndServe(":8080", nil)
}
