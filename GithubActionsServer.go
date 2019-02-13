package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/githubactions", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello From GitHub Actions")
	})

	http.ListenAndServe(":8080", nil)
}
